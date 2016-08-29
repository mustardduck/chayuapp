//
//  CYProFooterVIew.m
//  茶语
//
//  Created by Chayu on 16/2/22.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYProFooterVIew.h"

@interface CYProFooterVIew ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *sellerImg;
@property (weak, nonatomic) IBOutlet UILabel *sellerName;
@property (weak, nonatomic) IBOutlet UILabel *sellerIns;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goods_top_cons;

@property (weak, nonatomic) IBOutlet UIView *goodsView;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;

- (IBAction)mingjiajieshao_click:(id)sender;

- (IBAction)attention_click:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *publicBtn;


@end

@implementation CYProFooterVIew

-(void)awakeFromNib
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mingjiajieshao_click:)];
    [_sellerImg addGestureRecognizer:tap];
    _sellerImg.layer.cornerRadius = _sellerImg.height/2.0;
    _sellerImg.layer.borderWidth  = 2.;
    _sellerImg.layer.borderColor = [UIColor whiteColor].CGColor;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)setSeller:(NSDictionary *)seller
{
    _seller = seller;
    NSString *imgPath = [_seller objectForKey:@"avatar"];
    
    NSInteger gid = [[_seller objectForKey:@"gid"] integerValue];
    if (gid == 10) {
        [_publicBtn setTitle:@"名家介绍" forState:UIControlStateNormal];
    }else if (gid == 9){
        [_publicBtn setTitle:@"大师介绍" forState:UIControlStateNormal];
    }
    else
    {
        [_publicBtn setTitle:@"茗星介绍" forState:UIControlStateNormal];
    }
    if (imgPath.length) {
        [_sellerImg sd_setImageWithURL:[NSURL URLWithString:imgPath] placeholderImage:WIDEIMG];
    }
    _sellerName.text = [_seller objectForKey:@"sellerName"];
    _sellerIns.text = [_seller objectForKey:@"description"];
    NSInteger isAttend = [[_seller objectForKey:@"isAttend"] integerValue];
    if (isAttend == 0) {
        [_attentionBtn setTitle:@"+关注" forState:UIControlStateNormal];
    }else{
        [_attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
    }
    
}

- (void)setOnlyShowTop:(BOOL)onlyShowTop
{
    _onlyShowTop = onlyShowTop;
    if (_onlyShowTop) {
        [_goodsView removeFromSuperview];
    }
}


-(void)setOnlyShopBottom:(BOOL)onlyShopBottom
{
    _onlyShopBottom = onlyShopBottom;
    if (_onlyShopBottom) {
        if (!_onlyShowTop) {
            [self addSubview:_goodsView];
            _goods_top_cons.constant = -190.0f;
        }
    }
}

- (void)setGoodsList:(NSArray *)goodsList
{
    _goodsList = goodsList;
    [self loadgoodsinfo:_goodsList];
}
#define CONTENT_WIDTH ((SCREEN_WIDTH -60)/3)
#define CONTENT_HEIGHT 170
-(void)loadgoodsinfo:(NSArray *)arr{
    
    
    NSInteger goodscount = 3;
    if ([arr count]<3) {
        goodscount = [arr count];
    }
    
    for (int i =0; i<goodscount; i++) {
        NSDictionary *info = arr[i];
        NSInteger row = i % 3;
        NSInteger sec = i / 3;
        UIView *content =[[UIView alloc] initWithFrame:CGRectMake(row *CONTENT_WIDTH +(row +1)*15,sec *190, CONTENT_WIDTH, CONTENT_HEIGHT +10)];
        if (row ==0) {
            content.x = 15;
        }
        content.backgroundColor = CLEARCOLOR;
        
        //商品图片
        UIImageView *goodsimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CONTENT_WIDTH-2, CONTENT_WIDTH-2)];
        goodsimg.layer.borderColor = LINECOLOR.CGColor;
        goodsimg.layer.borderWidth = .5;
        NSString *thumb =[info objectForKey:@"thumb"];
        if (thumb.length) {
            [goodsimg sd_setImageWithURL:[NSURL URLWithString:thumb] placeholderImage:SQUARE];
        }
        [content addSubview:goodsimg];
        
        
        //商品标题
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0,goodsimg.height +5,CONTENT_WIDTH, 40)];
        titleLbl.textAlignment = NSTextAlignmentCenter;
        titleLbl.numberOfLines = 2.;
        titleLbl.text = [info objectForKey:@"name"];
        titleLbl.font = FONT(14.0);
        titleLbl.textColor = TITLECOLOR;
        [content addSubview:titleLbl];
        
        //商品价格
        UILabel *priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLbl.height +titleLbl.y +5, 10, 15)];
        priceLbl.textColor = MAIN_COLOR;
        priceLbl.font = FONT(14.0);
        priceLbl.text = [NSString stringWithFormat:@"￥%@",[info objectForKey:@"price_sell"]];
        [priceLbl sizeToFit];
        priceLbl.x = 0;
        priceLbl.y =titleLbl.height +titleLbl.y +5;
        [content addSubview:priceLbl];
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = content.bounds;
        button.tag = 80000 +i;
        [button addTarget:self action:@selector(selectgoods:) forControlEvents:UIControlEventTouchUpInside];
        [content addSubview:button];
        
        [_contentView addSubview:content];
        
        
    }
}

- (IBAction)mingjiajieshao_click:(id)sender {
    //    UIButton * btn = (UIButton *)sender;
    
    NSInteger gid = [[_seller objectForKey:@"gid"] integerValue];
    if(gid == 11)
    {
        if ([self.delegate respondsToSelector:@selector(mingXingJieShao:)]) {
            [self.delegate mingXingJieShao:_sellerUid];
        }
    }
    else
    {
        if ([self.delegate respondsToSelector:@selector(mingjiajieshao:)]) {
            [self.delegate mingjiajieshao:_sellerUid];
        }
    }
    
}

-(void)selectgoods:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(selectGoodsAtIndex:)]) {
        [self.delegate selectGoodsAtIndex:_goodsList[sender.tag - 80000][@"goods_id"]];
    }
}

- (IBAction)attention_click:(id)sender {
    [self doAttend:_sellerUid];
}

-(void)doAttend:(NSString *)masterId
{
    [CYWebClient Post:@"DoAttend" parametes:@{@"sellerUid":masterId} success:^(id responObj) {
        NSInteger status = [[responObj objectForKey:@"status"] integerValue];
        if (status == 1) {
            [_attentionBtn setTitle:@"+关注" forState:UIControlStateNormal];
        }else{
            [_attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
        }
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
}
@end
