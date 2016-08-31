//
//  CYMyViewController.m
//  茶语
//
//  Created by Chayu on 16/2/16.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYMyViewController.h"
#import "CYSCartViewController.h"
#import "CYMyOrderViewController.h"
#import "CYPersonalCenterViewController.h"
#import "CYMyCommentViewController.h"
#import "CYHongBaoViewController.h"
#import "CYMyGroupViewController.h"
#import "CYMyTeaViewController.h"
#import "CYSettingViewController.h"
#import "CYCollectViewController.h"
#import "CYTuiJianViewController.h"
#import "CYMyShiJiCell.h"
#import "CYMyQuanZiCell.h"
#import "CYMyChaPingCell.h"
#import "CYAdviceCell.h"
#import "CYMyMessageCell.h"
#import "CYMyHuoDongCell.h"
#import "CYAddressListViewController.h"
#import "CYMyTeaViewController.h"
#import "CYDuiHuanLiShiController.h"
#import "CYMyGuanZhu.h"
#import "CYMyGroupViewController.h"
#import "CYAdviseViewController.h"
#import "CYWoDeXiaoXiController.h"
#import "CYPublicHuoDongViewController.h"
#import "CYGonglueController.h"
#import "CYRefundViewController.h"
#import "CYTopWindow.h"
#import "CYBuyerMyVC.h"

@interface CYMyViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSDictionary *messageInfo;
    NSDictionary *userInfo;
    NSDictionary *tuijianyouli;
    NSDictionary *xinrenyouli;
    NSDictionary *chengmingcha;
    NSDictionary *contributeLevel;
    NSMutableArray *activtyArr;
    NSDictionary *myScore;
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)goback:(id)sender;


@end

@implementation CYMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = false;
    
    [CYTopWindow hide];
    [self creatkongNavBar];
    
    activtyArr =[NSMutableArray array];
    
}

-(IBAction)setting:(UIButton *)sender
{
    CYSettingViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYSettingViewController"];
    //vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APP_DELEGATE setTabbarHidden:YES animated:animated];
    [self loadUserInfo];
    [self loadmyMessage];
    
    
}
-(void)loadmyMessage
{
    [CYWebClient Post:@"2.0_user.info.count" parametes:nil success:^(id responObject) {
        messageInfo = responObject;
        myScore = [responObject objectForKey:@"myScore"];
        if ([messageInfo count]>0) {
            contributeLevel = [messageInfo objectForKey:@"contributeLevel"];
        }
        NSArray *activty = [responObject objectForKey:@"activty"];
        if ([activty isKindOfClass:[NSArray class]] && activty.count >0) {
            [activtyArr removeAllObjects];
            [activtyArr addObjectsFromArray:activty];
        }
        [_tableView reloadData];
    } failure:^(id error) {
        
    }];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self loadUserInfo];
////    [_tbl_my reloadData];
//}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"我的"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"我的"];
}
-(void)loadUserInfo
{
    [CYWebClient Post:@"user_info" parametes:nil success:^(id responObject) {
        userInfo = responObject;
        [_tableView reloadData];
    } failure:^(id error) {
        
    }];
}


-(void)creatBackItem{
    
}

