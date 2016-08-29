//
//  CYHomeFooterView.h
//  TeaMall
//
//  Created by Chayu on 15/10/21.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BGVIEW_HEIGHT (107/(320/SCREEN_WIDTH))
#define FOOT_TEA_IMGURL @"img_url"
#define FOOT_TEA_NAME   @"tea_name"

#import "CYGoodsListModel.h"

@protocol CYHomeFooterViewDelegate;

@interface CYHomeFooterView : UIView

@property (nonatomic,strong)NSArray *teasArr;

@property (assign ,nonatomic)id<CYHomeFooterViewDelegate>delegate;

@end


@protocol CYHomeFooterViewDelegate <NSObject>

-(void)selectTheTea:(NSInteger)index andModel:(CYGoodsListModel *)model;

@end