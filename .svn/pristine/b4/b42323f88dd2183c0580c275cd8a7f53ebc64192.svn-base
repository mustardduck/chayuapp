//
//  CYTeaMallHeaderView.h
//  茶语
//
//  Created by taotao on 16/2/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYSlideListModel.h"

@protocol CYTeaMallHeaderViewDelegate;

@interface CYTeaMallHeaderView : UIView

@property (nonatomic,strong)NSArray *bannserArr;

@property (nonatomic,strong)NSDictionary *touPhotosArr;

@property (nonatomic,strong)NSDictionary *bantitleInfo;

@property (nonatomic,assign)id<CYTeaMallHeaderViewDelegate>delegate;
@end


@protocol CYTeaMallHeaderViewDelegate <NSObject>

-(void)topMenuSelect:(NSInteger)tag;


-(void)bannerSelected:(NSInteger)index andModel:(CYSlideListModel *)model;

@end