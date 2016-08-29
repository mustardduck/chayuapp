//
//  CYBuyerPDDetailVC.m
//  茶语
//
//  Created by Leen on 16/7/8.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerPDDetailVC.h"
//#import "CYPDTopView.h"
#import "CYBuyerPDTopView.h"
#import "CYPDBaseMesView.h"
#import "CYBuyerEvaluationView.h"
#import "CYSpecificationView.h"
//#import "StandarShareView.h"
#import "AppDelegate.h"
#import "CYActionSheet.h"
#import "CYShopTrolleyModel.h"
#import "CYOrderDetailModel.h"
#import "CYConfirmOrderViewController.h"
#import "CYMasterDetailViewController.h"
#import "CYBuyerProFooterVIew.h"
#import "BaseLable.h"
#import "CYSCartViewController.h"
#import "BBWebView.h"
#import "CYMasterDetailViewController.h"
#import "CYAllEvaluationView.h"
#import "CYBuyerDetailVC.h"
#import "CYBaseLineLable.h"
#import "UICommon.h"


@interface CYBuyerPDDetailVC ()<CYBuyerPDTopViewDelegate,CYSpecificationViewDelegate,UIAlertViewDelegate,BBWebViewSizeAdjust,UIWebViewDelegate,CYBuyerProFooterVIewDelegate, UIGestureRecognizerDelegate,CYBuyerEvaluationViewDelegate>
{
    CYProductDetailsModel *productModel;
    BOOL isBuy;//是否是购买
    CGFloat endWebHeight;
    BBWebView *webView;
    NSString *shareurl;
    BOOL allvalueShow; //所有评价是否显示
    int _lastPosition;    //A variable define in headfile
}

@property (weak, nonatomic) IBOutlet UIButton *nomoreBtn;


@property (nonatomic,strong)CYBuyerPDTopView *productTopView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentView;
/**
 *  底部大师相关+其他人买
 */
@property (nonatomic,strong)CYBuyerProFooterVIew *footerView;
/**
 *  基本信息view
 */
@property (nonatomic,strong)CYPDBaseMesView *baseMessageView;
/**
 *  评价view
 */
@property (nonatomic,strong)CYBuyerEvaluationView *evaluationView;

@property (nonatomic,strong)CYSpecificationView *specificationView;


@property (nonatomic,strong)CYAllEvaluationView *allEvaView;

@property (weak, nonatomic) IBOutlet BaseLable *cartNum;

@property (nonatomic,strong)UIView *detailViw;

- (IBAction)goback:(id)sender;

- (IBAction)bottom_click:(id)sender;

- (IBAction)gouwuche_click:(id)sender;

- (IBAction)shoucang_click:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *shoucangImg;

@property (weak, nonatomic) IBOutlet UIView *productBottomView;