//到我的销售后台
- (IBAction)myBuyer:(UIButton *)sender {
    
    
    
    
    CYBuyerMyVC *tdc = viewControllerInStoryBoard(@"CYBuyerMyVC", @"Buyer");
    
    NSString *avatar = [userInfo objectForKey:@"avatar"];
    if (avatar.length>0) {
        tdc.imgeStr = avatar;
    }
    NSString *nickName = [userInfo objectForKey:@"nickname"];
    tdc.userName = nickName;
    NSString *score = [userInfo objectForJSONKey:@"score"];
    tdc.chabi = score;
    
    [self.navigationController pushViewController:tdc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 190.;
    }else if (indexPath.section == 1 || indexPath.section == 2){
        
        if (indexPath.section == 1) {
            if ([activtyArr count]>0) {
                return 117.0;
            }
            return 0.000001;
        }
        return 117.0;
    }else if (indexPath.section == 3){
        return 225.0;
    }else if(indexPath.section ==4){
        return 117.0f;
    }else{
        return 51.0;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CYMyMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYMyMessageCell"];
        if (![userInfo isKindOfClass:[NSNull class]] && [userInfo count]>0) {
            NSString *avatar = [userInfo objectForKey:@"avatar"];
            if (avatar.length>0) {
                [cell.userImg sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:DEFAULTHEADER];
            }
            
            
            cell.userImg.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(henghuantouxiang:)];
            [cell.userImg addGestureRecognizer:tap];
            NSString *nickName = [userInfo objectForKey:@"nickname"];
            cell.userNameLbl.text = nickName;
            NSString *score = [userInfo objectForJSONKey:@"score"];
            cell.chabiLbl.text = score;
        }
        NSInteger msgNotReadCount = [[messageInfo objectForKey:@"msgNotReadCount"] integerValue];
        NSInteger artreplyNotRead = [[messageInfo objectForKey:@"artreplyNotRead"] integerValue];
        cell.xiaoxiStatusLbl.hidden = NO;
        cell.pinglunstatusLbl.hidden = NO;
        if (msgNotReadCount == 0) {
            cell.xiaoxiStatusLbl.hidden = YES;
        }
        if (artreplyNotRead == 0) {
            cell.pinglunstatusLbl.hidden = YES;
        }
        cell.menuclickBlock = ^(NSInteger selectindex){
            switch (selectindex) {
                case 0://我的消息
                {
                    CYWoDeXiaoXiController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYWoDeXiaoXiController"];
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 1://我的收藏
                {
                    CYCollectViewController *vc = viewControllerInStoryBoard(@"CYCollectViewController", @"My");
                    //                    //vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 2://我的评论
                {
                    CYMyCommentViewController *vc = viewControllerInStoryBoard(@"CYMyCommentViewController", @"My");
                    //                    //vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 3://夺宝记录
                {
                    CYAddressListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYAddressListViewController"];
                    vc.addressType = CYAddressTypeManager;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    break;
                }
                case 4://收货地址
                {
                    NSDictionary *info = [messageInfo objectForKey:@"myGift"];
                    
                    CYGonglueController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYGonglueController"];
                    vc.name = [info objectForKey:@"title"];
                    vc.url = [info objectForKey:@"url"];
                    [self.navigationController pushViewController:vc animated:YES];
                    //                    CYPublicHuoDongViewController *vc = viewControllerInStoryBoard(@"CYPublicHuoDongViewController", @"Huodong");
                    //                    vc.titleStr = [info objectForKey:@"title"];
                    //                    vc.requstUrl = [info objectForKey:@"url"];
                    //                    [self.navigationController pushViewController:vc animated:YES];
                    //                    CYAddressListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYAddressListViewController"];
                    //                    vc.addressType = CYAddressTypeManager;
                    //                    [self.navigationController pushViewController:vc animated:YES];
                    //                    
                    break;
                }
                case 5://茶币获取攻略
                {
                    //                    NSDictionary *
                    NSDictionary *scoreStrategy =[messageInfo objectForKey:@"scoreStrategy"];
                    if (![scoreStrategy isKindOfClass:[NSNull class]] && scoreStrategy.count) {
                        CYGonglueController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYGonglueController"];
                        vc.name = [scoreStrategy objectForKey:@"title"];
                        vc.url = [scoreStrategy objectForKey:@"url"];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    
                    break;
                }
                    
                case 6://茶币获取攻略
                {
                    //                    NSDictionary *
                    
                    if (![myScore isKindOfClass:[NSNull class]] && myScore.count) {
                        CYGonglueController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYGonglueController"];
                        vc.name = [myScore objectForKey:@"title"];
                        vc.url = [myScore objectForKey:@"url"];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    
                    break;
                }
                    
                default:
                    break;
            }
        };
        return cell;
    }else if (indexPath.section == 2){
        CYMyChaPingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYMyChaPingCell"];
        cell.menuclickBlock = ^(NSInteger selectindex){
            switch (selectindex) {
                case 0://我的茶评
                {
                    CYMyTeaViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYMyTeaViewController"];
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 1://茶样兑换历史
                {
                    CYDuiHuanLiShiController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"CYDuiHuanLiShiController"];
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                default:
                    break;
            }
        };
        return cell;
    }else if(indexPath.section == 3){
        CYMyShiJiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYMyShiJiCell"];
        NSInteger wait_pay = [[messageInfo objectForKey:@"wait_pay"] integerValue];
        NSInteger wait_send = [[messageInfo objectForKey:@"wait_send"] integerValue];
        NSInteger wait_receive = [[messageInfo objectForKey:@"wait_receive"] integerValue];
        NSInteger wait_comment = [[messageInfo objectForKey:@"wait_comment"] integerValue];
        NSInteger coupon = [[messageInfo objectForKey:@"coupon"] integerValue];
        NSInteger sellerDoingCount = [[messageInfo objectForKey:@"sellerDoingCount"] integerValue];
        NSInteger cart = [[messageInfo objectForKey:@"cart"] integerValue];
        cell.daifukuanNumLbl.text =[[messageInfo objectForJSONKey:@"wait_pay"] description];
        cell.daifahuoNumLbl.text =[[messageInfo objectForJSONKey:@"wait_send"] description];
        cell.daishouhuoNumLbl.text = [[messageInfo objectForJSONKey:@"wait_receive"] description];
        cell.daipingjiaNumLbl.text = [[messageInfo objectForJSONKey:@"wait_comment"] description];
        cell.gouwucheNumLbl.text = [[messageInfo objectForJSONKey:@"cart"] description];
//        cart = 103;
        if (cart >99) {
            cell.gouwucheNumLbl.text = @"99+";
            cell.gouwuhe_width_cons.constant = 25;
        }
        cell.dikouquanNumLbl.text =[[messageInfo objectForJSONKey:@"coupon"] description];
        cell.guanzhuNunLbl.hidden = NO;
        cell.daifukuanNumLbl.hidden = NO;
        cell.daifahuoNumLbl.hidden = NO;
        cell.daishouhuoNumLbl.hidden = NO;
        cell.daipingjiaNumLbl.hidden = NO;
        cell.gouwucheNumLbl.hidden = NO;
        cell.dikouquanNumLbl.hidden = NO;
        if (sellerDoingCount == 0) {
            cell.guanzhuNunLbl.hidden = YES;
        }
        if (wait_pay == 0) {
            cell.daifukuanNumLbl.hidden = YES;
        }
        
        if (wait_send == 0) {
            cell.daifahuoNumLbl.hidden = YES;
        }
        
        if (wait_receive == 0) {
            cell.daishouhuoNumLbl.hidden = YES;
        }
        
        if (wait_comment == 0) {
            cell.daipingjiaNumLbl.hidden = YES;
        }
        
        if (cart == 0) {
            cell.gouwucheNumLbl.hidden = YES;
        }
        
        
        if (coupon == 0) {
            cell.dikouquanNumLbl.hidden = YES;
        }
        cell.menuclickBlock = ^(NSInteger selectindex){
            switch (selectindex) {
                case 0://我的订单
                {
                    CYMyOrderViewController *vc = viewControllerInStoryBoard(@"CYMyOrderViewController", @"My");
                    vc.ordertype = OrderTypeAll;
                    //                    //vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 1://代付款
                {
                    CYMyOrderViewController *vc = viewControllerInStoryBoard(@"CYMyOrderViewController", @"My");
                    //                    //vc.hidesBottomBarWhenPushed = YES;
                    vc.ordertype = OrderTypePendingPayment;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 2://待发货
                {
                    CYMyOrderViewController *vc = viewControllerInStoryBoard(@"CYMyOrderViewController", @"My");
                    //                    //vc.hidesBottomBarWhenPushed = YES;
                    vc.ordertype = OrderTypePendingShipped;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 3://待收货
                {
                    CYMyOrderViewController *vc = viewControllerInStoryBoard(@"CYMyOrderViewController", @"My");
                    vc.ordertype = OrderTypeInbound;
                    //                    //vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 4://待评价
                {
                    CYMyOrderViewController *vc = viewControllerInStoryBoard(@"CYMyOrderViewController", @"My");
                    //                    //vc.hidesBottomBarWhenPushed = YES;
                    vc.ordertype = OrderTypeEvaluated;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 5://退款 /退货
                {
                    
                    CYRefundViewController *vc = viewControllerInStoryBoard(@"CYRefundViewController", @"My");
                    //                    CYMyOrderViewController *vc = viewControllerInStoryBoard(@"CYMyOrderViewController", @"My");
                    //                        vc.ordertype = OrderTypeRefund;
                    ////                    //vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 6://购物车
                {
                    
                    CYSCartViewController *vc = viewControllerInStoryBoard(@"CYSCartViewController", @"My");
                    //                    //vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 7://抵扣券
                {
                    CYHongBaoViewController *vc = viewControllerInStoryBoard(@"CYHongBaoViewController", @"My");
                    //                    //vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 8://我的银行卡
                {
                    //                    NSDictionary *scoreStrategy =[messageInfo objectForKey:@"scoreStrategy"];
                    if (contributeLevel.count >0) {
                        CYGonglueController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYGonglueController"];
                        vc.name = [contributeLevel objectForKey:@"title"];
                        vc.url = [contributeLevel objectForKey:@"url"];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    
                    break;
                }
                case 9://贡献等级
                {
                    CYMyGuanZhu *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYMyGuanZhu"];
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 10://我的关注
                {
                    CYMyGuanZhu *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYMyGuanZhu"];
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                    
                default:
                    break;
            }
        };
        return cell;
    }else if (indexPath.section == 4){
        CYMyQuanZiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYMyQuanZiCell"];
        cell.menuclickBlock = ^(NSInteger selectindex){
            switch (selectindex) {
                case 0://我的圈子
                {
                    CYMyGroupViewController *vc = viewControllerInStoryBoard(@"CYMyGroupViewController", @"My");
                    vc.quanzitype = WoDeQuanZiTypeQuanZi;
                    //                    //vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 1://我的话题
                {
                    CYMyGroupViewController *vc = viewControllerInStoryBoard(@"CYMyGroupViewController", @"My");
                    //                    //vc.hidesBottomBarWhenPushed = YES;
                    vc.quanzitype = WoDeQuanZiTypeHuaTi;
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                    
                    
                default:
                    break;
            }
        };
        return cell;
    }else if (indexPath.section == 5){
        CYAdviceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYAdviceCell"];
        cell.menuclickBlock = ^(NSInteger selectIndex){
            CYAdviseViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYAdviseViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        };
        //        CYAdviseViewController
        return cell;
    }else if(indexPath.section ==1){
        
        
        
        CYMyHuoDongCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"CYMyHuoDongCell"];
        
        for (UIView *view  in cell.itemcollectionView.subviews) {
            [view removeFromSuperview];
        }
        CGFloat itemWidth = ((SCREEN_WIDTH-20)/5);
        for (int i =0; i<[activtyArr count]; i++) {
            NSDictionary *info = activtyArr[i];
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i*itemWidth, 0,itemWidth,cell.itemcollectionView.height)];
            view.backgroundColor =CLEARCOLOR;
            [cell.itemcollectionView addSubview:view];
            UIImageView *icoImg =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,20, 20)];
            NSString *imgurl = [info objectForKey:@"thumb"];
            if (imgurl.length >0) {
                [icoImg sd_setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:SQUARE];
            }
            //            [icoImg sizeToFit];
            icoImg.x = (view.width - icoImg.width)/2;
            icoImg.y = 16;
            [view addSubview:icoImg];
            
            UILabel *lable =[[UILabel alloc] initWithFrame:CGRectMake(0,icoImg.height +icoImg.y +5, view.width,20)];
            lable.font = FONT(12.0);
            lable.textAlignment = NSTextAlignmentCenter;
            lable.textColor = CONTENTCOLOR;
            lable.text = [info objectForKey:@"name"];
            [view addSubview:lable];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = view.bounds;
            button.tag = i +560;
            [button addTarget:self action:@selector(item_click:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
        }
        
        return cell;
    }
    return nil;
}

-(void)item_click:(UIButton *)sender
{
    NSInteger selectIndex = sender.tag - 560;
    NSDictionary *info = activtyArr[selectIndex];
    CYPublicHuoDongViewController *vc = viewControllerInStoryBoard(@"CYPublicHuoDongViewController", @"Huodong");
    vc.titleStr = [info objectForKey:@"title"];
    vc.requstUrl = [info objectForKey:@"url"];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)henghuantouxiang:(UITapGestureRecognizer *)sender
{
    //    UIImageView *userImg = (UIImageView *)sender.view;
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照",nil];
    sheet.tag = 1600;
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self album];
        
    }else if (buttonIndex == 1){
        [self takePhoto];
    }
}
#pragma mark 拍照
- (void)takePhoto {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    imagePicker.allowsEditing = YES;
    //媒体类型,默认情况下此数组包含kUTTypeImage，所以拍照时可以不用设置；但是当要录像的时候必须设置，可以设置为kUTTypeVideo（视频，但不带声音）或者kUTTypeMovie（视频并带有声音）
    //    imagePicker.mediaTypes = @[(__bridge NSString *)kUTTypeMovie,(__bridge NSString *)kUTTypeImage];
    //视频最大录制时长(s)
    //    imagePicker.videoMaximumDuration = 15;
    [imagePicker topViewController].view.frame = CGRectMake(0, 0, 320, 300);
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark 从相册中选择
- (void)album {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    imagePicker.allowsEditing = YES;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //        long long size = [SharedInstance fileSizeAtPath:[info objectForKey:UIImagePickerControllerMediaURL]];
    //        NSLog(@"size: %lld  chang:%@",size,[info objectForKey:@"_UIImagePickerControllerVideoEditingEnd"]);
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    //        _showImg.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [CYWebClient Post:@"Usermodify" parametes:@{@"nickname":MANAGER.nickname} files:@{@"avatar":[NSArray arrayWithObject:image]} success:^(id responObject) {
        ChaYuer *manager = MANAGER;
        manager.avatar = [responObject objectForJSONKey:@"avatar"];
        [ChaYuManager archiveCurrentUser:manager];
        [self loadUserInfo];
    } failure:^(id error) {
        [SVProgressHUD showInfoWithStatus:@"请求失败"];
    }];
    
}



- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
