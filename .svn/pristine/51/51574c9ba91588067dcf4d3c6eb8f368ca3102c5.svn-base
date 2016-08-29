//
//  CYTeaSampleDetailViewController.m
//  茶语
//
//  Created by 李峥 on 16/2/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTeaSampleDetailViewController.h"
#import "CYTeaReviewImgCell.h"
#import "CYTeaSampleNumCell.h"
#import "CYTeaReviewInfoCell.h"
#import "CYTeaReviewRatingCell.h"
#import "CYTeaSampleRatingCell.h"
#import "CYTeaReviewDetailFooterView.h"
#import "CYTeaSampleInfo.h"
#import "CYWriteCommentViewController.h"
#import "CYTeaCommentListViewController.h"
#import "CYExchangeTeaViewController.h"
#import "CYTeaReviewInfo.h"
#import "AppDelegate.h"
#import "CYActionSheet.h"
#import "CYTeaReviewComCell.h"
#import "CYChaYangTopCell.h"
#import "CYChaYangXinXiCell.h"
#import "CYTeaCommentCell.h"
#import "CYPublicPostCardController.h"
#import "CYProductDetViewController.h"
#import "CYTeaQuanBuChaPingController.h"
@interface CYTeaSampleDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //基本信息是否展开
    BOOL isOpen;
    NSMutableArray *commArr;//评论数据源
    
    OSMessage * _shareMsg;
}


@property (weak, nonatomic) IBOutlet UITableView *mTable;

@property (nonatomic, strong) CYTeaSampleInfo *mSampleInfo;

@property (nonatomic, strong) CYTeaReviewInfo *mDataInfo;


- (IBAction)exchangeTeaSam_click:(id)sender;
- (IBAction)shoucang_click:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *shoucangBtn;

@property (weak, nonatomic) IBOutlet UIButton *duihuanBtn;

@property (nonatomic, strong) UIView *footerView;

- (IBAction)goback:(id)sender;
@end

