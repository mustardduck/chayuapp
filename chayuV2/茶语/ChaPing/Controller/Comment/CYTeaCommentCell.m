//
//  CYTeaCommentCell.m
//  茶语
//
//  Created by 李峥 on 16/2/21.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTeaCommentCell.h"
#import "CYEvaCommentInfo.h"
#import "CYTeaReplyCell.h"
#import "CYZhanKaiView.h"
@interface CYTeaCommentCell ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *replyArr;//回复评论的数据
    CYEvaCommentInfo *evaInfo;
}

@property (nonatomic,strong)CYZhanKaiView *zhankaiView;


@end

static CYTeaCommentCell *__cell = nil;
@implementation CYTeaCommentCell

- (void)seeFullClicked:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    
    if(self.seeFullBlock)
    {
        self.seeFullBlock(btn.tag);
    }
}

- (void)parseData:(id)data
{
    CYEvaCommentInfo *info = [CYEvaCommentInfo objectWithKeyValues:data];
    evaInfo = info;
    [_mUserImageView sd_setImageWithURL:[NSURL URLWithString:info.avatar] placeholderImage:[UIImage imageNamed:@"200x200"]];
    _mNameLabel.text = info.nickname;
    _mDesLabel.text = info.content;
    _mScoreLabel.text = info.score;
    _mDateLabel.text = info.created;
    _mZanLabel.text = info.support;
//    _zanimg.highlighted = info.is_support;
//    _mZanLabel.textColor = info.is_support?MAIN_COLOR:LIGHTCOLOR;
    if (info.attach.count>0) {
        CGFloat imgbgheight = ceilf(info.attach.count/4.)*95*SCREENBILI;
         _mImageConstraintHeight.constant = imgbgheight;
        for (int i =0; i<info.attach.count; i++) {
            NSInteger row = i%3;
            NSInteger sec = i/3;
            UIImageView *showImg = [[UIImageView alloc] initWithFrame:CGRectMake(row*(90*SCREENBILI +5),(90*SCREENBILI +5)*sec,90*SCREENBILI, 90*SCREENBILI)];
            NSString *imgPath = info.attach[i];
            if (imgPath.length >0) {
                [showImg sd_setImageWithURL:[NSURL URLWithString:imgPath] placeholderImage:SQUARE];
            }
            
            UIButton * imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(showImg.x, showImg.y, showImg.width, showImg.height)];
            imgBtn.backgroundColor = [UIColor clearColor];
            imgBtn.tag = i;
            [imgBtn addTarget:self action:@selector(seeFullClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            [_imgcontentView addSubview:showImg];
            [_imgcontentView addSubview:imgBtn];
        }
    }else{
         _mImageConstraintHeight.constant = 0.0;
    }
    replyArr = [NSMutableArray arrayWithArray:info.replys];
    if (replyArr.count>0) {
        _tableView.layer.cornerRadius = 2.0;
        _tableView.layer.borderColor = [UIColor getColorWithHexString:@"cccccc"].CGColor;
        _tableView.layer.borderWidth = 1.0;
        _tableView.clipsToBounds = YES;
        _tableView.hidden = NO;
        _tableView.scrollEnabled = NO;
       __block CGFloat tableheight = 0.0;
        for (int i = 0; i<[replyArr count]; i++) {
            if (!info.isOpen && i>1) {
                break;
            }
            NSDictionary *info = replyArr[i];
            tableheight +=[CYTeaReplyCell calcCellHeight:info];
        }
        if ([replyArr count]>2 && !info.isOpen) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.zhankaiView.height = 40;
                _tableView.tableFooterView = self.zhankaiView;
               
            });
        }
        if ([replyArr count]>2 && !info.isOpen) {
             tableheight +=40;
        }
        _tableconsheight.constant = tableheight;
        _tablebottomcons.constant = 10;
    }else{
        _tableView.hidden = YES;;
        _tableconsheight.constant = 0.0;
    }
    
    [_tableView reloadData];
    self.mClickData = info;

}

