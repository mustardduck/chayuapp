//
//  CYTeaListModel.h
//  TeaMall
//
//  Created by Chayu on 15/10/27.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTeaListModel : NSObject

@property (nonatomic,copy)NSString *thumb;

@property (nonatomic,copy)NSString *name;

@property (nonatomic,copy)NSString *desc;

@property (nonatomic,copy)NSString *price_sell;

@property (nonatomic,copy)NSString *sales_base;

@property (nonatomic,strong)NSString *sellerUid;

@property (nonatomic,strong)NSString *goods_id;

@property (nonatomic,strong)NSString *mainid;

@property (nonatomic,strong)NSString *icon;

/**
 *  卖家类型 （大师/名家/茗星）
 */
@property (nonatomic,strong)NSString *seller_type;

/**
 *  商品描述（手制/监制）
 */
@property (nonatomic,strong)NSString *attribute;

//是否是自营
@property (nonatomic,strong)NSString *is_self;
@end