/**
 *  悬浮框商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *pdTilteLbl;
@property (weak, nonatomic) IBOutlet UIImageView *pdLikeIcon;
@property (weak, nonatomic) IBOutlet UILabel *pdKuCunLbl;
@property (weak, nonatomic) IBOutlet UILabel *pdYiShouLbl;
@property (weak, nonatomic) IBOutlet UILabel *pdPriceLbl;
@property (weak, nonatomic) IBOutlet CYBaseLineLable *pdOddPriceLbl;

@end

@implementation CYBuyerPDDetailVC

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    CGFloat currentPostion = _contentView.contentOffset.y;

    if(recognizer.direction==UISwipeGestureRecognizerDirectionDown) {
        
        NSLog(@"swipe down");
        //执行程序
        
        if(currentPostion < SCREEN_HEIGHT - 90 - 45)
        {
            [UIView animateWithDuration:0.4 animations:^{
                _productBottomView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
            }];
        }
    }
    if(recognizer.direction==UISwipeGestureRecognizerDirectionUp) {
        
        NSLog(@"swipe up");
        
        //执行程序
        [UIView animateWithDuration:0.4 animations:^{
            _productBottomView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, SCREEN_HEIGHT - 45);
        }];
    }
}

- (IBAction)shareGoods_click:(id)sender
{
    [self shareGoods];
}

- (void)PDTopViewlikeClicked
{
    _pdLikeIcon.highlighted = !_pdLikeIcon.highlighted;
}

- (IBAction)like_click:(id)sender {
    ChaYuer *manager = [ChaYuManager  getCurrentUser];
    if (!manager.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    [CYWebClient Post:@"userdoEnjoy" parametes:@{@"goods_id":productModel.goodsId} success:^(id responObject) {
        _pdLikeIcon.highlighted = !_pdLikeIcon.highlighted;
        
        _productTopView.xihuanImg.highlighted = !_productTopView.xihuanImg.highlighted;
        
        
    } failure:^(id error) {
        
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *applegate = APP_DELEGATE;
    applegate.searchType = CYSearchTypeGoods;
    
    UISwipeGestureRecognizer * ge = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [ge setDirection:UISwipeGestureRecognizerDirectionUp];
    ge.delegate = self;
    ge.cancelsTouchesInView = NO;
    [_contentView addGestureRecognizer:ge];
    
    ge = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [ge setDirection:UISwipeGestureRecognizerDirectionDown];
    ge.delegate = self;
    ge.cancelsTouchesInView = NO;
    [_contentView addGestureRecognizer:ge];
    
    isBuy = YES;
    endWebHeight = 1.0;
    allvalueShow = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        webView = [[BBWebView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,1)];
        webView.sizeDelegate = self;
        webView.scrollView.scrollEnabled = NO;
        webView.scalesPageToFit = YES;
        webView.userInteractionEnabled = NO;
        //        webView.delegate = self;
        [_contentView addSubview:webView];
        
        [_contentView addSubview:self.productTopView];
        
        [_contentView addSubview:self.evaluationView];

        _contentView.contentSize = CGSizeMake(SCREEN_WIDTH,self.productTopView.height);
        
    });
    
    
    //    self.barStyle = NavBarStyleNoneMore;
    __weak typeof(self) weakSelf = self;
    [CYWebClient Post:@"GoodsDetail" parametes:@{@"goods_id":_goodId} success:^(id responObj) {
        productModel = [CYProductDetailsModel objectWithKeyValues:responObj];
        productModel.goodsId = _goodId;
        
        
        if (MANAGER.isLoged) {
            if ([productModel.isFavorited boolValue]) {
                _shoucangImg.highlighted = YES;
            }
            if ([productModel.is_enjoy boolValue]) {
                _pdLikeIcon.highlighted = YES;
            }
            
            
        }
        
        
        _pdTilteLbl.text = productModel.name;
        _pdPriceLbl.text = [NSString stringWithFormat:@"￥%@",productModel.specDataDef[@"pricePromote"]];
        NSString *proPrice = [NSString stringWithFormat:@"￥%@",productModel.specDataDef[@"price"]];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:proPrice];
        [attrStr addAttribute:NSStrikethroughStyleAttributeName value:@(YES) range:NSMakeRange(0,proPrice.length)];
        [attrStr addAttribute:NSStrikethroughColorAttributeName value:CONTENTCOLOR range:NSMakeRange(0, proPrice.length)];
        _pdOddPriceLbl.attributedText = attrStr;

        NSInteger isPromote = [productModel.specDataDef[@"isPromote"] integerValue];
        if (isPromote == 0) {
            _pdOddPriceLbl.hidden = YES;
            _pdPriceLbl.text = [NSString stringWithFormat:@"￥%@",productModel.specDataDef[@"price"]];
        }

        NSInteger stock = [[productModel.specDataDef objectForJSONKey:@"stock"] integerValue];
        if (stock == 0) {
            _nomoreBtn.hidden = NO;
        }else{
            _nomoreBtn.hidden = YES;
        }
        _pdKuCunLbl.text = [NSString stringWithFormat:@"库存 %ld", stock];
        _pdYiShouLbl.text = [NSString stringWithFormat:@"已售 %@",productModel.salesBase];

        weakSelf.productTopView.productModel = productModel;
        weakSelf.baseMessageView.dataArr = productModel.attrList;
        weakSelf.baseMessageView.height = [productModel.attrList count]*44;
        weakSelf.specificationView.productModel = productModel;
        
        if (![productModel.sellerUid isEqualToString:@"0"]) {
            weakSelf.footerView.seller = productModel.seller;
            weakSelf.footerView.goodsList = productModel.guanliansale;
            weakSelf.footerView.sellerUid = productModel.sellerUid;
        }
        
        weakSelf.contentView.hidden = NO;
        [webView loadHTMLString:productModel.introduce baseURL:[NSURL URLWithString:@"http://www.chayu.alp/"]];
        shareurl = [responObj objectForKey:@"shareurl"];

    } failure:^(id err) {
        NSLog(@"%@",err);
    }];

}




-(void)loadCartNum
{
    [CYWebClient Post:@"cartcount" parametes:nil success:^(id responObj) {
        if ([[responObj objectForJSONKey:@"count"]integerValue] == 0) {
            _cartNum.hidden = YES;
        }else{
            _cartNum.hidden = NO;
        }
        _cartNum.text = [responObj objectForJSONKey:@"count"];
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
    [MobClick beginLogPageView:self.title];
    if ([MANAGER isLoged]) {
        [self loadCartNum];
    }else{
        _cartNum.hidden = YES;
    }
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:self.title];
}

- (CYBuyerPDTopView *)productTopView
{
    if (!_productTopView) {
        _productTopView = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerPDTopView" owner:nil options:nil] firstObject];
        _productTopView.delegate = self;
        _productTopView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 156);
        
    }
    return _productTopView;
}

- (CYPDBaseMesView *)baseMessageView
{
    if (!_baseMessageView) {
        _baseMessageView = [[CYPDBaseMesView alloc] initWithFrame:CGRectMake(0,self.productTopView.height,SCREEN_WIDTH,self.view.height-114)];
        
    }
    return _baseMessageView;
}

- (CYBuyerEvaluationView *)evaluationView
{
    if (!_evaluationView) {
        _evaluationView = [[[NSBundle mainBundle]loadNibNamed:@"CYBuyerEvaluationView" owner:nil options:nil] firstObject];
        _evaluationView.frame = CGRectMake(0,_productTopView.height + _productTopView.y,SCREEN_WIDTH,1);
        _evaluationView.pageSize = @"2";
        _evaluationView.delegate = self;
        _evaluationView.goodId = _goodId;
    }
    return _evaluationView;
}

- (CYSpecificationView *)specificationView
{
    if (!_specificationView) {
        _specificationView = [[[NSBundle mainBundle]loadNibNamed:@"CYSpecificationView" owner:nil options:nil] firstObject];
        _specificationView.frame = WINDOW.bounds;
        _specificationView.delegate =  self;
    }
    return _specificationView;
}


- (CYBuyerProFooterVIew *)footerView{
    if (!_footerView) {
        _footerView = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerProFooterVIew" owner:nil options:nil] firstObject];
        _footerView.frame = CGRectMake(0, _evaluationView.y + _evaluationView.height, SCREEN_WIDTH, 190);
        _footerView.delegate = self;
        
    }
    return _footerView;
}

- (UIView *)detailViw
{
    if (!_detailViw) {
        _detailViw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    }
    
    return _detailViw;
}

- (CYAllEvaluationView *)allEvaView
{
    if (!_allEvaView) {
        _allEvaView = [[[NSBundle mainBundle] loadNibNamed:@"CYAllEvaluationView" owner:nil options:nil] firstObject];
        _allEvaView.frame = CGRectMake(SCREEN_WIDTH,64,SCREEN_WIDTH,SCREEN_HEIGHT-109);
        
    }
    return _allEvaView;
}

#define IMGHEIGHT SCREEN_WIDTH*(9/16.)
-(void)loadAllImgView:(NSArray *)imgArr{
    //    64/48;8/6
    [_contentView addSubview:self.productTopView];
    self.detailViw.y = self.productTopView.height;
    
    for (int i =0; i<[imgArr count]; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0,i * IMGHEIGHT,SCREEN_WIDTH, IMGHEIGHT)];
        //        img.contentMode = UIViewContentModeScaleAspectFill;
        [img sd_setImageWithURL:[NSURL URLWithString:imgArr[i]] placeholderImage:WIDEIMG];
        [self.detailViw addSubview:img];
        endWebHeight +=IMGHEIGHT;
    }
    self.detailViw.height = endWebHeight;
    [_contentView addSubview:self.detailViw];
    self.footerView.y = self.detailViw.height +self.detailViw.y;
    [_contentView addSubview:self.footerView];
    
    _contentView.contentSize = CGSizeMake(SCREEN_WIDTH,self.footerView.height +self.footerView.y);
}

#pragma mark -
#pragma mark 按钮点击事件 method
- (IBAction)goback:(id)sender {
    if (allvalueShow) {
        [self allevaShow:NO];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

/**
 *  加入购物车，立即购买 弹出选择规格页面
 */
