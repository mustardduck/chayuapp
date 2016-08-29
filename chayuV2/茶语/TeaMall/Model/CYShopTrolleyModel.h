//
//  CYShopTrolleyModel.h
//  TeaMall
//
//  Created by Chayu on 15/10/28.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYShopTrolleyModel : NSObject

@property (nonatomic,copy)NSString *thumb;

@property (nonatomic,copy)NSString *name;

@property (nonatomic,copy)NSString *spec;

@property (nonatomic,copy)NSString *commodityPrice;

@property (nonatomic,copy)NSString *refund_price;

@property (nonatomic,copy)NSString *seller_uid;


@property (nonatomic,copy)NSString *price;

@property (nonatomic,assign)BOOL isSelect;

/**
 *  商品数量
 */
@property (nonatomic,copy)NSString *goodsNumber;

@property (nonatomic,strong)NSString *goodsId;

/**
 *  库存
 */
@property (nonatomic,strong)NSString *stock;


/**
 *  规格ID
 */
@property (nonatomic,strong)NSString *specdataId;

/**
 *  规格ID(购物车用)
 */
@property (nonatomic,strong)NSString *specId;

/**
 *  评价内容
 */
@property (nonatomic,strong)NSString *addReview;

@property (nonatomic,strong)NSString *score;
/**
 *
 */
@property (nonatomic,strong)NSString *adminReview;

/**
 *  首评论ID
 */
@property (nonatomic,strong)NSString *commentId;

//退款 相关状态
/*
 * isRefundReturn  是否可以退款/退货（0否 1是）
 * status 退款状态（0退款中，1退款成功，2退款失败，3退款取消）
 * shippingStatus 退货状态（3或者5退款中，4请退货，6退款成功，7拒绝退货，8退货取消）
 * refundType 退款／退货类型(1/2)
 */

@property(nonatomic,strong)NSDictionary *backInfo;

@property (nonatomic,strong)NSString *goods_id;

@property (nonatomic,strong)NSString *is_self;


@property (nonatomic,strong)NSMutableArray *imgArr;

@property (nonatomic,assign)CGFloat cellHeight;


/**
 *  首评 图片组
 */
@property (nonatomic,strong)NSArray *attach;


@end
