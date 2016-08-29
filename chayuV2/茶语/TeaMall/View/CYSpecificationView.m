//
//  CYSpecificationView.m
//  TeaMall
//
//  Created by Chayu on 15/10/27.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYSpecificationView.h"

@interface CYSpecificationView ()
{
    NSMutableArray *_selectArr;//记录选择规格后相关数据
    NSMutableDictionary *specificationinfo;//当点规格商品 信息
    NSString *specId; //规格ID
}

@property (weak, nonatomic) IBOutlet UIImageView *goods_img;

@property (weak, nonatomic) IBOutlet UILabel *goodsNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *goods_priceLbl;
@property (weak, nonatomic) IBOutlet UIView *specView;
@property (weak, nonatomic) IBOutlet UIView *numBgView;
@property (weak, nonatomic) IBOutlet UILabel *goods_numLbl;
@property (weak, nonatomic) IBOutlet UILabel *goods_stockLbl;
@property (weak, nonatomic) IBOutlet UILabel *specLbl;

/**
 *  背景高度
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *content_height_cons;
/**
 *  规格背景高度
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *specview_height_cons;

- (IBAction)goodsnumchange_click:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet CYBorderButton *confirmbtn;


- (IBAction)confirm_click:(id)sender;

@end


@implementation CYSpecificationView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
}

-(void)awakeFromNib
{
    specId = @"";
    specificationinfo = [[NSMutableDictionary alloc] init];
    [self drawLayerForView:_numBgView];
    [self drawLayerForView:_goods_numLbl];
}

-(void)drawLayerForView:(UIView *)view
{
    view.layer.borderColor = LINECOLOR.CGColor;
    view.layer.borderWidth = 1.0f;
}


- (IBAction)close_click:(id)sender {
    [self removeFromSuperview];
}

- (void)setProductModel:(CYProductDetailsModel *)productModel
{
    _productModel = productModel;
    _selectArr = [[NSMutableArray alloc] init];
    _goodsNameLbl.text = _productModel.name;
    NSString *price = nil;
    if ([[_productModel.specDataDef objectForJSONKey:@"isPromote"] integerValue] ==1) {
        price =[NSString stringWithFormat:@"￥%@",[_productModel.specDataDef objectForJSONKey:@"pricePromote"]];
    }else{
        price =[NSString stringWithFormat:@"￥%@",[_productModel.specDataDef objectForJSONKey:@"price"]];
    }
    for (int i =0; i<_productModel.specList.count; i++) {
        [_selectArr addObject:@""];
    }
    _goods_priceLbl.text = price;
    _goods_stockLbl.text = [NSString stringWithFormat:@"%@",[_productModel.specDataDef objectForJSONKey:@"stock"]];
    
    if ([_productModel.specList count]>2) {
        _specview_height_cons.constant += ((_productModel.specList.count -2)*50);
        _content_height_cons.constant +=((_productModel.specList.count-2)*50);
    }
    
    if (_productModel.albumList.count>0) {
        
        NSString *goodUrl = @"";
        if([productModel.type intValue] == 2)//茗星商品
        {
            NSDictionary * dic = productModel.albumList[0];
            NSString * imgUrl = [dic objectForJSONKey:@"path"];
            goodUrl = imgUrl;
        }
        else//市集商品
        {
            goodUrl = productModel.albumList[0];
        }
        
        [_goods_img  sd_setImageWithURL:[NSURL URLWithString:goodUrl] placeholderImage:SQUARE];
    }
    [self creatSpecificationView:_productModel.specList];
    if (_productModel.specList.count == 0) {
        _specview_height_cons.constant = 0.0f;
        _specLbl.hidden = YES;
    }
    
    
}

#define SPECVIEW_HEIGHT 35
#define SPECBUTTONTAG  300000
#define SPECVIEWTAG  20000
/**
 *  创建规格相关页面
 */
