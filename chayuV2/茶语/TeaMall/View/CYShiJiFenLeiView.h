//
//  CYShiJiFenLeiView.h
//  茶语
//
//  Created by Chayu on 16/7/16.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYTeaCategoryInfo.h"
@interface CYShiJiFenLeiView : UIView


@property (nonatomic,strong)NSMutableArray *dataArr;

@property (nonatomic,copy)void (^shijiCateBlock)(CYTeaChildCategoryInfo *);

@end
