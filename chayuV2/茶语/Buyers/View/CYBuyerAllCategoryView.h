//
//  CYBuyerAllCategoryView.h
//  茶语
//
//  Created by Leen on 16/6/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CYBuyerAllCategoryViewDelegate <NSObject>
@optional
-(void)selectSubCategory:(NSDictionary *)info;

@end

@interface CYBuyerAllCategoryView : UIView

@property (nonatomic,assign)id<CYBuyerAllCategoryViewDelegate>delegate;

//如果市集就不在本页请求接口
@property (nonatomic,assign)BOOL isShiji;

@property (nonatomic,strong)NSArray *cateArr;

@end
