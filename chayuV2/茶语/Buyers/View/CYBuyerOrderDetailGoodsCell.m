//
//  CYBuyerOrderDetailGoodsCell.m
//  茶语
//
//  Created by Leen on 16/6/15.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerOrderDetailGoodsCell.h"
#import "CYOrderGoodsView.h"


@interface CYBuyerOrderDetailGoodsCell ()<CYOrderGoodsViewDelegate>


@property (weak, nonatomic) IBOutlet UIView *goodsBgView;


@end

@implementation CYBuyerOrderDetailGoodsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
+(instancetype)cellWidthTableView:(UITableView*)tableView{
    static NSString *orderdetailIdentify = @"CYBuyerOrderDetailGoodsCell";
    CYBuyerOrderDetailGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:orderdetailIdentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerOrderDetailGoodsCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(void)layoutSubviews{
    
}

- (void)setModel:(CYBuyerOrderDetailModel *)model
{
    _model = model;
//    [self loadGoodsView:model.goodsList];
    
}

-(void)loadGoodsView:(NSArray *)arr
{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        for (int i =0; i<[arr count]; i++) {
//            CYOrderGoodsView *goodsView = [[[NSBundle mainBundle] loadNibNamed:@"CYOrderGoodsView" owner:nil options:nil] firstObject];
//            goodsView.delegate = self;
//            NSInteger status = [_model.status integerValue];
//            if (status == 2 || status == 3) {
//                goodsView.status = @"1";
//            }else{
//                goodsView.status = @"0";
//            }
//            
//            goodsView.frame =CGRectMake(0,i*89, SCREEN_WIDTH, 88);
//            goodsView.goodsInfo = arr[i];
//            [_goodsBgView addSubview:goodsView];
//        }
//    });
    
}


#pragma mark -
#pragma mark CYOrderGoodsViewDelegate method
- (void)refundTheGoodsModel:(CYShopTrolleyModel *)model
{
    if ([self.delegate respondsToSelector:@selector(returnTheGoods:)]) {
        [self.delegate returnTheGoods:model];
    }
}

- (void)showgoodsdetailsModel:(CYShopTrolleyModel *)model
{
    if ([self.delegate respondsToSelector:@selector(goodsdetails:)]) {
        [self.delegate goodsdetails:model];
    }
}

@end