-(void)awakeFromNib
{
    [super awakeFromNib];
    _tableView.delegate = self;
    _tableView.dataSource = self;
 
}


- (CYZhanKaiView *)zhankaiView
{
    if (!_zhankaiView) {
        _zhankaiView = [[[NSBundle mainBundle] loadNibNamed:@"CYZhanKaiView" owner:nil options:nil] firstObject];
        _zhankaiView.frame = CGRectMake(0, 0,295*SCREENBILI, 40);
        _zhankaiView.backgroundColor = [UIColor getColorWithHexString:@"eeeeee"];
        [_zhankaiView.zhankaiHuiFu addTarget:self action:@selector(zhankaihuifu_click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _zhankaiView;
}


-(void)zhankaihuifu_click:(UIButton *)sender
{
    if (self.zhankaiBlock) {
        self.zhankaiBlock();
    }
}

+ (CGFloat)calcCellHeight:(id)data
{
    if (__cell == nil) {
        __cell = [[[NSBundle mainBundle] loadNibNamed:@"CYTeaCommentCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    [__cell parseData:data];
    
    [__cell setNeedsUpdateConstraints];
    [__cell updateConstraintsIfNeeded];
    
    CGFloat height = [__cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    
    return height;
}


#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!evaInfo.isOpen && [replyArr count]>2) {
        return 2;
    }
    return replyArr.count;
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info = replyArr[indexPath.row];
    return [CYTeaReplyCell calcCellHeight:info];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *replyIdentify = @"CYTeaReplyCell";
    CYTeaReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:replyIdentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYTeaReplyCell" owner:nil options:nil] firstObject];
    }
    
    NSDictionary *info = replyArr[indexPath.row];
    cell.huifuBtn.tag = 10000 +indexPath.row;
    [cell.huifuBtn addTarget:self action:@selector(huifubierendehuifu_click:) forControlEvents:UIControlEventTouchUpInside];
    cell.zanBtn.tag = 40000 +indexPath.row;
    [cell.zanBtn addTarget:self action:@selector(zan_click:) forControlEvents:UIControlEventTouchUpInside];
    [cell parseData:info];

    return cell;
}

-(void)huifubierendehuifu_click:(UIButton *)sender
{
    NSInteger selectIndex = sender.tag - 10000;
   NSDictionary *info = replyArr[selectIndex];
    if (self.huifuBlock) {
        self.huifuBlock(info);
    }
}

-(void)zan_click:(UIButton *)sender
{
    NSInteger selectIndex = sender.tag - 40000;
    NSDictionary *info = replyArr[selectIndex];
    NSIndexPath *index = [NSIndexPath indexPathForRow:selectIndex inSection:0];
    __block NSInteger suports = [[info objectForKey:@"support"] integerValue];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:info];
    NSString *itemId =[info objectForKey:@"id"];
    NSString *isSuported = [[info objectForJSONKey:@"is_support"] integerValue] == 1?@"0":@"1";
    __weak __typeof(self) weakSelf = self;
    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD show];
    [CYWebClient basePost:@"do_suport" parametes:@{@"itemid":itemId,@"type":@"12",@"class":isSuported} success:^(id responObject) {
        NSInteger state = [[responObject objectForKey:@"state"] integerValue];
        if (state == 400) {
            NSInteger isSuported = [[responObject objectForKey:@"do"] integerValue];
            if (isSuported == 1) {
                [params setObject:@"1" forKey:@"is_support"];
                suports ++;
            }else{
                [params setObject:@"0" forKey:@"is_support"];
                suports --;
            }
            NSString *suportsStr = [NSString stringWithFormat:@"%d",(int)suports];
            [params setObject:suportsStr forKey:@"support"];
            [replyArr replaceObjectAtIndex:selectIndex withObject:params];
            NSArray *inexArr = [NSArray arrayWithObjects:index, nil];
            [weakSelf.tableView reloadRowsAtIndexPaths:inexArr  withRowAnimation:UITableViewRowAnimationNone];
            
        }
    } failure:^(id error) {
        
    }];
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
