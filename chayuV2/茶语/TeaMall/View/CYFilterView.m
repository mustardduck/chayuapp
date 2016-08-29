//
//  CYFilterView.m
//  TeaMall
//
//  Created by Chayu on 15/10/23.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYFilterView.h"
#import "CYFiterItemView.h"
@interface CYFilterView ()<CYFiterItemViewDelegate>
{
    NSMutableArray *dataArr;
    NSMutableArray *item_heightArr;
    NSMutableDictionary *params;
}
@property (weak, nonatomic) IBOutlet UIScrollView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *goodsNum;

- (IBAction)reset_click:(id)sender;
- (IBAction)confirm_click:(id)sender;
@end


@implementation CYFilterView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    
}
-(void)awakeFromNib
{
    params = [NSMutableDictionary dictionary];
    [params setObject:@"" forKey:@"seller"];
    [params setObject:@"" forKey:@"price"];
    [params setObject:@"" forKey:@"catid"];
    if (_catId.length) {
        [params setObject:_catId forKey:@"catid"];
    }
    item_heightArr = [[NSMutableArray alloc] init];
    dataArr = [[NSMutableArray alloc] init];
    [self loadTableViewData];
}

-(void)setCatId:(NSString *)catId
{
    _catId = catId;
     [params setObject:_catId forKey:@"catid"];
    [CYWebClient Post:@"CatArrgetCount" parametes:params success:^(id responObject) {
        _goodsNum.text = responObject;
    } failure:^(id error) {
        
    }];
}

-(void)loadTableViewData
{
//    NSString *url = @"http://app.chayu.alp/chayu/1.0/shiji/CatArr/lists";
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"返回结果：%@",responseObject);
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
    
    [CYWebClient Post:@"CatArrlists" parametes:nil success:^(id responObject) {
        [dataArr addObjectsFromArray:responObject];
        [self creatView];
    } failure:^(id error) {
        
    }];
    
}


-(void)creatView
{
    __block CGFloat contentsize_height = 0;
    for (int i = 0; i<[dataArr count]; i++) {
        NSMutableDictionary *item_heightDic = [NSMutableDictionary dictionary];
        NSDictionary *classInfo = dataArr[i];
        NSArray *titleArr = [classInfo objectForKey:@"list"];
        CYFiterItemView *view = [[[NSBundle mainBundle] loadNibNamed:@"CYFiterItemView" owner:nil options:nil] firstObject];
        view.catId = _catId;
        view.delegate = self;
        view.tag = 33000 +i;
        view.frame = CGRectMake(0,contentsize_height,_contentView.width,0);
        [_contentView addSubview:view];
        if (i == [dataArr count] - 1) {
            view.isLast = YES;
        }else{
            view.isLast = NO;
        }
        if (i==0 || i == [dataArr count]-1) {
            NSDictionary *firstInfo= @{@"title":@"",@"list":dataArr[i][@"list"]};;
            view.dataArr =  [NSArray arrayWithObject:firstInfo];
            
        }else{
            view.dataArr = titleArr;
        }
        view.indexPath = i;
        view.sectionTitle.text = [classInfo objectForKey:@"title"];
        CGFloat itemheight =[CYFiterItemView classicViewHeight:view.dataArr andislast:view.isLast];
        view.height  = itemheight;
        [item_heightDic setObject:@(YES) forKey:@"open"];
        [item_heightDic setObject:@(view.height) forKey:@"open_height"];
        [item_heightDic setObject:@(35.) forKey:@"close_height"];
        [item_heightArr addObject:item_heightDic];
        view.height = [[item_heightDic objectForKey:@"open_height"] floatValue];
        
        contentsize_height +=view.height;
        contentsize_height +=10;
    }
    
    _contentView.contentSize = CGSizeMake(SCREEN_WIDTH, contentsize_height);
}


- (IBAction)reset_click:(id)sender {
    for (int i = 0; i< [item_heightArr count]; i++) {
        CYFiterItemView *view = [_contentView viewWithTag:i+33000];
        view.typeLbl.text = @"";
        view.catId = @"";
        _goodsNum.text = @"0";
        [view.tableView reloadData];
    }

}

- (IBAction)confirm_click:(id)sender {
    if ([self.delegate respondsToSelector:@selector(selectWithData:)]) {
        [self.delegate selectWithData:params];
    }
}

#pragma mark -
#pragma mark CYFiterItemViewDelegate method
-(void)openOrCloseItemView:(NSInteger)index andView:(CYFiterItemView *)view
{
    
    CGFloat contentsize = 0.0f;
    for (int i = 0; i< [item_heightArr count]; i++) {
        CYFiterItemView *view = [_contentView viewWithTag:i+33000];
        NSMutableDictionary *itemheightInfo = item_heightArr[i];
        if (index == i) {
            BOOL open = [[itemheightInfo objectForKey:@"open"] boolValue];
            [itemheightInfo setObject:@(!open) forKey:@"open"];
            [self setImgTransform:open andView:view];
        }
        
        BOOL itemopen = [[itemheightInfo objectForKey:@"open"] boolValue];
        CGFloat itemHeight = 0.0f;
        if (itemopen) {
            itemHeight =[[itemheightInfo objectForKey:@"open_height"] floatValue];
        }else{
            itemHeight =[[itemheightInfo objectForKey:@"close_height"] floatValue];
            
        }
        view.y = contentsize;
        contentsize +=itemHeight+10;
        view.height = itemHeight;
    }
    _contentView.contentSize = CGSizeMake(SCREEN_WIDTH, contentsize);
}


-(void)setImgTransform:(BOOL)trans andView:(CYFiterItemView *)itemView
{
    if (trans) {
        [UIView animateWithDuration:0.25 animations:^{
            itemView.filterImg.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            itemView.filterImg.transform = CGAffineTransformMakeRotation(0);
        }];
    }
}

- (void)changesearchNum:(NSDictionary *)info andIndex:(NSInteger)index
{
//    if (_catId) {
//        [params setObject:_catId forKey:@"catid"];
//    }
    
    if (index == 0) {
        [params setObject:[info objectForKey:@"data"] forKey:@"seller"];
    }else if (index == 1){
        [params setObject:[info objectForKey:@"data"] forKey:@"catid"];
    }else{
         [params setObject:[info objectForKey:@"data"] forKey:@"price"];
    }
    
    
    
    [CYWebClient Post:@"CatArrgetCount" parametes:params success:^(id responObject) {
          _goodsNum.text = responObject;
    } failure:^(id error) {
        
    }];
}


@end
