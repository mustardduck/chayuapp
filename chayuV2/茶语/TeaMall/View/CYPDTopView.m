//
//  CYPDTopView.m
//  TeaMall
//
//  Created by Chayu on 15/10/26.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYPDTopView.h"
#import "AppDelegate.h"
#import "CYActionSheet.h"
#import "CYEvaluationCell.h"
#import "CYBaseLineLable.h"
@interface CYPDTopView ()<ZZCarouselDelegate,UITableViewDelegate,UITableViewDataSource>
{
    CYEvaluationModel *evaModel;
    CGFloat tableHeight;
}
@property (weak, nonatomic) IBOutlet UIView *bottomLin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom_x;


@property (weak, nonatomic) IBOutlet UILabel *goods_insLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top_height;

@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet CYBaseLineLable *listLbl;
@property (weak, nonatomic) IBOutlet UILabel *salesLbl;
- (IBAction)sharegoods_click:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *menuView;

@property (nonatomic,strong)NSMutableArray *picArr;


- (IBAction)menu_click:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITableView *evaTable;
@property (weak, nonatomic) IBOutlet UIView *evaView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top_cons;



- (IBAction)alleva_click:(id)sender;

- (IBAction)select_city_click:(id)sender;
- (IBAction)like_click:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *limitRuleTitle;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goods_details_height;
@property (weak, nonatomic) IBOutlet UIButton *evaBtn;




@end

@implementation CYPDTopView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
 
    
}

-(void)awakeFromNib
{
    
    tableHeight = 0;
    [self addSubview:self.bannerView];
}


- (IBAction)sharegoods_click:(id)sender {
    if ([self.delegate respondsToSelector:@selector(shareGoods)]) {
        [self.delegate shareGoods];
    }
    
}


- (void)setProductModel:(CYProductDetailsModel *)productModel{
    _productModel = productModel;
    [self.picArr addObjectsFromArray:_productModel.albumList];
    [self.bannerView reloadData];
 
    _evaTable.delegate = self;
    _evaTable.dataSource = self;
    
    if (MANAGER.isLoged) {
        if ([_productModel.is_enjoy boolValue]) {
            _xihuanImg.highlighted = YES;
        }
    }

    
//    
//    if (_productModel.essenCeArr.count != 0) {
//        evaModel = [CYEvaluationModel objectWithKeyValues:_productModel.essenCeArr];
//        [_evaTable reloadData];
//        _top_height.constant = tableHeight +90;
//    }else{
//        _top_height.constant = 0;
//        tableHeight = 0;
//    }
    _top_height.constant = 0;
    tableHeight = 0;
    
    

    
    if ([_productModel.commentCount integerValue] == 0) {
        [_evaBtn setTitle:@"评价" forState:UIControlStateNormal];
    }else{
        [_evaBtn setTitle:[NSString stringWithFormat:@"评价（%@）",_productModel.commentCount] forState:UIControlStateNormal];
    }
      [_evaView layoutIfNeeded];
    _price_diff_app.text = _productModel.price_diff_app;
    _goods_insLbl.text = _productModel.name;
    _priceLbl.text = [NSString stringWithFormat:@"￥%@",_productModel.specDataDef[@"pricePromote"]];
//    _listLbl.text = [NSString stringWithFormat:@"￥%@",_productModel.specDataDef[@"price"]];
    NSString *proPrice = [NSString stringWithFormat:@"￥%@",_productModel.specDataDef[@"price"]];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:proPrice];
    [attrStr addAttribute:NSStrikethroughStyleAttributeName value:@(YES) range:NSMakeRange(0,proPrice.length)];
    [attrStr addAttribute:NSStrikethroughColorAttributeName value:CONTENTCOLOR range:NSMakeRange(0, proPrice.length)];
    _listLbl.attributedText = attrStr;
    
    _salesLbl.text = [NSString stringWithFormat:@"已售：%@",_productModel.salesBase];
    NSInteger isPromote = [_productModel.specDataDef[@"isPromote"] integerValue];
    if (isPromote == 0) {
        _listLbl.hidden = YES;
        _priceLbl.text = [NSString stringWithFormat:@"￥%@",_productModel.specDataDef[@"price"]];
    }
    _limitRuleTitle.text = _productModel.limitRuleTitle;
    
      _top_cons.constant = 375 *SCREENBILI;
    if (_productModel.limitRuleTitle.length) {
        _goods_details_height.constant = 160.;
    }else{
        _goods_details_height.constant = 115.0f;
    }
    self.endHeight = _top_cons.constant + 118 +_goods_details_height.constant +_top_height.constant;

}


- (void)setEndHeight:(CGFloat)endHeight
{
    _endHeight = endHeight;
    self.height = _endHeight;
    
}

- (NSMutableArray *)picArr
{
    if (!_picArr) {
        _picArr = [[NSMutableArray alloc] init];
    }
    return _picArr;
}

/**
 *  加载顶部banner
 */
