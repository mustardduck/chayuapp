//
//  CYMasterListModel.h
//  TeaMall
//
//  Created by Chayu on 15/11/9.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYGoodsListModel.h"

@interface CYMasterListModel : NSObject

/**
 *  大师Id
 */
@property (nonatomic,strong)NSString *uid;
/**
 *  图片链接
 */
@property (nonatomic,strong)NSString *thumb;

/**
 *  商家介绍
 */
@property (nonatomic,strong)NSString *desc;

@property (nonatomic,strong)NSString *mainid;

/**
 *  活动Id
 */
@property (nonatomic,strong)NSString *adverturl;

/**
 *  活动内容
 */
@property (nonatomic,strong)NSString *advertcopy;

/**
 *  好茶详情数量（仅大师可用）
 */
@property (nonatomic,strong)NSString *goods_num;

/**
 *  大师旗下产品
 */
@property (nonatomic,strong)NSArray *goodsList;


/**
 *  类型(1文章，2商品信息-有评论，3卖家，4聚合，5商品信息-有卖家头像信息，，6商品纯图片推荐 100其他)
 */
@property (nonatomic,strong)NSString *type;

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSString *content;

/**
 *
 */
@property (nonatomic,strong)NSString *data;


/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSString *title;

/**
 *  评论数
 */
@property (nonatomic,strong)NSString *comment_count;


/**
 *  销售数量
 */
@property (nonatomic,strong)NSString *sales_count;


/**
 *  卖家图片
 */
@property (nonatomic,strong)NSString *sellerAvatar;

/**
 *  当为聚合页时需要判断是那种合集
 */
@property (nonatomic,strong)NSString *juheType;

/**
 *  新的卖家ID
 */
@property (nonatomic,strong)NSString *sellerUid;

@property (nonatomic,strong)NSString *resource_id;

@property (nonatomic,strong)NSString *saleBase;
//当为聚合商品时为商品名
@property (nonatomic,strong)NSString *catename;

@property (nonatomic,strong)NSString *sellerTypeName;

//卖家分类（9大师 10名家 11名家）
@property (nonatomic,strong)NSString *gid;

@property (nonatomic,strong)NSString *goods_id;

@property (nonatomic, assign)NSInteger enjoy_count;//喜欢（type=2专用）
@property (nonatomic, strong)NSString * price_sell;//售价（type=2专用）





@end
