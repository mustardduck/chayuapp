//
//  CYPublicHuoDongViewController.m
//  茶语
//
//  Created by Chayu on 16/7/7.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYPublicHuoDongViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "RPUUID.h"
#import "CYProductDetViewController.h"
#import "CYHongBaoViewController.h"
#import "CYActionSheet.h"
@interface CYPublicHuoDongViewController ()<UIWebViewDelegate>
{
    NSInteger page;
    NSString *absoluteString;
    BOOL isAdd;
    NSMutableArray *urlArr;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,weak) JSContext * context;
- (IBAction)goback:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;

@end

@implementation CYPublicHuoDongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    urlArr =[NSMutableArray array];
    _webView.delegate = self;
    isAdd = YES;
    self.title = _titleStr;
    _titleLb.text = _titleStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APP_DELEGATE setTabbarHidden:YES animated:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    page = 0;
    NSString *token = @"";
    if (MANAGER.loginToken.length) {
        token = MANAGER.loginssectionid;
    }
    isAdd = YES;
    NSString *com = @"?";
    NSString *requrl  = nil; //[NSString stringWithFormat:@"%@?imei=%@&token=%@",_requstUrl,[RPUUID UUID],token];;
    NSRange rang = [_requstUrl rangeOfString:com];
    //    NSString *requrl  = [NSString stringWithFormat:@"%@?imei=%@&token=%@",_requstUrl,[RPUUID UUID],token];;
    if (rang.location == NSNotFound) {
        requrl = [NSString stringWithFormat:@"%@?imei=%@&sessionid=%@",_requstUrl,[RPUUID UUID],token];
    }else{
        requrl = [NSString stringWithFormat:@"%@&imei=%@&sessionid=%@",_requstUrl,[RPUUID UUID],token];
    }
    absoluteString = requrl;
    
    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD show];
    NSURLRequest *requst = [NSURLRequest requestWithURL:[NSURL URLWithString:requrl]];
    [_webView loadRequest:requst];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)goback:(id)sender {
    
    
    if (page >1) {
        NSString *urlstr = [urlArr objectAtIndex:urlArr.count-2];
        NSURLRequest *requst = [NSURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
        [_webView loadRequest:requst];
        [urlArr removeLastObject];
        page --;
        isAdd = NO;
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"request.URL.absoluteString = %@",request.URL.absoluteString);
    
    if (isAdd) {
        page +=1;
        [urlArr addObject:request.URL.absoluteString];
        NSLog(@"page = %d",(int)page);
    }
    isAdd = YES;
    
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
    _context[@"shijiIndex"] = ^(){
        NSLog(@"市集首页");
        dispatch_async(dispatch_get_main_queue(), ^{
            //            self.hidesBottomBarWhenPushed = YES;
            //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //            AppDelegate *appledelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            //
            //            viewCon.hidesBottomBarWhenPushed = YES;
            //             appledelegate.tabBarController.tabBar.hidden = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:tabBarIndex object:@{@"selectIndex":@"2"}];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            //            });
            
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
    
}


@end
