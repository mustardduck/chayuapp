//
//  CYTeaReviewDetailViewController.m
//  茶语
//
//  Created by 李峥 on 16/2/19.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTeaReviewDetailViewController.h"
#import "CYTeaReviewImgCell.h"
#import "CYTeaReviewScoreCell.h"
#import "CYTeaReviewComCell.h"
#import "CYTeaReviewInfoCell.h"
#import "CYTeaReviewRatingCell.h"
#import "CYTeaProcessCell.h"
#import "CYTeaReviewDetailFooterView.h"

#import "CYTeaReviewInfo.h"

#import "CYTeaCommentListViewController.h"

#import "CYTeaProcessViewController.h"

#import "AppDelegate.h"
#import "CYActionSheet.h"
#import "CYExchangeTeaViewController.h"
#import "CYWriteCommentViewController.h"
#import "CYTeaSampleDetailViewController.h"
#import "CYTeaCommentCell.h"
#import "CYPublicPostCardController.h"
#import "BaseButton.h"
#import "CYTeaQuanBuChaPingController.h"
#import "CYTeaReviewDetailViewController.h"
#import "UICommon.h"


@interface CYTeaReviewDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *commArr;//评论数据源
    BOOL isOpen;
    OSMessage * _shareMsg;
    
    NSMutableArray * _imgUrlArr;
}
@property (weak, nonatomic) IBOutlet UITableView *mTable;

@property (nonatomic, strong) CYTeaReviewImgCell *mImgCell;
@property (nonatomic, strong) CYTeaReviewScoreCell *mScoreCell;
@property (nonatomic, strong) CYTeaReviewComCell *mCommentCell;
@property (nonatomic, strong) CYTeaReviewInfoCell *mInfoCell;
@property (nonatomic, strong) CYTeaReviewRatingCell *mRatingCell;

//@property (nonatomic, strong) CYTeaReviewDetailFooterView *mFooterView;

@property (nonatomic, strong) CYTeaReviewInfo *mDataInfo;
@property (nonatomic, strong) UIView *footerView;
- (IBAction)shoucang_click:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *shoucangbutton;
- (IBAction)goback:(id)sender;

- (IBAction)duihuanchayang_click:(id)sender;



- (IBAction)woyaopingcha_click:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *duihuanBtn;



@end

@implementation CYTeaReviewDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"茶评详情";
    isOpen = NO;
    commArr = [NSMutableArray array];
    _mTable.hidden = YES;
    _shareMsg = [[OSMessage alloc] init];
    _imgUrlArr = [NSMutableArray array];
    
    [self loadCommListArr];
    [self loadDetailData];
    [self creatkongNavBar];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APP_DELEGATE setTabbarHidden:YES animated:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:self.title];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:self.title];
}


-(void)loadCommListArr
{
    [CYWebClient Post:@"reviewList" parametes:@{@"teaid":_mTeaId,@"pageNo":@"1",@"pageSize":@"10"} success:^(id responObject) {
        NSArray *review = [responObject objectForKey:@"review"];
        [commArr addObjectsFromArray:[CYEvaCommentInfo objectArrayWithKeyValuesArray:review]];
        if ([commArr count]>=10) {
            _mTable.tableFooterView = self.footerView;
        }
        [_mTable reloadData];
    } failure:^(id error) {
        
    }];
}


- (void)loadDetailData{
    if (_mTeaId == nil) {
        return;
    }
    self.mTable.hidden = YES;
    [CYWebClient basePost:@"teaDetail" parametes:@{@"id":_mTeaId} success:^(id responObject) {
        
        NSInteger state = [[responObject objectForKey:@"state"] integerValue];
        if (state == 400) {
            NSDictionary * shareInfo = [responObject objectForJSONKey:@"share"];
            if ([shareInfo isKindOfClass:[NSDictionary class]] && [shareInfo count]>0) {
                _shareMsg.title = [shareInfo objectForJSONKey:@"title"];
                _shareMsg.desc = [shareInfo objectForJSONKey:@"description"];
                _shareMsg.link = [shareInfo objectForJSONKey:@"url"];
                _shareMsg.imgUrl = [shareInfo objectForJSONKey:@"thumb"];
            }
            NSDictionary *data = [responObject objectForKey:@"data"];
            self.mDataInfo = [CYTeaReviewInfo objectWithKeyValues:data];
            
            BOOL is_favorite = [[data objectForKey:@"is_favorite"] boolValue];
            if (is_favorite) {
                _shoucangbutton.selected = YES;
            }
            
            if (self.mDataInfo != nil) {
                if ([self.mDataInfo.sample_remain integerValue] == 0) {
                    [_duihuanBtn setBackgroundColor:[UIColor getColorWithHexString:@"bbbbbb"]];
                    [_duihuanBtn setTitleColor:[UIColor getColorWithHexString:@"666666"] forState:UIControlStateNormal];
                    _duihuanBtn.userInteractionEnabled = NO;
                }
                self.mTable.hidden = NO;
                [self.mTable reloadData];
            }
        }
        
        
        
        
    } failure:^(id error) {
        
    }];
}

