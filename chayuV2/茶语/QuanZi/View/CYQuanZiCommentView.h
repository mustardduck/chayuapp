//
//  CYQuanZiCommentView.h
//  茶语
//
//  Created by Leen on 16/7/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYMyCommentModel.h"

@protocol CYQuanZiCommentViewDelegate;

@interface CYQuanZiCommentView : UIView

@property (nonatomic,assign)CGFloat endHeight;
@property (nonatomic,assign)NSInteger pageSize;

@property (nonatomic, strong) NSString * topicId;
@property (nonatomic, assign) id<CYQuanZiCommentViewDelegate> delegate;

-(void)loadTableViewData:(BOOL)loadMore;

@end

@protocol CYQuanZiCommentViewDelegate <NSObject>

@optional
- (void)evaluationViewendHeight:(CGFloat)endheight;

- (void)showAllEvaluation;

- (void)huitie_click;

- (void)commentBtnClicked:(CYQuanZiCommentModel *)model;
- (void)seeFullScreenClicked:(CYQuanZiCommentModel *)model currentPage:(NSInteger) index;

@end