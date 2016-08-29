//
//  CYGoodsListModel.h
//  TeaMall
//
//  Created by Chayu on 15/11/9.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYGoodsListModel : NSObject

@property (nonatomic,strong)NSString *goodsname;

@property (nonatomic,strong)NSString *goodsurl;

@property (nonatomic,strong)NSString *thumb;

@property (nonatomic,strong)NSString *title;

@property (nonatomic,strong)NSString *price;

@property (nonatomic,strong)NSString *des;

@property (nonatomic,strong)NSString *mainid;

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSString *is_self;


/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSString *goodsId;

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSString *data;

/**
 *  新增属性，大师首页专用
 */
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *spec_id;
@property (nonatomic,strong)NSString *goods_id;
@property (nonatomic,strong)NSString *path;




@end
