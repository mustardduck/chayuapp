//
//  CYBuyerProFooterVIew.h
//  茶语
//
//  Created by Leen on 16/7/14.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYBuyerProFooterVIewDelegate;

@interface CYBuyerProFooterVIew : UIView

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSDictionary *seller;

@property (nonatomic,strong)NSArray *goodsList;

@property (nonatomic,copy)NSString *sellerUid;

//是否只展示顶部
@property (nonatomic,assign)BOOL onlyShowTop;


@property (nonatomic,assign)BOOL onlyShopBottom;

@property (nonatomic,assign)id<CYBuyerProFooterVIewDelegate>delegate;

@end

@protocol CYBuyerProFooterVIewDelegate <NSObject>

-(void)mingjiajieshao:(NSString *)uid;

@optional
-(void)selectGoodsAtIndex:(NSString *)goodsId;

@end