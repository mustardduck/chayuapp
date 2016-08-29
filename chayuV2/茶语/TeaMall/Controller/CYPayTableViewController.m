//
//  CYPayTableViewController.m
//  TeaMall
//
//  Created by Chayu on 15/11/23.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYPayTableViewController.h"
#import "CYPaySuccessTableViewController.h"
#import "WXApiManager.h"
#import "AppDelegate.h"
#import "DataMD5.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
//#import "getIPhoneIP.h"
#import "DataMD5.h"
#import <CommonCrypto/CommonDigest.h>
#import "XMLDictionary.h"
#import "AFNetworking.h"
#import "CYSCartViewController.h"
#import "CYOrderDetailViewController.h"
#import "CYMyOrderViewController.h"
#import "CYProductDetViewController.h"
#import "CYGiftListViewController.h"
//#import "OpenShareHeader.h"
@interface CYPayTableViewController ()<WXApiDelegate,UIAlertViewDelegate>
{
    NSString *resSign;
}
- (IBAction)goback:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
- (IBAction)weixinPay:(id)sender;


- (IBAction)zhifubaoPay_click:(id)sender;


@end

@implementation CYPayTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _priceLbl.text = [NSString stringWithFormat:@"付款金额￥%.2f",[_price floatValue]];
    //    hiddenSepretor(self.tableView);
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





-(void)viewDidLayoutSubviews
{
    
    //    setSepretor(self.tableView);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)goback:(id)sender {
    
    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您是否要取消付款！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alt show];
    
    
    //    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 微信支付
///产生随机字符串
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRST";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

//将订单号使用md5加密
-(NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16]= "0123456789abcdef";
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
//产生随机数
- (NSString *)getOrderNumber{
    int random = arc4random()%10000;
    return [self md5:[NSString stringWithFormat:@"%d",random]];
}
#define WEINXINAPPID @"wxea386816bae46f5a"
#define WEINPARID @"1317817801"
- (void)weixinPay {
    NSString *appid,*mch_id,*nonce_str,*sign,*body,*out_trade_no,*total_fee,*spbill_create_ip,*notify_url,*trade_type,*partner;
    //应用APPID
    appid = @"wxea386816bae46f5a";
    //微信支付商户号
    mch_id = @"1317817801";
    ///产生随机字符串，这里最好使用和安卓端一致的生成逻辑
    nonce_str =[self generateTradeNO];
    body = _orderId;
    //随机产生订单号用于测试，正式使用请换成你从自己服务器获取的订单号
    out_trade_no = _orderId;
    //交易价格1表示0.01元，10表示0.1元
    //    double doulevalue = [_price doubleValue];
    //    CGFloat floatValue = [_price floatValue];
    total_fee = [NSString stringWithFormat:@"%d",(int)([_price doubleValue] *100)];
    //获取本机IP地址，请再wifi环境下测试，否则获取的ip地址为error，正确格式应该是8.8.8.8
    NSString *ipdizhi = nil;
    if ([ipdizhi isEqualToString:@"error"]) {
        ipdizhi = _ipaddress;
    }
    
    if (ipdizhi.length == 0) {
        ipdizhi = @"8.8.8.8";
    }
    spbill_create_ip = ipdizhi;
    
    //    spbill_create_ip = @"127.0.0.1";
    //交易结果通知网站此处用于测试，随意填写，正式使用时填写正确网站
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Url" ofType:@"plist"];
    NSString *hostUrl = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"host"];
    NSDictionary *dicUrl = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"WeiXinReturn"];
    NSString *api = dicUrl[@"api"];
    NSString *huidiaoStr = [NSString stringWithFormat:@"%@/%@/%@",hostUrl,api,_payType];
    notify_url = huidiaoStr;
    trade_type =@"APP";
    //商户密钥
    partner = PARTNERKEY;
    //获取sign签名
    DataMD5 *data = [[DataMD5 alloc] initWithAppid:appid mch_id:mch_id nonce_str:nonce_str partner_id:partner body:body out_trade_no:out_trade_no total_fee:total_fee spbill_create_ip:spbill_create_ip notify_url:notify_url trade_type:trade_type];
    
    
    
    //重要的事情 *************************************记住要修改内部的商户秘钥***********************************
    sign = [data getSignForMD5];
    resSign = sign;
    //设置参数并转化成xml格式
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:appid forKey:@"appid"];//公众账号ID
    [dic setValue:mch_id forKey:@"mch_id"];//商户号
    [dic setValue:nonce_str forKey:@"nonce_str"];//随机字符串
    [dic setValue:sign forKey:@"sign"];//签名
    [dic setValue:body forKey:@"body"];//商品描述
    [dic setValue:out_trade_no forKey:@"out_trade_no"];//订单号
    [dic setValue:total_fee forKey:@"total_fee"];//金额
    [dic setValue:spbill_create_ip forKey:@"spbill_create_ip"];//终端IP
    [dic setValue:notify_url forKey:@"notify_url"];//通知地址
    [dic setValue:trade_type forKey:@"trade_type"];//交易类型
    
    NSString *string = [dic XMLString];
    [self http:string];
}


