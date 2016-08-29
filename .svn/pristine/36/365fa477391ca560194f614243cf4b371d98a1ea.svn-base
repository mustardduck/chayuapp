//
//  CYBannerView.h
//  茶语
//
//  Created by zqc on 16/8/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMPageControl.h"
#import "CYHomeInfo.h"

typedef NS_ENUM(NSUInteger, CYPageType) {
    CYPageTypeDefault = 1,//默认page剧中现实
    CYPageTypeHaveTitle,//有标题且默认显示x/n页
    CYPageTypeHidden//隐藏pageControl
};

@interface CYBannerView : UIView<UIScrollViewDelegate>

@property (nonatomic) CYPageType pageType;
/** 数据数组*/
@property (nonatomic,strong) NSArray *bannerArr;
/** 图片点击调用*/
- (void)touchImageIndexBlock:(void (^)(NSInteger index))block;
- (void)changePageBlock:(void (^)(NSInteger index))block;

- (instancetype)initWithFrame:(CGRect)frame pageType:(CYPageType)pageType bannerArr:(NSArray *)bannerArr;
- (instancetype)initWithFrame:(CGRect)frame pageType:(CYPageType)pageType bannerArr:(NSArray *)bannerArr useTimer:(BOOL)useTimer currentIndex:(NSInteger)currentIndex;

@end
