//
//  CYSlideListModel.h
//  TeaMall
//
//  Created by Chayu on 15/11/9.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYSlideListModel : NSObject

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSString *resourceId;

@property (nonatomic,strong)NSString *thumb;

@property (nonatomic,strong)NSString *adId;

@property (nonatomic,strong)NSString *desc;

@property (nonatomic,strong)NSString *data;

@property (nonatomic,strong)NSString *title;

/**
 *  类型(1文章，2商品，3卖家，4聚合-人物，101 聚合-商品，100其他)
 */
@property (nonatomic,strong)NSString *type;

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSString *isRedPack;
@end