- (void)http:(NSString *)xml{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //这里传入的xml字符串只是形似xml，但是不是正确是xml格式，需要使用af方法进行转义
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"https://api.mch.weixin.qq.com/pay/unifiedorder" forHTTPHeaderField:@"SOAPAction"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return xml;
    }];
    //发起请求
    
    [manager POST:@"https://api.mch.weixin.qq.com/pay/unifiedorder" parameters:xml progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] ;
        NSLog(@"responseString is %@",responseString);
        //将微信返回的xml数据解析转义成字典
        NSDictionary *dic = [NSDictionary dictionaryWithXMLString:responseString];
        //判断返回的许可
        if ([[dic objectForKey:@"result_code"] isEqualToString:@"SUCCESS"] &&[[dic objectForKey:@"return_code"] isEqualToString:@"SUCCESS"] ) {
            //发起微信支付，设置参数
            PayReq *request = [[PayReq alloc] init];
            request.partnerId = @"1317817801";//[dic objectForKey:@"mch_id"];
            request.prepayId= [dic objectForKey:@"prepay_id"];
            request.package = @"Sign=WXPay";
            request.nonceStr= [dic objectForKey:@"nonce_str"];
            //将当前事件转化成时间戳
            //            request.appid = @"wx244191569272eb01";
            NSDate *datenow = [NSDate date];
            NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
            UInt32 timeStamp =[timeSp intValue];
            request.timeStamp= timeStamp;
            DataMD5 *md5 = [[DataMD5 alloc] init];
            request.sign =  [md5 createMD5SingForPay:@"wxea386816bae46f5a" partnerid:request.partnerId prepayid:request.prepayId package:request.package noncestr:request.nonceStr timestamp:request.timeStamp];
            //            调用微信
            
            [SVProgressHUD dismiss];
            [WXApi sendReq:request];
        }else{
            [SVProgressHUD dismiss];
            NSLog(@"参数不正确，请检查参数");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


-(void)weinxinPayStatus:(NSNotification *)sender
{
    NSDictionary *info = sender.object;
    NSInteger stauts = [[info objectForKey:@"status"] integerValue];
    switch (stauts) {
        case 0:
        {
            [Itost showMsg:@"支付失败" inView:self.view];
            break;
        }
        case 1:
        {
            [self paySuccess];
            break;
        }
        case 2:
        {
            [Itost showMsg:@"支付已取消" inView:self.view];
            break;
        }
            
        default:
            break;
    }
}


-(void)paySuccess
{
    
    CYPaySuccessTableViewController *vc = viewControllerInStoryBoard(@"CYPaySuccessTableViewController", @"TeaMall");
    vc.orderSign = _orderId;
    vc.price = _price;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)AliPay
{
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088911710705539";
    NSString *seller = @"service@chayu.com";
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAL4iephpthke8t8V0oCUr0bBTzBEG+lZ8fCzLtZt0LGPM0U+hK+k20/UJC8R++GlH8Tk0zZksLJ0B94+tvgxefeg/c5f4mlgdsE2Atzsq1JYZ4dU4q8IlI4KpPs3ktGcVwK7XyVTmX4st7GkoIP98sHmb3ovBvyiadY7KWP3crafAgMBAAECgYAt35u8kiTBQtpOQLGdHEJ9y74TYxto3a6l6FVwnuYvMOGp3z+cMSZIyGJCiRBAjNpxYtQi14BaTexoDrGOiEFotvnlIMpMbiPzD9TMfDar3g/J6gzddI3GvIVbEnwqbdOolgaZTWFxvqqQERaGJhWJ6QGB47ijOZl7mZn61aHS4QJBAOa4pPMwMzUqORWOfmqgh1t4dYt/iSR3TfVcvBJW+CM5wej9TbWJABANVB1rWDzIT1rffkT/lhUyODx+m8j7/lsCQQDS93JudDcyvYUmvRcwlig7XnVsijT1GBS4iwWTVvgzyUiyA9H7yzZreX3I5ep3NsCKeI73ZLz4pOoJ+YYyRiQNAkEA2qj981in/2fvx+VPHADdp6wHQtjxAbVsFfD4cS0paEER7J08K6MWgyAOqv8UFi8FPit4AS51b8szjumy/Q0N5wJBAJD4P2dNbxzsBRKwv73AgZcCeviCJJAD40FJLySnj9muSMkjPOmlJBlInDowXCVdt4OwArZYQE8wrC78i84CSwUCQAlnCKQONQvey++E98xYUNn/kudRZUkP3jIn/Ygp6B7hkTJJT9YMhA3UBZUgzcUBTXBi/M6+n/1TXeoRg1HwGH8=";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = _orderId; //订单ID（由商家自行制定）
    order.productName = order.tradeNO;//product.subject; //商品标题
    order.productDescription = order.tradeNO;//product.body; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",[_price floatValue]]; //商品价格
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Url" ofType:@"plist"];
    NSString *hostUrl = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"host"];
    NSDictionary *dicUrl = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"AlipayReturn"];
    NSString *api = dicUrl[@"api"];
    NSString *huidiaoStr = [NSString stringWithFormat:@"%@/%@/%@",hostUrl,api,_payType];
    order.notifyURL = huidiaoStr;//[CYWebClient urlWithName:@"AlipayReturn"]; //回调URL
    //    order.notifyURL = @"http://aniderr.oicp.net:24950/shiji/1.0/payreturn/AlipayReturn";
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"ChaYu";
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        [SVProgressHUD dismiss];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.at = kAuthorizeTypeAliPay;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zhifubaozhifu:) name:ZHIFUBAOZHIFIHUIDIAO object:nil];
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"支付宝回调 = %@",resultDic);
            //              NSInteger resultStatus = [[resultDic objectForKey:@"resultStatus"] integerValue];
            if ([[resultDic objectForKey:@"resultStatus"] integerValue] == 9000) {
                [self paySuccess];
            }else{
                
                NSString *errorStr = [resultDic objectForKey:@"memo"];
                if (errorStr.length) {
                    [Itost showMsg:[resultDic objectForKey:@"memo"] inView:self.view];
                }else{
                    [Itost showMsg:@"取消支付" inView:self.view];
                }
                
            }
        }];
    }
    
    
}