#pragma mark - UIButton Touch
- (void)clickWriteComment:(id)sender
{
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    CYWriteCommentViewController *comment = [[CYWriteCommentViewController alloc] initWithNibName:@"CYWriteCommentViewController" bundle: nil];
    comment.mItemid = self.mTeaId;
    comment.bid = self.mDataInfo.bid;
    [self.navigationController pushViewController:comment animated:YES];
}

- (IBAction)clickCommentNum:(id)sender
{
    
    CYTeaCommentListViewController *vc = [[CYTeaCommentListViewController alloc] initWithNibName:@"CYTeaCommentListViewController" bundle:nil];
    vc.mItemId = self.mTeaId;
    vc.mBid = self.mDataInfo.bid;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)seeTouFullScreen:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    
    [UICommon seeFullScreenImage:self.navigationController imageUrlArr:_imgUrlArr currentPage:btn.tag];
}

- (void)seeFullClicked:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    
    NSInteger section = btn.tag / 10;
    NSInteger row = btn.tag % 10;
    
    NSMutableArray * imgArr = [NSMutableArray array];
    if (section == 1)
    {
        CYTeaProcessDetailInfo *info = self.mDataInfo.process.drytea;
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:info.filename forKey:@"PictureUrl"];
        [imgArr addObject:dic];
    }
    else if (section == 2)
    {
        CYTeaProcessPaoInfo *info = self.mDataInfo.process.ready_pao;
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:info.thumb forKey:@"PictureUrl"];
        [imgArr addObject:dic];
    }
    else if (section == 3)
    {
        CYTeaProcessDetailInfo *info = [self.mDataInfo.process.cook objectAtIndex:row];
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:info.filename forKey:@"PictureUrl"];
        [imgArr addObject:dic];
    }
    
    [UICommon seeFullScreenImage:self.navigationController imageUrlArr:imgArr currentPage:0];
}