- (CYCarousel *)bannerView
{
    if (!_bannerView) {
        CGFloat banner_height = 375 *(SCREEN_WIDTH/375);
        _bannerView = [[CYCarousel alloc]initWithFrame:CGRectMake(0 , 0,SCREEN_WIDTH, banner_height)];
                
        /*
         *   carouseScrollTimeInterval  ---  此属性为设置轮播多长时间滚动到下一张
         */
        _bannerView.carouseScrollTimeInterval = 3.0f;
        
        // 代理
        _bannerView.delegate = self;
        
        /*
         *   isAutoScroll  ---  默认为NO，当为YES时 才能使轮播进行滚动
         */
        _bannerView.isAutoScroll = YES;
        
        /*
         *   pageType  ---  设置轮播样式 默认为系统样式。ZZCarousel 中封装了 两种样式，另外一种为数字样式
         */
        _bannerView.pageType = ZZCarouselPageTypeOfNone;
        
        /*
         *   设置UIPageControl 在轮播中的位置、系统默认的UIPageControl 的顶层颜色 和底层颜色已经背景颜色
         */
        _bannerView.pageControlFrame = CGRectMake(0, banner_height - 30,SCREEN_WIDTH, 30);
        _bannerView.pageIndicatorTintColor = [UIColor lightGrayColor];
        _bannerView.currentPageIndicatorTintColor = MAIN_COLOR;
        _bannerView.pageControlBackGroundColor = RGBA(0, 0, 0, 0.6);
        
        /*
         *   设置数字样式的 UIPageControl 中的字体和字体颜色。 背景颜色仍然按照上面pageControlBackGroundColor属性来设置
         */
        //        _wheel.pageControlOfNumberFont = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        //        _wheel.pageContolOfNumberFontColor = [UIColor whiteColor];
        
        
        
    }
    return _bannerView;
}


#pragma mark -
#pragma mark 按钮点击事件 method

- (IBAction)alleva_click:(id)sender {
    if ([self.delegate respondsToSelector:@selector(allevaluation)]) {
        [self.delegate allevaluation];
    }
}

- (IBAction)select_city_click:(id)sender {
    if ([self.delegate respondsToSelector:@selector(selectCity)]) {
        [self.delegate selectCity];
    }
}

- (IBAction)like_click:(id)sender {
    ChaYuer *manager = [ChaYuManager  getCurrentUser];
    if (!manager.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    [CYWebClient Post:@"userdoEnjoy" parametes:@{@"goods_id":_productModel.goodsId} success:^(id responObject) {
        _xihuanImg.highlighted = !_xihuanImg.highlighted;
    } failure:^(id error) {
        
    }];
}

- (IBAction)understandTheMaster_click:(id)sender {
    if ([self.delegate respondsToSelector:@selector(understandTheMaster)]) {
        [self.delegate understandTheMaster];
    }
}

- (IBAction)attention_click:(id)sender {
    if ([self.delegate respondsToSelector:@selector(attention)]) {
        [self.delegate attention];
    }
}

- (IBAction)menu_click:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(selectMenu:)]) {
        [self.delegate selectMenu:sender.tag];
    }
    

    
    
    [UIView animateWithDuration:0.25 animations:^{
        _bottom_x.constant = sender.x;
        [_menuView layoutIfNeeded];
    }];
    
    for (int i =1900; i<1903; i++) {
        UIButton *selectBtn = (UIButton *)[_menuView viewWithTag:i];
        if (selectBtn.tag == sender.tag) {
            selectBtn.selected = YES;
//            [self changeButtonColor:selectBtn Select:YES];
        }else{
            selectBtn.selected = NO;
//            [self changeButtonColor:selectBtn Select:NO];
        }
    }
}

-(void)changeButtonColor:(UIButton *)sender Select:(BOOL)select
{
    if (select) {
        sender.backgroundColor = MAIN_COLOR;
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        sender.backgroundColor = [UIColor getColorWithHexString:@"FFF7F2"];
        [sender setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    }
}
#pragma mark -
#pragma mark ZZCarouselDelegate method
-(NSInteger)numberOfZZCarousel:(CYCarousel *)wheel
{
    return self.picArr.count;
}
-(ZZCarouselView *)zzcarousel:(UICollectionView *)zzcarousel viewForItemAtIndex:(NSIndexPath *)index itemsIndex:(NSInteger)itemsIndex identifire:(NSString *)identifire
{
    /*
     *  index参数         ※ 注意
     */
    ZZCarouselView *cell = [zzcarousel dequeueReusableCellWithReuseIdentifier:identifire forIndexPath:index];
    
    if (!cell) {
        cell = [[ZZCarouselView alloc]init];
    }
    if ([_productModel.type isEqualToString:@"1"]) {
        NSURL *url = [NSURL URLWithString:[self.picArr objectAtIndex:itemsIndex]];
        [cell.imageView  sd_setImageWithURL:url placeholderImage:SQUARE];;
    }else{
        
    }
    return cell;
}

//点击方法

-(void)zzcarouselScrollView:(CYCarousel *)zzcarouselScrollView didSelectItemAtIndex:(NSInteger)index
{
    if(self.seeFullBlock)
    {
        self.seeFullBlock(index);
    }
}


#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYEvaluationModel *model = evaModel;
    tableHeight = [CYEvaluationCell tableViewCellHeight:model];
    self.endHeight = tableHeight +90;
    NSLog(@"tableHeight = %f",tableHeight);
    return tableHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *evaidentify = @"CYEvaluationCell";
    CYEvaluationCell *cell = [tableView dequeueReusableCellWithIdentifier:evaidentify];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYEvaluationCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.evaModel = evaModel;
    return cell;
}

-(void)viewDidLayoutSubviews
{
    
    setSepretor(self.evaTable);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    setCellSepretor();
}

-(CGFloat)lableHeightWithString:(NSString *)string Size:(CGSize )size
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:12.]};
    CGSize lableSize = [string boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return lableSize.height;
}

//-(void)updateHeight
//{
//    UIView *view = _evaView;
//    view.layer.borderColor = [UIColor redColor].CGColor;
//    view.layer.borderWidth = 1.0f;
//    view.layer.cornerRadius = 3.0f;
//    self.height = 240 +SCREEN_WIDTH + tableHeight;
//}


@end
