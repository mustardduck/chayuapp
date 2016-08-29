//
//  CYWenZhangCommentView.h
//  茶语
//
//  Created by Leen on 16/7/30.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYMyCommentModel.h"

@protocol CYWenZhangCommentViewDelegate;

@interface CYWenZhangCommentView : UIView

@property (nonatomic,assign)CGFloat endHeight;
@property (nonatomic,assign)NSInteger pageSize;

@property (nonatomic,assign)CGFloat endDropHeight;


@property (nonatomic, strong) NSString * type;//评论类型
@property (nonatomic, strong) NSString * itemid;//文章id

@property (nonatomic, assign) id<CYWenZhangCommentViewDelegate> delegate;

-(void)loadTableViewData:(BOOL)loadMore;

@end

@protocol CYWenZhangCommentViewDelegate <NSObject>

@optional
- (void)evaluationViewendHeight:(CGFloat)endheight;

- (void)showAllEvaluation;

- (void)commentBtnClicked:(CYWenZhangCommentModel *)model;

- (void)huifu_click;

@end