#pragma mark - UITableView Delegate & Datarouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.mDataInfo == nil) {
        return 0;
    }else
    {
        //1为基础数据 + 4为冲泡过程 +1为评论
        return 1 + 4 +1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 4;
        case 1:
            return 1;
        case 2:
            return 1;
        case 3:
            return self.mDataInfo.process.cook.count;
        case 4:
            return 1;
        case 5:
            return [commArr count]>=10?10:[commArr count];
        default:
            return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                return 370*SCREENBILI;
            case 1:
                return 156;
            case 2:
            {
                return [self.mCommentCell.contentView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height+1;
            }
            case 3:
                return isOpen?365:55.;
                //            case 4:
                //                return 162;
        }
    }else if(indexPath.section<4)
    {
        NSInteger idx = indexPath.section - 1;
        
        switch (idx) {
            case 0:
                return [CYTeaProcessCell calcCellHeight:self.mDataInfo.process.drytea atIndex:idx]+5;
            case 1:
                return [CYTeaProcessCell calcCellHeight:self.mDataInfo.process.ready_pao atIndex:idx];
            case 2:
                return [CYTeaProcessCell calcCellHeight:[self.mDataInfo.process.cook objectAtIndex:indexPath.row] atIndex:idx]+5;
            case 3:
                return [CYTeaProcessCell calcCellHeight:self.mDataInfo.process.leaves  atIndex:idx]+5;
            default:
                return 0;
        }
    }else if(indexPath.section == 4){
        return 162.;
    }else{
        CYEvaCommentInfo *info = commArr[indexPath.row];
        CGFloat tableheight = [CYTeaCommentCell calcCellHeight:info];
        if (info.replys.count) {
            tableheight +=10;
        }
        return tableheight;
        //        return 221.0;
    }
    
    return 44;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 60;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if (self.mDataInfo.comcount <= 0) {
//        [self.mFooterView.mCommentNumBtn setTitle:@"暂无评论" forState:UIControlStateNormal];
//    }else
//    {
//        [self.mFooterView.mCommentNumBtn setTitle:[NSString stringWithFormat:@"%d条评论",self.mDataInfo.comcount] forState:UIControlStateNormal];
//    }
//    
//    return self.mFooterView;

//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                CYTeaReviewImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYTeaReviewImgCell"];
                if (!cell) {
                    cell =[[[NSBundle mainBundle] loadNibNamed:@"CYTeaReviewImgCell" owner:nil options:nil] firstObject];
                }
                
                for (NSInteger i = 0;i < self.mDataInfo.focus_list.count; i++) {
                    NSDictionary *info = self.mDataInfo.focus_list[i];
                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
                    imgView.frame = CGRectMake(CGRectGetWidth(cell.mScrollView.frame)*i, 0, CGRectGetWidth(cell.mScrollView.frame), CGRectGetHeight(cell.mScrollView.frame));
                    [imgView sd_setImageWithURL:[NSURL URLWithString:[info objectForKey:@"filename"]] placeholderImage:[UIImage imageNamed:@"750×563"]];
                    imgView.contentMode = UIViewContentModeScaleAspectFit;
                    imgView.autoresizesSubviews = YES;
                    imgView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
                    
                    UIButton * scrollImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(imgView.x  , imgView.y, imgView.width, imgView.height)];
                    scrollImgBtn.backgroundColor = [UIColor clearColor];
                    scrollImgBtn.tag = i;
                    [scrollImgBtn addTarget:self action:@selector(seeTouFullScreen:) forControlEvents:UIControlEventTouchUpInside];
                    
                    
                    [cell.mScrollView addSubview:imgView];
                    
                    [cell.mScrollView addSubview:scrollImgBtn];
                    
                    
                    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
                    
                    [dic setObject:[info objectForKey:@"filename"] forKey:@"PictureUrl"];
                    [_imgUrlArr addObject:dic];
                }
                
                [cell.mScrollView setContentSize:CGSizeMake(SCREEN_WIDTH*self.mDataInfo.focus_list.count, 0)];
                cell.mPageControl.numberOfPages = self.mDataInfo.focus_list.count;
                
                NSString *title = [NSString stringWithFormat:@"|%@|%@",self.mDataInfo.brand,self.mDataInfo.title];
                NSMutableAttributedString *attrStr1 = [[NSMutableAttributedString alloc] initWithString:title];
                [attrStr1 addAttribute:NSForegroundColorAttributeName value:MAIN_COLOR range:NSMakeRange(0,self.mDataInfo.brand.length +2)];
                cell.mTitleLabel.attributedText = attrStr1;
                return cell;
            }
            case 1:{
                CYTeaReviewScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYTeaReviewScoreCell"];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"CYTeaReviewScoreCell" owner:nil options:nil] firstObject];
                }
                cell.mReviewScodeLabel.text = self.mDataInfo.review_score;
                cell.mScoreLabel.text = self.mDataInfo.score;
                cell.mRecLabel.text = self.mDataInfo.recommend_score_name;
                
                for (int i =0; i<5; i++) {
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.frame = CGRectMake(i*18,0, 14,14);
                    [button setImage:[UIImage imageNamed:@"tuijianzhishu_ico_d"] forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:@"tuijianzhishu_ico_s"] forState:UIControlStateSelected];
                    button.adjustsImageWhenHighlighted = NO;
                    if (i<[self.mDataInfo.recommend_score integerValue]) {
                        button.selected = YES;
                    }
                    [cell.zhishuBg addSubview:button];
                }
                cell.mPriceLabel.text = self.mDataInfo.cankaojiage;
                cell.timeLbl.text  =self.mDataInfo.pingjianshijian;
                
                return cell;
            }
            case 2:{
                CYTeaReviewComCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYTeaReviewComCell"];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"CYTeaReviewComCell" owner:nil options:nil] firstObject];
                }
                
                NSString *reviewStr = [NSString stringWithFormat:@"总评：%@",self.mDataInfo.review];
                cell.mDesLabel.text = reviewStr;
                
                
                [cell.mShopBtn addTarget:self action:@selector(showShoping:) forControlEvents:UIControlEventTouchUpInside];
                cell.shopNameLbl.text = self.mDataInfo.shopname;
                NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14.]};
                CGSize lableSize = [self.mDataInfo.shopname boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-60,30) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
                if (self.mDataInfo.shopurl.length) {
                    cell.shopbg_cons.constant = lableSize.width+30;
                }else{
                    cell.bottom_cons.constant = 5;
                    cell.shopnameBg.hidden = YES;
                }
                [cell updateConstraintsIfNeeded];
                return cell;
            }
            case 3:{
                CYTeaReviewInfoCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"CYTeaReviewInfoCell" owner:nil options:nil] firstObject];
                cell.pingpaiLbl.text = _mDataInfo.brand;
                cell.chaleiLbl.text = _mDataInfo.chalei;
                cell.shijianLbl.text = _mDataInfo.year;
                cell.pingzhongLbl.text = _mDataInfo.variety;
                cell.dengjiLbl.text = _mDataInfo.rank;
                cell.guigeLbl.text = _mDataInfo.size;
                cell.baozhuangLbl.text = _mDataInfo.baozhuang;
                cell.cankaojiaLbl.text = _mDataInfo.price;
                cell.baozhiqiLbl.text = _mDataInfo.shelflife;
                cell.xukeLbl.text = _mDataInfo.license;
                cell.biaozhunLbl.text = _mDataInfo.standard;
                cell.renzhengLbl.text = _mDataInfo.certificate;
                [cell.zhankaiBtn addTarget:self action:@selector(jibenxinxi_click:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }
                
        }
    }else if(indexPath.section <4)
    {
        CYTeaProcessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYTeaProcessCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CYTeaProcessCell" owner:nil options:nil] objectAtIndex:0];
        }
        if (indexPath.section == 1) {
            [cell parseData:self.mDataInfo.process.drytea atIndex:indexPath.section - 1];
            
        }else if (indexPath.section == 2){
            [cell parseData:self.mDataInfo.process.ready_pao atIndex:indexPath.section - 1];
            
        }else if (indexPath.section == 3){
            [cell parseData:[self.mDataInfo.process.cook objectAtIndex:indexPath.row] atIndex:indexPath.section - 1];
            
        }else if (indexPath.section == 4){
            [cell parseData:self.mDataInfo.process.leaves  atIndex:indexPath.section - 1];
        }
        
        cell.seeFullBtn.tag = indexPath.section * 10 + indexPath.row;
        [cell.seeFullBtn addTarget:self action:@selector(seeFullClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }else if(indexPath.section == 4){
        //        return self.mRatingCell;
        CYTeaReviewRatingCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CYTeaReviewRatingCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CYTeaReviewRatingCell" owner:nil options:nil] firstObject];
        }
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYTeaReviewRatingCell" owner:nil options:nil] objectAtIndex:0];
        [cell.teaView setImagesDeselected:@"eva03" partlySelected:@"eva02" fullSelected:@"eva01" andDelegate:nil];
        [cell.zjView setImagesDeselected:@"eva03" partlySelected:@"eva02" fullSelected:@"eva01" andDelegate:nil];
        [cell.drView setImagesDeselected:@"eva03" partlySelected:@"eva02" fullSelected:@"eva01" andDelegate:nil];
        [cell.yhView setImagesDeselected:@"eva03" partlySelected:@"eva02" fullSelected:@"eva01" andDelegate:nil];
        
        [cell.teaView displayRating:[self.mDataInfo.review_score_star floatValue]];
        [cell.zjView displayRating:[self.mDataInfo.expert_scor_star floatValue]];
        [cell.drView displayRating:[self.mDataInfo.daren_score_star floatValue]];
        [cell.yhView displayRating:[self.mDataInfo.user_score_star floatValue]];
        cell.mScodeLabel.text = [NSString stringWithFormat:@"%.1f", [self.mDataInfo.score doubleValue]];
        
        return cell;
    }else{
        CYTeaCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYTeaCommentCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CYTeaCommentCell" owner:nil options:nil] firstObject];
        }
        cell.commBtn.tag = 60000+indexPath.row;
        [cell.commBtn addTarget:self action:@selector(huifumoren_click:) forControlEvents:UIControlEventTouchUpInside];
        cell.zanBtn.tag = 90000+indexPath.row;
        [cell.zanBtn addTarget:self action:@selector(dianzan_click:) forControlEvents:UIControlEventTouchUpInside];
        CYEvaCommentInfo *info = commArr[indexPath.row];
        [cell parseData:info];
        cell.seeFullBlock = ^(NSInteger currentPage)
        {
            NSMutableArray * imgArr = [NSMutableArray array];
            for(int i = 0; i < info.attach.count; i ++)
            {
                NSString * url = info.attach[i];
                NSMutableDictionary * dic = [NSMutableDictionary dictionary];
                [dic setObject:url forKey:@"PictureUrl"];
                
                [imgArr addObject:dic];
            }
            
            [UICommon seeFullScreenImage:self.navigationController imageUrlArr:imgArr currentPage: currentPage];
        };
        cell.zhankaiBlock = ^(){
            info.isOpen = YES;
            [_mTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
        };
        cell.huifuBlock = ^(NSDictionary *info){
            
            CYPublicPostCardController *vc= viewControllerInStoryBoard(@"CYPublicPostCardController", @"WenZhang");
            vc.pid = [[info objectForKey:@"reviewid"] description];
            vc.touid = [[info objectForKey:@"touid"] description];
            vc.huifutype = HuiFuTypeWenChaPing;
            vc.postcardbackBlock = ^(){
                [commArr removeAllObjects];
                [self loadCommListArr];
            };
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        
        return cell;
    }
    
    return nil;
}

