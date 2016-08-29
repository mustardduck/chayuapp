//
//  CYOrderDetailModel.h
//  TeaMall
//
//  Created by Chayu on 15/11/23.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYShopTrolleyModel.h"
#import "CYInvoiceModel.h"

@interface CYOrderDetailModel : NSObject

/**
 *  下单时间
 */
@property (nonatomic,strong)NSString *created;

/**
 *  卖家ID
 */
@property (nonatomic,strong)NSString *sellerUid;

/**
 *  礼物
 */
@property (nonatomic,strong)NSArray *goodsordergift;

/**
 *  订单状态 订单状态(string) [1待付款，2待发货，3待收货，5交易成功，6交易关闭]
 */
@property (nonatomic,strong)NSString *status;



//当订单状态为5的时候 判断评价，其他状态下不需要进行判断(0评价 1已评价 2追加评价)

@property (nonatomic,strong)NSString *comment_status;

/**
 *  订单号
 */
@property (nonatomic,strong)NSString *orderSn;

/**
 *  优惠券title
 */
@property (nonatomic,strong)NSString *couponTitle;

/**
 *  订单总价
 */
@property (nonatomic,strong)NSString *orderPrice;

/**
 *  商品总数
 */
@property (nonatomic,strong)NSString *commodityCount;

/**
 *  支付类型
 */
@property (nonatomic,strong)NSString *payPlatform;

/**
 *  买家留言
 */
@property (nonatomic,strong)NSString *buyersMessage;

/**
 *  发票抬头信息
 */
@property (nonatomic,strong)NSString *invPayee;

/**
 *  是否需要发票
 */
@property (nonatomic,assign)BOOL needfapiao;

/**
 *  卖家信息
 */
@property (nonatomic,strong)NSDictionary *seller;


/**
 *  商品列表
 */
@property (nonatomic,strong)NSArray *goodsList;

/**
 *  地址信息
 */
@property (nonatomic,strong)NSDictionary *dataDeliver;

/**
 *  抵扣卷金额
 */
@property (nonatomic,strong)NSString *coupon_price;

/**
 *  商品价格总和
 */
@property (nonatomic,strong)NSString *goods_amount;


//运费金额
@property (nonatomic,strong)NSString *ship_price;


//是否修改过
@property (nonatomic,strong)NSString *isEditOrderPrice;


@property (nonatomic,strong) NSString *orderType;

@property (nonatomic,strong)NSString *ip;

@property (nonatomic,strong)NSString *type;


/**
 *  税费
 {
 invPrice = 0;
 invoiceCopy = "";
 issueinvoice = 1;
 sellerId = 1;
 invoiceBtnState （ 0 enable 为 NO  1 未选中 2 选中  ）
 }
 */
@property (nonatomic,strong)CYInvoiceModel *invoiceModel;


@end
