//
//  CYGiftModel.h
//  TeaMall
//
//  Created by Chayu on 15/11/25.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYGiftModel : NSObject

/**
 *  标题
 */
@property (nonatomic,strong)NSString *title;

/**
 *  图片
 */
@property (nonatomic,strong)NSString *thumb;

/**
 *  库存
 */
@property (nonatomic,strong)NSString *stock;

/**
 *  礼品ID
 */
@property (nonatomic,strong)NSString *giftId;

/**
 *  礼品数量
 */
@property (nonatomic,strong)NSString *giftNum;


/**
 *  已领数量
 */
@property (nonatomic,strong)NSString *draw_number;

@end