@implementation CYTeaSampleDetailViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        self.hidesBottomBarWhenPushed = YES;
//    }
//    
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"茶样详情";
    //    _mTable.delegate = nil;
    //    _mTable.dataSource = nil;
    isOpen = NO;
    commArr = [[NSMutableArray alloc] init];
    _shareMsg = [[OSMessage alloc] init];
    _mTable.hidden = YES;
    [self loadDetailData];
    
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
    //    reviewList
    
    [CYWebClient Post:@"reviewList" parametes:@{@"teaid":_teaId,@"pageNo":@"1",@"pageSize":@"10"} success:^(id responObject) {
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
    if (_mSampleid == nil) {
        return;
    }
    self.mTable.hidden = YES;
    
    [CYWebClient Post:@"sampleDetail" parametes:@{@"id":_mSampleid} success:^(id responObject) {
        NSDictionary * shareInfo = [responObject objectForJSONKey:@"share"];
        if ([shareInfo isKindOfClass:[NSDictionary class]] && [shareInfo count]>0) {
            _shareMsg.title = [shareInfo objectForJSONKey:@"title"];
            _shareMsg.desc = [shareInfo objectForJSONKey:@"description"];
            _shareMsg.link = [shareInfo objectForJSONKey:@"url"];
            _shareMsg.imgUrl = [shareInfo objectForJSONKey:@"thumb"];
        }
        self.mSampleInfo = [CYTeaSampleInfo objectWithKeyValues:[responObject objectForKey:@"sample"]];
        
        if (self.mSampleInfo != nil) {
            if ([self.mSampleInfo.remain integerValue] <= 0) {
                [_duihuanBtn setBackgroundColor:[UIColor getColorWithHexString:@"bbbbbb"]];
                [_duihuanBtn setTitleColor:[UIColor getColorWithHexString:@"666666"] forState:UIControlStateNormal];
                _duihuanBtn.userInteractionEnabled = NO;
            }
        }
        
        _teaId = self.mSampleInfo.teaid;
        BOOL isfavor = [[responObject objectForKey:@"isfavor"] boolValue];
        _shoucangBtn.selected = isfavor;
        if (self.mSampleInfo != nil) {
            [self loadTeaDetailData];
        }
    } failure:^(id error) {
        
    }];
}

- (void)loadTeaDetailData{
    if (self.mSampleInfo == nil) {
        return;
    }
    
    [CYWebClient Post:@"teaDetail" parametes:@{@"id":_teaId} success:^(id responObject) {
        
        
        
        self.mDataInfo = [CYTeaReviewInfo objectWithKeyValues:responObject];
        if (self.mDataInfo != nil){
            self.mTable.hidden = NO;
            [self.mTable reloadData];
            [self loadCommListArr];
        }
        
    } failure:^(id error) {
        
    }];
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
    vc.teaId = _mDataInfo.teaid;
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - UIButton Touch
- (IBAction)clickWriteComment:(id)sender
{
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    CYWriteCommentViewController *vc = viewControllerInStoryBoard(@"CYWriteCommentViewController", @"Eva");
    vc.mItemid = _teaId;
    [self.navigationController pushViewController:vc animated:YES];
    //    [self.navigationController pushViewController:comment animated:YES];
}



#pragma mark - UITableView Delegate & Datarouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section <4) {
        return 1;
    }else if(section ==4){
        NSLog(@"[commArr count] = %d",(int)[commArr count]);
        return [commArr count]>=10?10:[commArr count];
    }else{
        return 0;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 85+280*SCREENBILI;
    }
    else if (indexPath.section == 2){
        return isOpen?365:55.;
    }else if (indexPath.section == 3){
        return 162.0;
    }else if(indexPath.section ==1) {
        
        CGFloat height = 212.f;
        if (_mSampleInfo.review.length>0) {
            NSString *content =  [NSString stringWithFormat:@"总评：%@",_mSampleInfo.review];
            NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14.]};
            CGSize lableSize = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-40,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
            height +=lableSize.height;
            height -=17.0f;
        }
        
        if ([_mSampleInfo.goods_id isEqualToString:@"0"]) {
            height -=50;
        }
        
        return height;
    }else if(indexPath.section == 4){
        //         NSLog(@"[commArr count] = %d",(int)[commArr count]);
        ////        if (commArr.count>0) {
        CYEvaCommentInfo *info = commArr[indexPath.row];
        CGFloat tableheight = [CYTeaCommentCell calcCellHeight:info];
        if (info.replys.count) {
            tableheight +=10;
        }
        return tableheight;
        //        }
        //        return 131.0;
        
    }else{
        return 0.0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        CYChaYangTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYChaYangTopCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CYChaYangTopCell" owner:nil options:nil] firstObject];
        }
        NSString *thumb = _mSampleInfo.thumb;
        if (thumb.length>0) {
            [cell.showImg sd_setImageWithURL:[NSURL URLWithString:thumb] placeholderImage:[UIImage imageNamed:@"750×563"]];
        }
        NSString *title = [NSString stringWithFormat:@"|%@|%@",self.mDataInfo.brand,self.mDataInfo.title];
        NSMutableAttributedString *attrStr1 = [[NSMutableAttributedString alloc] initWithString:title];
        [attrStr1 addAttribute:NSForegroundColorAttributeName value:MAIN_COLOR range:NSMakeRange(0,self.mDataInfo.brand.length +2)];
        cell.titleLbl.attributedText = attrStr1;
        
        return cell;
    }else if(indexPath.section == 1){
        CYChaYangXinXiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYChaYangXinXiCell"];
        if (!cell) {
            cell =[[[NSBundle mainBundle] loadNibNamed:@"CYChaYangXinXiCell" owner:nil options:nil] firstObject];
        }
        
        cell.chabiLbl.text = [NSString stringWithFormat:@"茶币：%@个",_mSampleInfo.price];
        if([_mSampleInfo.remain integerValue])
        {
            cell.kucunLbl.text = [NSString stringWithFormat:@"库存：%@份",_mSampleInfo.remain];
        }
        else
        {
            cell.kucunLbl.text = @"库存：暂无";
        }
        cell.guigeLbl.text = [NSString stringWithFormat:@"规格：%@/份",_mSampleInfo.size];
        cell.pinfenLbl.text = _mSampleInfo.score;
        cell.zongpingLbl.text = [NSString stringWithFormat:@"总评：%@",_mSampleInfo.review];
        if ([self.mSampleInfo.goods_id isEqualToString:@"0"]) {
            cell.goumaiView.hidden = YES;
        }else{
            [cell.goumaiBtn addTarget:self action:@selector(lijigoumai) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }else if (indexPath.section == 2){
        CYTeaReviewInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYTeaReviewInfoCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CYTeaReviewInfoCell" owner:nil options:nil] firstObject];
        }
        if (isOpen) {
            cell.dowImg.image = [UIImage imageNamed:@"daohang_up_row"];
        }else{
            cell.dowImg.image = [UIImage imageNamed:@"daohang_down_row"];
        }
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
    }else if(indexPath.section == 3){
        CYTeaReviewRatingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYTeaReviewRatingCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CYTeaReviewRatingCell" owner:nil options:nil] firstObject];
        }
        
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
    }else if(indexPath.section == 4){
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
    }else{
        return nil;
    }
    
}

-(void)jibenxinxi_click:(UIButton *)sender
{
    isOpen = !isOpen;
    [_mTable reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)lijigoumai
{
    CYProductDetViewController *vc =viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
    vc.goodId = self.mSampleInfo.goods_id;
    [self.navigationController pushViewController:vc animated:YES];
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

#pragma mark -
#pragma mark 按钮点击事件 method

//兑换茶样
- (IBAction)exchangeTeaSam_click:(id)sender {
    
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    if (_mSampleid) {
        CYExchangeTeaViewController *vc = viewControllerInStoryBoard(@"CYExchangeTeaViewController", @"Eva");
        vc.goodsId = _mSampleid;
        vc.content = self.mSampleInfo.review;
        vc.price = self.mSampleInfo.price;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

//收藏
- (IBAction)shoucang_click:(id)sender {
    
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD show];
    [CYWebClient Post:@"favorite" parametes:@{@"itemid":_mSampleid,@"type":@"6"} success:^(id responObject) {
        BOOL is_favor = [[responObject objectForKey:@"is_favor"] boolValue];
        _shoucangBtn.selected = is_favor;
        
    } failure:^(id error) {
        
    }];
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
        case 2://分享
        {
            [self navBarClicked:self.navigationController tag:((UIButton *)sender).tag shareMessage:_shareMsg];
            break;
        }
            
        default:
            break;
    }
    
}

@end
