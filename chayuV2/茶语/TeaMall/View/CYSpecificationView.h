//
//  CYSpecificationView.h
//  TeaMall
//
//  Created by Chayu on 15/10/27.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYProductDetailsModel.h"

@protocol CYSpecificationViewDelegate;

@interface CYSpecificationView : UIView

@property (nonatomic,strong)CYProductDetailsModel *productModel;

@property (nonatomic,strong)id<CYSpecificationViewDelegate>delegate;



@end


@protocol CYSpecificationViewDelegate <NSObject>

-(void)selectgoodsInfo:(NSDictionary *)goodsInfo;

@end