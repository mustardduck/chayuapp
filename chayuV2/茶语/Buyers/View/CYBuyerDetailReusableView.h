//
//  CYBuyerDetailReusableView.h
//  茶语
//
//  Created by Leen on 16/6/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBWebView.h"
#import "CYBuyerDetailInfo.h"

@protocol CYBuyerDetailReusableViewDelegate;


@interface CYBuyerDetailReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet BBWebView *TopWebView;
@property (weak, nonatomic) IBOutlet UIButton *dropBtn;
@property (nonatomic, assign)id <CYBuyerDetailReusableViewDelegate> delegate;
@property (strong, nonatomic) CYBuyerDetailInfo *detailInfo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webHeightCons;

@property (nonatomic, copy) void(^seeFullBlock)();

@end

@protocol CYBuyerDetailReusableViewDelegate<NSObject>

@optional

- (void)shareBtnClicked;
- (void)followBtnClicked;
- (void)allBtnClicked;
- (void)popularBtnClicked;
- (void)dropBtnClicked:(UIButton *)sender;


@end