- (void)creatSpecificationView:(NSArray *)specificaArr
{
    NSMutableString *specidStr = [NSMutableString string];
    for (int i =0; i<[specificaArr count]; i++) {
        NSDictionary *info = specificaArr[i];
        UIView *specBgView = [[UIView alloc] initWithFrame:CGRectMake(0,50*i,SCREEN_WIDTH-20,SPECVIEW_HEIGHT)];
        UILabel *specnameLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 6.5, 45, 20)];
        specnameLbl.font = FONT(14.0);
        specnameLbl.textColor = CONTENTCOLOR;
        specnameLbl.text = [info objectForJSONKey:@"name"];
        specnameLbl.textAlignment = NSTextAlignmentLeft;
        [specBgView addSubview:specnameLbl];
        
        UIView *specView = [[UIView alloc] initWithFrame:CGRectMake(45, 0,SCREEN_WIDTH-65, SPECVIEW_HEIGHT)];
        specView.tag = SPECVIEWTAG +i;
        [specBgView addSubview:specView];
        CGFloat buttonWidth = (specView.width-30)/4;
        NSArray *list = [info objectForJSONKey:@"list"];
        for (int j = 0; j<[list count]; j++) {
            NSDictionary *specInfo = list[j];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(j*(10+buttonWidth),0,buttonWidth, SPECVIEW_HEIGHT);
            button.titleLabel.textAlignment = NSTextAlignmentLeft;
            button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            button.titleLabel.font = FONT(12.0f);
            [button setTitleColor:CONTENTCOLOR forState:UIControlStateNormal];
            [button setTitle:specInfo[@"name"] forState:UIControlStateNormal];
            button.tag = SPECBUTTONTAG +j;
            
            [button setBackgroundColor:CLEARCOLOR];
            button.layer.cornerRadius = 3.0f;
            button.layer.borderWidth = 1.0f;
            
            if (j == 0) {
                [specidStr appendFormat:@"%@,",[specInfo[@"id"] description]];
                button.layer.borderColor = CLEARCOLOR.CGColor;
                button.layer.borderWidth = 0.0f;
                [button setBackgroundColor:MAIN_COLOR];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
            }
            
            button.layer.borderColor = [UIColor getColorWithHexString:@"aaaaaa"].CGColor;
            [button addTarget:self action:@selector(selectSpecification_click:) forControlEvents:UIControlEventTouchUpInside];
            [specView addSubview:button];
        }
        
        if (specidStr.length>1) {
            NSString *resKey =  [specidStr substringToIndex:specidStr.length-1];
            for (NSString *key in _productModel.comBine.allKeys) {
                if ([key isEqualToString:resKey]) {
                    [specificationinfo addEntriesFromDictionary:[_productModel.comBine objectForJSONKey:key]];
                    NSString *goodsimgStr = [specificationinfo objectForJSONKey:@"imgs"][0];
                    if (goodsimgStr) {
                        NSURL *url = [NSURL URLWithString:goodsimgStr];
                        [_goods_img sd_setImageWithURL:url placeholderImage:nil];
                    }
                    NSString *price = nil;
                    if ([[specificationinfo objectForJSONKey:@"isPromote"] integerValue] ==1) {//当有特价时
                        price =[NSString stringWithFormat:@"￥%@",[specificationinfo objectForJSONKey:@"pricePromote"]];
                    }else{
                        price =[NSString stringWithFormat:@"￥%@",[specificationinfo objectForJSONKey:@"price"]];
                    }
                    specId = [specificationinfo objectForJSONKey:@"id"];
                    _goods_priceLbl.text = price;
                    _goods_stockLbl.text = [NSString stringWithFormat:@"%@",[specificationinfo objectForJSONKey:@"stock"]];
                }
            }
        }
        
        
        
        [_specView addSubview:specBgView];
        
    }
    
}


