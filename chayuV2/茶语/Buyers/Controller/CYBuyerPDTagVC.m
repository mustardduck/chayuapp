//
//  CYBuyerPDTagVC.m
//  茶语
//
//  Created by Leen on 16/6/27.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerPDTagVC.h"
#import "CYBuyerCategoryItemView.h"


@interface CYBuyerPDTagVC ()<CYBuyerCategoryItemViewDelegate>
{
    NSMutableArray *dataArr;
    NSMutableArray *item_heightArr;
    NSMutableDictionary *params;
}

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (weak, nonatomic) IBOutlet UIView *areaView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIView *textView;
@property (weak, nonatomic) IBOutlet UITextField *areaTxt;

@end

@implementation CYBuyerPDTagVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

-(void)loadTableViewData
{
    [CYWebClient Post:@"CatArrlists" parametes:nil success:^(id responObject) {
        [dataArr addObjectsFromArray:responObject];
        [self creatView];
    } failure:^(id error) {
        
    }];
}

-(void)creatView
{
    __block CGFloat contentsize_height = 40 - 1;
    for (int i = 0; i<[dataArr count]; i++) {
        NSMutableDictionary *item_heightDic = [NSMutableDictionary dictionary];
        NSDictionary *classInfo = dataArr[i];
        
        NSArray *titleArr = [classInfo objectForKey:@"list"];
        CYBuyerCategoryItemView *view = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerCategoryItemView" owner:nil options:nil] firstObject];
        view.catId = _catId;
        
        if(i == 0)
        {
            view.isAddLastBtn = YES;
        }
        
        view.delegate = self;
        view.tag = 33000 +i;
        view.frame = CGRectMake(0,contentsize_height,_mainScrollView.width,0);
        
        [_mainScrollView addSubview:view];
        
        [_mainScrollView sendSubviewToBack:view];
        
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
        
        BOOL isAdd = i == 0 ? YES : NO;
        
        CGFloat itemheight =[CYBuyerCategoryItemView classicViewHeight:view.dataArr andislast:view.isLast isAddLastBtn:isAdd];
        
        view.height  = itemheight;
        [item_heightDic setObject:@(YES) forKey:@"open"];
        [item_heightDic setObject:@(view.height) forKey:@"open_height"];
        [item_heightDic setObject:@(50.) forKey:@"close_height"];
        [item_heightArr addObject:item_heightDic];
        view.height = [[item_heightDic objectForKey:@"open_height"] floatValue];
        
        contentsize_height +=view.height;
//        contentsize_height +=10;
    }
    
    _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, contentsize_height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark CYFiterItemViewDelegate method
-(void)openOrCloseItemView:(NSInteger)index andView:(CYBuyerCategoryItemView *)view
{
    
    CGFloat contentsize = 40.0f - 1;
    for (int i = 0; i< [item_heightArr count]; i++) {
        CYBuyerCategoryItemView *view = [_mainScrollView viewWithTag:i+33000];
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
        contentsize +=itemHeight;
        view.height = itemHeight;
    }
    _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, contentsize);
}

- (void)addAreaBtnClicked
{
    _areaView.hidden = NO;
    
    
}
- (IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelBtnClicked:(id)sender
{
    _areaView.hidden = YES;
}


- (IBAction)okBtnClicked:(id)sender
{
    _areaView.hidden = YES;
}


-(void)setImgTransform:(BOOL)trans andView:(CYBuyerCategoryItemView *)itemView
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

@end
