//
//  CYProFooterVIew.h
//  茶语
//
//  Created by Chayu on 16/2/22.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYProFooterVIewDelegate;

@interface CYProFooterVIew : UIView

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSDictionary *seller;

@property (nonatomic,strong)NSArray *goodsList;

@property (nonatomic,copy)NSString *sellerUid;

//是否只展示顶部
@property (nonatomic,assign)BOOL onlyShowTop;


@property (nonatomic,assign)BOOL onlyShopBottom;

@property (nonatomic,assign)id<CYProFooterVIewDelegate>delegate;

@end

@protocol CYProFooterVIewDelegate <NSObject>

-(void)mingjiajieshao:(NSString *)uid;

-(void)mingXingJieShao:(NSString *)uid;


-(void)selectGoodsAtIndex:(NSString *)goodsId;

@end