-(void)zhifubaozhifu:(NSNotification *)sender
{
    NSDictionary *info = sender.object;
    NSLog(@"reslut = %@",info);
    
    
    if ([[info objectForKey:@"resultStatus"] integerValue] == 9000) {
        [self paySuccess];
    }else{
        
        NSString *errorStr = [info objectForKey:@"memo"];
        if (errorStr.length) {
            [Itost showMsg:[info objectForKey:@"memo"] inView:self.view];
        }else{
            [Itost showMsg:@"取消支付" inView:self.view];
        }
        
    }
    
}
#pragma mark -
#pragma mark UIAlertViewDelegate method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
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
    }
}

- (IBAction)weixinPay:(id)sender {
    if (![WXApi isWXAppInstalled]) {
        [Itost showMsg:@"您尚未安装微信客户端，请安装后继续支付!" inView:WINDOW];
        return;
    }
    
    
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showWithStatus:@"请求支付中，请稍等"];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.at = kAuthorizeTypeWeinXinPay;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weinxinPayStatus:) name:weiXinPayStatus object:nil];
    [self weixinPay];
}

- (IBAction)zhifubaoPay_click:(id)sender {
    [SVProgressHUD showWithStatus:@"请求支付中，请稍等"];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.at = kAuthorizeTypeAliPay;
    [self AliPay];
}
@end
