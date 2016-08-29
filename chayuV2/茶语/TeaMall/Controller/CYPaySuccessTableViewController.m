//
//  CYPaySuccessTableViewController.m
//  TeaMall
//
//  Created by Chayu on 15/11/23.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYPaySuccessTableViewController.h"
#import "CYSelectGiftViewController.h"
#import "CYMyOrderViewController.h"
#import "CYMasterListViewController.h"
#import "CYGiftListViewController.h"
#import "CYSCartViewController.h"
#import "CYOrderDetailViewController.h"
#import "CYMyOrderViewController.h"
#import "CYProductDetViewController.h"
#import "CYPayTableViewController.h"
#import "AppDelegate.h"
#import "BaseButton.h"
@interface CYPaySuccessTableViewController ()<UIActionSheetDelegate>
{
    BOOL hasGift;//是否可选择礼品
    OSMessage *message;
    NSString *orderId;
}
- (IBAction)goback:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
- (IBAction)lingqudikouquan_click:(id)sender;
- (IBAction)lingquchali_click:(id)sender;

- (IBAction)chakandingdan_click:(id)sender;

- (IBAction)jixugouwu_click:(id)sender;

- (IBAction)chayushouye_click:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *linquchali_center_x_cons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fenxiang_center_x_cons;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
//顶部高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top_height_cons;
@property (weak, nonatomic) IBOutlet BaseButton *fenxiangBtn;
@property (weak, nonatomic) IBOutlet BaseButton *linquBtn;


@end

@implementation CYPaySuccessTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    hasGift = NO;
    message = [[OSMessage alloc] init];
    _priceLbl.text = [NSString stringWithFormat:@"您已成功支付%@元",_price];
    
    [self webpostisSendGift];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webpostisSendGift
{
    [CYWebClient Post:@"isSendGift" parametes:@{@"orderSn":_orderSign} success:^(id responObject) {
        hasGift = [[responObject objectForKey:@"isSendGift"] boolValue];
        message.title = [responObject objectForKey:@"shareTitle"];
        message.desc = [responObject objectForKey:@"shareDesc"];
        message.link =[responObject objectForKey:@"shareUrl"];
        message.imgUrl = [responObject objectForKey:@"shareThumb"];
        orderId = [responObject objectForKey:@"orderId"];
        if (orderId.length == 0 && hasGift) {
            _linquchali_center_x_cons.constant = 0;
            _statusLbl.hidden = YES;
            _fenxiangBtn.hidden = YES;
        }
       
        if (orderId.length >0 && !hasGift) {
            _fenxiang_center_x_cons.constant = 0.0;
            _linquBtn.hidden = YES;
            
        }
       
        if (!orderId.length && !hasGift) {
            _top_height_cons.constant = 160.0;
             _linquBtn.hidden = YES;
            _fenxiangBtn.hidden = YES;
        }
        
    } failure:^(id error) {
        
    }];
}

- (IBAction)goback:(id)sender {
    
    NSArray *vcArr = self.navigationController.viewControllers;
    UIViewController *aimVC = nil;
    for (NSInteger i=vcArr.count-1; i>=0; i--) {
        if ([vcArr[i] isKindOfClass:[CYOrderDetailViewController class]] ||[vcArr[i] isKindOfClass:[CYSCartViewController class]] ||[vcArr[i] isKindOfClass:[CYMyOrderViewController class]]||[vcArr[i] isKindOfClass:[CYProductDetViewController class]]) {
            aimVC = vcArr[i];
            break;
        }
    }
    if (aimVC) {
        [self.navigationController popToViewController:aimVC animated:YES];
    }
    
//    [self.navigationController popToRootViewControllerAnimated:NO];
//    [[NSNotificationCenter defaultCenter] postNotificationName:tabBarIndex object:@{@"selectIndex":@"3"}];
}
- (IBAction)lingqudikouquan_click:(id)sender {
    if (message.title.length == 0) {
        return;
    }
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"微信朋友圈",@"微信好友", nil];
    [sheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (buttonIndex<2) {
        UIImage *img = [UIImage imageNamed:@"AppIcon60x60@2x.png"];
        UIImageView *imgView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        //    [imgView sd_setImageWithURL:[NSURL URLWithString:productModel.albumList[0]] placeholderImage:img];
        NSMutableString *imgUrl = [NSMutableString stringWithString:message.imgUrl];
        
        if ([imgUrl hasSuffix:@"800800"]) {
            imgUrl = [NSMutableString stringWithString:[imgUrl substringToIndex:imgUrl.length -6]];
            [imgUrl appendString:@"160160"];
        }
        [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:img completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.at = kAuthorizeTypeUMLog;
            
            if (!error) {
                message.image = UIImageJPEGRepresentation(image, 0.1);
                NSData *data  =UIImageJPEGRepresentation(image, 0.1);
                if (data.length/1024>32) {
                    message.image = UIImageJPEGRepresentation(img, 0.1);
                }
                
            }else{
                message.image = UIImageJPEGRepresentation(img, 0.1);;
            }
            
            [UMSocialData defaultData].extConfig.title = message.title;
            //
            UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:
                                                message.link];
            NSString *shareType = @"";
            if (buttonIndex ==0) { //朋友圈
                shareType = UMShareToWechatTimeline;
                [UMSocialData defaultData].extConfig.wechatTimelineData.url = message.link;
                [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = message.desc;
                [UMSocialData defaultData].extConfig.wechatTimelineData.shareImage = message.image;
            }else{//微信好友
                shareType = UMShareToWechatSession;
                [UMSocialData defaultData].extConfig.wechatSessionData.url = message.link;
                [UMSocialData defaultData].extConfig.wechatSessionData.shareText = message.desc;
                [UMSocialData defaultData].extConfig.wechatSessionData.shareImage = message.image;
            }
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pengyouquanfenxiang) name:PENYOUQUANFENXIANG object:nil];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[shareType] content:nil image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
                if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                    if (orderId.length) {
                    }
                    
                }
            }];
        }];
        
    }
}



-(void)pengyouquanfenxiang
{
    _linquchali_center_x_cons.constant = 0;
    _fenxiangBtn.hidden = YES;
    if (orderId.length) {
        [CYWebClient Post:@"2_user.coupon.paySuccessShare" parametes:@{@"order_id":orderId} success:^(id responObject) {
            
        } failure:^(id error) {
            
        }];
    }
}

- (IBAction)lingquchali_click:(id)sender {
    CYGiftListViewController *vc= viewControllerInStoryBoard(@"CYGiftListViewController", @"TeaMall");
    vc.orderSign = _orderSign;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)chakandingdan_click:(id)sender {
    CYMyOrderViewController *vc = viewControllerInStoryBoard(@"CYMyOrderViewController", @"My");
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)jixugouwu_click:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:tabBarIndex object:@{@"selectIndex":@"2"}];
  
}

- (IBAction)chayushouye_click:(id)sender {
     [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:tabBarIndex object:@{@"selectIndex":@"0"}];
   
}
@end