-(void)selectSpecification_click:(UIButton *)sender
{
    NSInteger buttonTag = sender.tag;
    NSInteger viewtag = sender.superview.tag-SPECVIEWTAG;
    UIView *spevView = sender.superview;
    NSArray *arr = _productModel.specList;
    NSArray *specArr = [arr[viewtag] objectForJSONKey:@"list"];
    
    [_selectArr replaceObjectAtIndex:viewtag withObject:[specArr[buttonTag-SPECBUTTONTAG] objectForJSONKey:@"id"]];
    
    for (int i =0; i<[specArr count]; i++) {
        UIButton *selectButton = (UIButton *)[spevView viewWithTag:i+SPECBUTTONTAG];
        if (selectButton.tag == buttonTag) {
            selectButton.layer.borderColor = CLEARCOLOR.CGColor;
            selectButton.layer.borderWidth = 0.0f;
            [selectButton setBackgroundColor:MAIN_COLOR];
            [selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }else{
            selectButton.layer.borderWidth = 1.0f;
            selectButton.layer.borderColor = LINECOLOR.CGColor;
            [selectButton setBackgroundColor:CLEARCOLOR];
            [selectButton setTitleColor:LIGHTCOLOR forState:UIControlStateNormal];
        }
    }
    //当所有规格选中更新页面数据
    NSMutableString *keys = [NSMutableString string];
    for (int i =0;i<[_selectArr count];i++) {
        [keys appendFormat:@"%@,",_selectArr[i]];
        if (i == [_selectArr count]-1 && ![_selectArr[i] isEqualToString:@""]) {
            NSString *resKey =  [keys substringToIndex:keys.length-1];
            NSDictionary *comBine = _productModel.comBine;
            for (NSString *key in comBine.allKeys) {
                if ([key isEqualToString:resKey]) {
                    [specificationinfo addEntriesFromDictionary:[comBine objectForJSONKey:key]];
                    NSString *goodsimgStr = [specificationinfo objectForJSONKey:@"imgs"][0];
                    if (goodsimgStr) {
                        NSURL *url = [NSURL URLWithString:goodsimgStr];
                        [_goods_img sd_setImageWithURL:url placeholderImage:nil];
                    }
                    NSString *price = nil;
                    if ([[specificationinfo objectForJSONKey:@"isPromote"] integerValue] ==1) {//当有特价时
                        price =[NSString stringWithFormat:@"￥%@",[specificationinfo objectForJSONKey:@"pricePromote"]];
                    }else{
                        price =[NSString stringWithFormat:@"￥%@",[specificationinfo objectForJSONKey:@"price"]];
                    }
                    specId = [specificationinfo objectForJSONKey:@"id"];
                    _goods_priceLbl.text = price;
                    _goods_stockLbl.text = [NSString stringWithFormat:@"%@",[specificationinfo objectForJSONKey:@"stock"]];
                }
            }
        }
    }
}

- (IBAction)goodsnumchange_click:(UIButton *)sender {
    NSInteger goodsnum = [_goods_numLbl.text integerValue];
    if (sender.tag == 5000) {//数量减
        if (goodsnum<2) {
            return;
        }
        goodsnum --;
    }else{//数量加
        if (goodsnum<[_goods_stockLbl.text integerValue]) {
            goodsnum ++;
        }else{
            [Itost showMsg:@"库存不足！" inView:WINDOW];
        }
        
    }
    _goods_numLbl.text = [NSString stringWithFormat:@"%ld",goodsnum];
}

- (IBAction)confirm_click:(id)sender {
    if ([_productModel.specList count]>0 && specId.length == 0){
        [Itost showMsg:@"请选择规格!" inView:WINDOW];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(selectgoodsInfo:)]) {
        [self.delegate selectgoodsInfo:@{@"number":_goods_numLbl.text,@"specId":specId,@"price":[_goods_priceLbl.text substringFromIndex:1]}];
    }
    
    
    
}
@end
