//
//  CYBuyerOrderInfoModel.h
//  茶语
//
//  Created by Leen on 16/6/14.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYBuyerOrderInfoModel : NSObject

/**
 *  订单ID
 */
@property (nonatomic,strong)NSString *orderSn;

/**
 *  买家姓名
 */
@property (nonatomic,strong)NSDictionary *buyer;

///**
// *  退款金额
// */
//@property (nonatomic,strong)NSString *refundPrice;

/**
 *  商品实收金额
 */
@property (nonatomic,strong)NSString *price;

///**
// *  订单总金额
// */
//@property (nonatomic,strong)NSString *orderPrice;

/**
 *  退款类型
 */
//@property (nonatomic,strong)NSString *refundType;

/**
 *  商品数组
 */
@property (nonatomic,strong)NSArray *goodsList;

/**
 * 订单状态(string) [1待付款，2待发货，3待收货，5交易成功，6交易关闭]
 */
@property (nonatomic,strong)NSString *type;


//当订单状态为5的时候 判断评价，其他状态下不需要进行判断(0评价 1已评价 2追加评价)

//@property (nonatomic,strong)NSString *comment_status;

/**
 *  订单共有多少商品
 */
@property (nonatomic,strong)NSString *commodityNum;

////邮费
//@property (nonatomic,strong)NSString *ship_price;
//
////
//@property (nonatomic,strong)NSString *orderType;

//@property (nonatomic,strong)NSString *ip;
@end

@interface CYBuyer: NSObject

/**
 *  买家姓名
 */
@property (nonatomic,strong)NSString *buyerName;

/**
 *  买家头像
 */
@property (nonatomic,strong)NSString *sellerAvatar;

@end