- (IBAction)bottom_click:(UIButton *)sender {
    if (sender.tag == 1601) {
        isBuy = YES;
    }else{
        isBuy = NO;
    }
    [WINDOW addSubview:self.specificationView];
}

- (IBAction)gouwuche_click:(id)sender {
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    CYSCartViewController *vc = viewControllerInStoryBoard(@"CYSCartViewController", @"My");
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)shoucang_click:(id)sender {
    
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    
    [CYWebClient Post:@"userdoFavorit" parametes:@{@"goods_id":_goodId} success:^(id responObject) {
        _shoucangImg.highlighted = !_shoucangImg.highlighted;
    } failure:^(id error) {
        
    }];
}

- (void)selectSpecification{
    
    [WINDOW addSubview:self.specificationView];
    
}


- (void)shareGoods
{
    CYShareModel * model = [[CYShareModel alloc] init];
    model.shareUrl = shareurl;
    
    NSDictionary * dic = productModel.albumList[0];
    NSString * imgUrl = [dic objectForJSONKey:@"path"];
    
    model.shareImg = imgUrl;
    model.shareTitle = productModel.title;
    model.shareDesc = productModel.desc;
    
    [UICommon shareGoods:model];
}

#pragma mark -
#pragma mark CYSpecificationViewDelegate method
-(void)selectgoodsInfo:(NSDictionary *)goodsInfo
{
    [self.specificationView removeFromSuperview];
    ChaYuer *manager = [ChaYuManager  getCurrentUser];
    if (!manager.isLoged) {
        UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您尚未登录，请登录后继续操作" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alt show];
        return;
    }
    
    if ([[goodsInfo objectForJSONKey:@"number"]integerValue]>[[productModel.specDataDef objectForKey:@"stock"] integerValue]) {
        [Itost showMsg:@"库存不足！" inView:self.view];
        return;
    }
    
    NSString *specId =[goodsInfo objectForJSONKey:@"specId"];
    if (specId.length == 0) {
        specId = [productModel.specDataDef objectForJSONKey:@"specId"];
    }
    if (isBuy) {
        CYShopTrolleyModel *model = [[CYShopTrolleyModel alloc] init];
        CGFloat price = [[productModel.specDataDef objectForKey:@"isPromote"] integerValue] == 0?[[productModel.specDataDef objectForJSONKey:@"price"] floatValue]:[[productModel.specDataDef objectForJSONKey:@"pricePromote"] floatValue];
        
        NSString *sellerName = [productModel.seller objectForKey:@"sellerName"];
        NSString *avatar = [productModel.seller objectForKey:@"avatar"];
        NSMutableArray *goodsArr = [NSMutableArray array];
        NSMutableArray *detailArr  =[NSMutableArray array];
        if (productModel.albumList.count>0) {
            NSDictionary * dic = productModel.albumList[0];
            NSString * imgUrl = [dic objectForJSONKey:@"path"];
            
            model.thumb = imgUrl;
        }else{
            model.thumb = @"";
        }
        
        NSString *selleruid = [productModel.is_self boolValue]?@"1":productModel.sellerUid;
        model.name = productModel.name;
        model.goodsNumber = [[goodsInfo objectForJSONKey:@"number"] integerValue] ==0?@"1":[goodsInfo objectForJSONKey:@"number"];
        model.goodsId = productModel.goodsId;
        model.specId = specId;
        model.specdataId = specId;
        model.commodityPrice = [NSString stringWithFormat:@"%.2f",price];
        model.stock = [productModel.specDataDef objectForJSONKey:@"stock"];
        [goodsArr addObject:model];
        price *=[[goodsInfo objectForJSONKey:@"number"] integerValue];
        NSDictionary *data = @{@"goodsList":goodsArr,
                               @"commodityCount":[goodsInfo objectForJSONKey:@"number"],
                               @"seller":@{@"sellerName":sellerName,@"sellerAvatar":avatar,@"sellerUid":selleruid},
                               @"orderPrice":[NSNumber numberWithFloat:price]};
        
        
        CYOrderDetailModel *goodsModel = [CYOrderDetailModel objectWithKeyValues:data];
        [detailArr addObject:goodsModel];
        
        CYConfirmOrderViewController *vc = viewControllerInStoryBoard(@"CYConfirmOrderViewController", @"TeaMall");
        vc.dataArr = detailArr;
        vc.confirmtype = CYConfirmOrderTypeBuyNow;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        NSMutableDictionary *info = [NSMutableDictionary dictionaryWithDictionary:goodsInfo];
        [info setObject:specId forKey:@"specId"];
        [CYWebClient Post:@"AddCart" parametes:info success:^(id responObj) {
            [self loadCartNum];
        } failure:^(id err) {
            NSLog(@"%@",err);
        }];
    }
    
}

