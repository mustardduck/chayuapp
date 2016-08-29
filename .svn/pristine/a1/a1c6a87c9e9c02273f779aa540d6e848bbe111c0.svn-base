//
//  CYBuyerCategoryView.h
//  茶语
//
//  Created by Leen on 16/5/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYBuyerCategoryViewDelegate <NSObject>
@optional
-(void)selectWithData:(NSDictionary *)info;

-(void)hidden;
@end

@interface CYBuyerCategoryView : UIView

@property (nonatomic,assign)id<CYBuyerCategoryViewDelegate>delegate;

@property (nonatomic,copy)NSString *catId;



@end