-(void)jibenxinxi_click:(UIButton *)sender
{
    isOpen = !isOpen;
    [_mTable reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
}


//恢复某人
-(void)huifumoren_click:(UIButton *)sender
{
    
    NSInteger selectIndex = sender.tag - 60000;
    CYEvaCommentInfo *info = commArr[selectIndex];
    CYPublicPostCardController *vc= viewControllerInStoryBoard(@"CYPublicPostCardController", @"WenZhang");
    vc.pid = info.id;
    vc.touid = info.uid;
    vc.huifutype = HuiFuTypeWenChaPing;
    vc.postcardbackBlock = ^(){
        [commArr removeAllObjects];
        [self loadCommListArr];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
//点赞
-(void)dianzan_click:(UIButton *)sender
{
    NSInteger selectIndex = sender.tag - 90000;
    NSIndexPath *index = [NSIndexPath indexPathForRow:selectIndex inSection:5];
    CYEvaCommentInfo *info = commArr[selectIndex];
    __block NSInteger suports = [info.support integerValue];
    NSString *class = info.is_support?@"0":@"1";
    NSString *itemid = info.id;
    __weak __typeof(self) weakSelf = self;
    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD show];
    [CYWebClient basePost:@"do_suport" parametes:@{@"itemid":itemid,@"type":@"2",@"class":class} success:^(id responObject) {
        NSInteger state = [[responObject objectForKey:@"state"] integerValue];
        if (state == 400) {
            NSInteger isSuported = [[responObject objectForKey:@"do"] integerValue];
            if (isSuported == 1) {
                info.is_support = YES;
                suports ++;
            }else{
                info.is_support = NO;
                suports --;
            }
            info.support = [NSString stringWithFormat:@"%d",(int)suports];
            [commArr replaceObjectAtIndex:selectIndex withObject:info];
            NSArray *inexArr = [NSArray arrayWithObjects:index, nil];
            [weakSelf.mTable reloadRowsAtIndexPaths:inexArr  withRowAnimation:UITableViewRowAnimationNone];
            
        }
    } failure:^(id error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CYTeaReviewComCell *)mCommentCell
{
    if (_mCommentCell == nil) {
        _mCommentCell = [[[NSBundle mainBundle] loadNibNamed:@"CYTeaReviewComCell" owner:nil options:nil] objectAtIndex:0];
        NSLog(@"self.mDataInfo.review %@",self.mDataInfo.review);
        _mCommentCell.mDesLabel.text = [NSString stringWithFormat:@"总评：%@",self.mDataInfo.review];
        
        
        [_mCommentCell.mShopBtn addTarget:self action:@selector(showShoping:) forControlEvents:UIControlEventTouchUpInside];
        _mCommentCell.shopNameLbl.text = self.mDataInfo.shopname;
        NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14.]};
        CGSize lableSize = [self.mDataInfo.shopname boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-60,30) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        if (self.mDataInfo.shopurl.length) {
            _mCommentCell.shopbg_cons.constant = lableSize.width+45;
        }else{
            _mCommentCell.bottom_cons.constant = 10;
            _mCommentCell.shopnameBg.hidden = YES;
        }
        
        [_mCommentCell updateConstraintsIfNeeded];
        
    }
    
    return _mCommentCell;
}


- (UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        line.backgroundColor = [UIColor getColorWithHexString:@"eeeeee"];
        [_footerView addSubview:line];
        BaseButton *moreBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
        moreBtn.frame = CGRectMake(20, 15, SCREEN_WIDTH-40, 40);
        moreBtn.titleLabel.font = FONT(15.0f);
        moreBtn.cornerRadius = 2.0;
        [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [moreBtn setBackgroundColor:[UIColor getColorWithHexString:@"eeeeee"]];
        [moreBtn setTitleColor:[UIColor getColorWithHexString:@"666666"] forState:UIControlStateNormal];
        [moreBtn addTarget:self action:@selector(morecomm_click:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:moreBtn];
    }
    return _footerView;
}

-(void)morecomm_click:(UIButton *)sender
{
    CYTeaQuanBuChaPingController *vc = viewControllerInStoryBoard(@"CYTeaQuanBuChaPingController", @"Eva");
    vc.teaId = _mTeaId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark 按钮点击事件 method
- (IBAction)shoucang_click:(id)sender {
    
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    
    if (_mTeaId.length) {
        
        [SVProgressHUD setBackgroundColor:CLEARCOLOR];
        [SVProgressHUD setForegroundColor:[UIColor blackColor]];
        [SVProgressHUD show];
        //        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        
        [CYWebClient basePost:@"favorite" parametes:@{@"itemid":_mTeaId,@"type":@"2"} success:^(id responObject) {
            NSInteger state = [[responObject objectForKey:@"state"] integerValue];
            if (state == 400) {
                _shoucangbutton.selected = !_shoucangbutton.selected;
            }
        } failure:^(id error) {
            
        }];
    }
    
}

-(void)showShoping:(UIButton *)sender
{
    if (self.mDataInfo.shopurl) {
        NSURL* url = [[NSURL alloc] initWithString:self.mDataInfo.shopurl];
        [[ UIApplication sharedApplication]openURL:url];
    }
    
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//兑换茶样
- (IBAction)duihuanchayang_click:(id)sender {
    
    //    CYTeaSampleDetailViewController *vc =viewControllerInStoryBoard(@"CYTeaSampleDetailViewController", @"Eva");
    //    vc.mSampleid = self.mDataInfo.sample_id;
    //    vc.teaId = _mTeaId;
    //    [self.navigationController pushViewController:vc animated:YES];
    
    CYExchangeTeaViewController *vc = viewControllerInStoryBoard(@"CYExchangeTeaViewController", @"Eva");
    vc.goodsId = self.mDataInfo.sample_id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)woyaopingcha_click:(id)sender {
    CYWriteCommentViewController *vc = viewControllerInStoryBoard(@"CYWriteCommentViewController", @"Eva");
    vc.mItemid = _mTeaId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)zhijiefenxiang_click:(UIButton *)sender {
    
    switch (sender.tag) {
        case 320:
        {
            [self sharePengYouQuan:_shareMsg];
            break;
        }
        case 321:
        {
            [self shareWeiXin:_shareMsg];
            break;
        }
        case 322:
        {
            [self shareQQ:_shareMsg];
            break;
        }
        case 2:
        {
            [self navBarClicked:self.navigationController tag:((UIButton *)sender).tag shareMessage:_shareMsg];
            break;
        }
            
        default:
            break;
    }
    
}

@end