#pragma mark -
#pragma mark BBWebViewSizeAdjust delegate method
- (void)bbweb:(BBWebView *)web didAdjustSizeTo:(CGSize)endSize from:(CGSize)startSize
{
    if (startSize.height<endSize.height) {

        self.productTopView.height = self.productTopView.endHeight;

        webView.y = 0;
        webView.height = endSize.height;
        endWebHeight = endSize.height;
        
        CGFloat contentsize_height = 0.0;

        self.productTopView.y = webView.y + endWebHeight;
        
        self.evaluationView.y = _productTopView.y + _productTopView.height;
        
        self.footerView.y = _evaluationView.y + _evaluationView.height;
        if ([productModel.guanliansale count] == 0) {
            self.footerView.onlyShowTop = YES;
            self.footerView.height = 424-234;
        }else{
            self.footerView.height = 190;
        }
        
        if ([productModel.sellerUid isEqualToString:@"0"]) {
            self.footerView.onlyShopBottom = YES;
            self.footerView.height = 234.;
            if ([productModel.guanliansale count] == 0) {
                self.footerView.height = 0.0f;
            }
            
            
        }
        
        [_contentView addSubview:self.footerView];
        contentsize_height = _footerView.y + _footerView.height;
        
        _contentView.contentSize = CGSizeMake(SCREEN_WIDTH,contentsize_height);
    }
    
}
#pragma mark -
#pragma mark CYBuyerProFooterVIewDelegate method
- (void)mingjiajieshao:(NSString *)uid
{
    CYBuyerDetailVC *vc = viewControllerInStoryBoard(@"CYBuyerDetailVC", @"Buyer");
    vc.seller_uid = productModel.sellerUid;
    
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)selectGoodsAtIndex:(NSString *)goodsId
{
    CYBuyerPDDetailVC *vc =viewControllerInStoryBoard(@"CYBuyerPDDetailVC", @"Buyer");
    vc.goodId = goodsId;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -
#pragma mark UIAlertViewDelegate method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate showLogView];
    }
}

#pragma mark -
#pragma mark CYBuyerEvaluationViewDelegate method
- (void)evaluationViewendHeight:(CGFloat)endheight
{
    self.contentView.contentSize = CGSizeMake(SCREEN_WIDTH,_productTopView.y + _productTopView.height + endheight + _footerView.height);
}

- (void)showAllEvaluation
{
    self.allEvaView.goodsId = _goodId;
    [self allevaShow:YES];
}

-(void)allevaShow:(BOOL)show
{
    allvalueShow = show;
    if (show) {
        self.title = @"全部评价";
        [self.view addSubview:self.allEvaView];
        [self.view bringSubviewToFront:self.allEvaView];
        [UIView animateWithDuration:0.25 animations:^{
            self.allEvaView.x = 0;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        self.title = @"商品详情";
        [UIView animateWithDuration:0.25 animations:^{
            self.allEvaView.x = SCREEN_WIDTH;
        } completion:^(BOOL finished) {
            [self.allEvaView removeFromSuperview];
        }];
    }
}

@end

