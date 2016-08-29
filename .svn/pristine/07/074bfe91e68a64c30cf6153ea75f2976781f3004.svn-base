//
//  CYGonglueController.m
//  茶语
//
//  Created by Chayu on 16/7/29.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYGonglueController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "RPUUID.h"
#import "CYProductDetViewController.h"
#import "CYHongBaoViewController.h"
#import "CYActionSheet.h"
#import "CYBindingPhoneViewController.h"
@interface CYGonglueController ()<UIWebViewDelegate>
{
    NSInteger page;
    NSString *absoluteString;
    BOOL isAdd;
    NSMutableArray *urlArr;
}
@property (nonatomic,weak) JSContext * context;



- (IBAction)goback:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation CYGonglueController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView.delegate = self;
    _titleLbl.text = _name;
    NSString *token = @"";
    if (MANAGER.loginssectionid.length>0) {
        token = MANAGER.loginssectionid;
    }
    NSString *com = @"?";
    NSString *requrl  = nil; //[NSString stringWithFormat:@"%@?imei=%@&token=%@",_requstUrl,[RPUUID UUID],token];;
    NSRange rang = [_url rangeOfString:com];
    //    NSString *requrl  = [NSString stringWithFormat:@"%@?imei=%@&token=%@",_requstUrl,[RPUUID UUID],token];;
    if (rang.location != NSNotFound) {
        requrl = [NSString stringWithFormat:@"%@&source=%@&sessionid=%@",_url,@"2",token];
    }else{
        requrl = [NSString stringWithFormat:@"%@?source=%@&sessionid=%@",_url,@"2",token];
    }
    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD show];
    NSURLRequest *requst = [NSURLRequest requestWithURL:[NSURL URLWithString:requrl]];
    [_webView loadRequest:requst];
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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"request.URL.absoluteString = %@",request.URL.absoluteString);
    
//    if (isAdd) {
//        page +=1;
//        [urlArr addObject:request.URL.absoluteString];
//        NSLog(@"page = %d",(int)page);
//    }
//    isAdd = YES;
    
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
      [SVProgressHUD dismiss];
    _context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    _context[@"login"] = ^(){
        dispatch_async(dispatch_get_main_queue(), ^{
            [APP_DELEGATE showLogView];
        });
        NSLog(@"登录");
    };
    _context[@"appRegister"] = ^(){
        NSLog(@"注册");
    };
    
    _context[@"appMobileBind"] = ^(){
        NSLog(@"绑定");
        dispatch_async(dispatch_get_main_queue(), ^{
            CYBindingPhoneViewController *vc = viewControllerInStoryBoard(@"CYBindingPhoneViewController", @"Log");
            vc.backBlock = ^(NSString *phonenum){
                
            };
            [self.navigationController pushViewController:vc animated:YES];
        });
    };
    
    
    _context[@"shijiIndex"] = ^(){
        NSLog(@"市集首页");
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:tabBarIndex object:@{@"selectIndex":@"2"}];
        });
    };
    _context[@"appQuanzi"] = ^(){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:tabBarIndex object:@{@"selectIndex":@"3"}];
        });
      

    };
    
    _context[@"appChaping"] = ^(){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:tabBarIndex object:@{@"selectIndex":@"1"}];
        });
      
    };
    _context[@"appIndex"] = ^(){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:tabBarIndex object:@{@"selectIndex":@"0"}];
        });
        
    };
    _context[@"appUser"] = ^(){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self goback:nil];
        });
        
    };
    _context[@"myCoupon"] = ^(){
        
        NSLog(@"优惠券");
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!MANAGER.isLoged) {
                [APP_DELEGATE showLogView];
                return;
            }
            CYHongBaoViewController *vc = viewControllerInStoryBoard(@"CYHongBaoViewController", @"My");
            [self.navigationController pushViewController:vc animated:YES];
            
        });
        
    };
    _context[@"share"] = ^(){
        NSLog(@"分享");
        NSArray * args = [JSContext currentArguments];
        NSLog(@"args0 = %@ args1 = %@ args2 = %@args3 = %@",args[0],args[1],args[2],args[3]);
        
        //        return ;
        if ([args count]==4) {
            NSString *shareimg = [NSString stringWithFormat:@"%@",args[1]];
            
            //                if (!shareimg.length) {
            //                    shareimg = [manager.tuijianInfo objectForKey:@"shareimg"];
            //                }
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:shareimg] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
            } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                appDelegate.at = kAuthorizeTypeUMLog;
                OSMessage *message = [[OSMessage alloc] init];
                NSString *shareTitle = [NSString stringWithFormat:@"%@",args[0]];
                //                    if (!shareTitle.length) {
                //                        shareTitle = [manager.tuijianInfo objectForKey:@"sharetitle"];
                //                    }
                message.title = shareTitle; //@"通茶语，会知己";
                NSString *sharedesc = [NSString stringWithFormat:@"%@",args[3]];
                //                    if (!sharedesc.length) {
                //                        sharedesc = [manager.tuijianInfo objectForKey:@"sharedesc"];
                //                    }
                
                message.desc = sharedesc;
                NSString *shareurl = [NSString stringWithFormat:@"%@",args[2]];
                //                    if (!shareurl.length) {
                //                        shareurl = [manager.tuijianInfo objectForKey:@"shareurl"];
                //                    }
                
                message.link = shareurl;
                if (image) {
                    message.image = UIImageJPEGRepresentation(image, 0.1);
                }else
                {
                    message.image = UIImagePNGRepresentation([UIImage imageNamed:@"AppIcon60x60@2x.png"]);
                }
                
                
                CYActionSheet *sheet = [[CYActionSheet alloc] initWithTitles:nil iconNames:nil];
                sheet.shareMessage = message;
                [sheet showActionSheetWithClickBlock:^(int btnIndex) {
                    
                } cancelBlock:^{
                    
                }];
            }];
        }
        
        //        });
    };
    
    _context[@"goodsDetail"] = ^(){
        NSArray * args = [JSContext currentArguments];
        dispatch_async(dispatch_get_main_queue(), ^{
            CYProductDetViewController *vc= viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
            vc.goodId = [args[0] description];
            [self.navigationController pushViewController:vc animated:YES];
        });
        
        NSLog(@"args%@",args);
        NSLog(@"商品详情");
    };

    
}


- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
