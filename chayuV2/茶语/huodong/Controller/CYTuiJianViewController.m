//
//  CYTuiJianViewController.m
//  茶语
//
//  Created by Chayu on 16/6/2.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTuiJianViewController.h"
#import "CYLingChaViewController.h"
#import "CYActionSheet.h"
#import "CYHuoDongGuiZeController.h"
#import "BaseButton.h"
@interface CYTuiJianViewController ()
{
    NSMutableDictionary *infoDic;
    NSInteger maxNumber;
}

@property (weak, nonatomic) IBOutlet BaseButton *linquBtn;

@property (weak, nonatomic) IBOutlet UILabel *altLbl;

- (IBAction)huodongguize_click:(id)sender;

- (IBAction)chalixiangqing_click:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *tYaoqingmaLbl;


- (IBAction)fuzhi_click:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *tRenshuLbl;

- (IBAction)lijilingqu_click:(id)sender;


- (IBAction)yaoqingpengyou_click:(id)sender;


- (IBAction)denglu_click:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *dengluButton;


@property (weak, nonatomic) IBOutlet UIView *codeBg;

@end

@implementation CYTuiJianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"首次下载茶语网APP或成功邀请你的朋友下载，即可获得柑普一枚。邀请越多收获越多。"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor getColorWithHexString:@"e25103"] range:NSMakeRange(26,14)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor getColorWithHexString:@"666666"] range:NSMakeRange(30,1)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor getColorWithHexString:@"666666"] range:NSMakeRange(str.length-1,1)];
 
    _altLbl.attributedText = str;
    
    maxNumber = 0;
    
    NSMutableAttributedString *buttonStr = [[NSMutableAttributedString alloc] initWithString:@"请登录后查看我的邀请码 >"];
    [buttonStr addAttribute:NSForegroundColorAttributeName value:[UIColor getColorWithHexString:@"999999"] range:NSMakeRange(0,6)];
    [buttonStr addAttribute:NSForegroundColorAttributeName value:[UIColor getColorWithHexString:@"e25103"] range:NSMakeRange(6,7)];
    [_dengluButton setAttributedTitle:buttonStr forState:UIControlStateNormal];
    
    ChaYuer *manager = [ChaYuManager getCurrentUser];
    if (!manager.isLoged) {
        _codeBg.hidden =  YES;
    }else{
       
    }
    
    
}

-(void)loadViewData
{
      ChaYuer *manager = [ChaYuManager getCurrentUser];
    [CYWebClient Post:@"youli_index" parametes:nil success:^(id responObj) {
        infoDic = [NSMutableDictionary dictionaryWithDictionary:responObj];
        
        if (manager.isLoged) {
            NSString *code  = [infoDic objectForKey:@"code"];
            if (!code.length) {
                code = [manager.tuijianInfo objectForKey:@"code"];
            }
             _tYaoqingmaLbl.text = code;
            
            NSString *countMan =[responObj objectForJSONKey:@"countMan"];
            NSString *maxNumberStr = [responObj objectForJSONKey:@"maxNumber"];
            if (!countMan.length) {
                countMan = @"0";
            }
            if (!maxNumberStr.length) {
                maxNumberStr = @"0";
            }
            
            
            if (manager.isLoged && _tYaoqingmaLbl.text.length) {
                manager.tuijianInfo = infoDic;
                [ChaYuManager archiveCurrentUser:manager];
            }
            maxNumber = [maxNumberStr integerValue];
            _tRenshuLbl.text = [NSString stringWithFormat:@"已成功邀请%@人，有%@份茶礼可领",countMan,maxNumberStr];
            
        }
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    ChaYuer *manager = [ChaYuManager getCurrentUser];
    if (!manager.isLoged) {
        _codeBg.hidden =  YES;
    }else{
        _codeBg.hidden = NO;
      
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self loadViewData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)huodongguize_click:(id)sender {
    CYHuoDongGuiZeController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYHuoDongGuiZeController"];
    vc.titleStr = @"活动规则";
    vc.webUrl = [infoDic objectForKey:@"hdgz"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)chalixiangqing_click:(id)sender {
    CYHuoDongGuiZeController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYHuoDongGuiZeController"];
    vc.titleStr = @"茶礼详情";
    vc.webUrl = [infoDic objectForKey:@"clxq"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)fuzhi_click:(id)sender {
    [Itost showMsg:@"已复制到粘贴板" inView:WINDOW];
    
//     [Itost showMsg:@"你的茶礼领完啦，邀请好友下载茶语APP又可以领哦！" inView:WINDOW];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _tYaoqingmaLbl.text;
}
- (IBAction)lijilingqu_click:(id)sender {
    
    
    ChaYuer *manager = [ChaYuManager getCurrentUser];
    if (!manager.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    
    if (maxNumber == 0) {
        [Itost showMsg:@"你的茶礼领完啦，邀请好友下载茶语APP又可以领哦！" inView:self.view];
        return;
    }
    
    CYLingChaViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYLingChaViewController"];;
    vc.info = infoDic;
    vc.maxnumber = [NSString stringWithFormat:@"%d",(int)maxNumber];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)yaoqingpengyou_click:(id)sender {
    
    ChaYuer *manager = [ChaYuManager getCurrentUser];
    if (!manager.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    
    NSString *shareimg = [infoDic objectForKey:@"shareimg"];
    if (!shareimg.length) {
        shareimg = [manager.tuijianInfo objectForKey:@"shareimg"];
    }
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:shareimg] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.at = kAuthorizeTypeUMLog;
        OSMessage *message = [[OSMessage alloc] init];
        NSString *shareTitle = [infoDic objectForKey:@"sharetitle"];
        if (!shareTitle.length) {
            shareTitle = [manager.tuijianInfo objectForKey:@"sharetitle"];
        }
        message.title = shareTitle; //@"通茶语，会知己";
        NSString *sharedesc = [infoDic objectForKey:@"sharedesc"];
        if (!sharedesc.length) {
            sharedesc = [manager.tuijianInfo objectForKey:@"sharedesc"];
        }
        
        message.desc = sharedesc;
        NSString *shareurl = [infoDic objectForKey:@"shareurl"];
        if (!shareurl.length) {
            shareurl = [manager.tuijianInfo objectForKey:@"shareurl"];
        }
        
        message.link = shareurl;
        if (image) {
            message.image = UIImageJPEGRepresentation(image, 0.1);
        }else
        {
            message.image = UIImagePNGRepresentation([UIImage imageNamed:@"AppIcon60x60@2x.png"]);
        }
        
        
        
//        [UMSocialData defaultData].extConfig.title = @"分享的title";
//        [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
//        [UMSocialSnsService presentSnsIconSheetView:self
//                                             appKey:@"5733e922e0f55a9a7b000240"
//                                          shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
//                                         shareImage:[UIImage imageNamed:@"icon"]
//                                    shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
//                                           delegate:nil];

        
        CYActionSheet *sheet = [[CYActionSheet alloc] initWithTitles:nil iconNames:nil];
        sheet.shareMessage = message;
        [sheet showActionSheetWithClickBlock:^(int btnIndex) {
            
        } cancelBlock:^{
            
        }];
    }];
    
}

- (IBAction)denglu_click:(id)sender {
//    ChaYuer *manager = [ChaYuManager getCurrentUser];
    [APP_DELEGATE showLogView];

}

@end
