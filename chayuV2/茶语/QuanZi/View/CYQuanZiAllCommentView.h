//
//  CYQuanZiAllCommentView.h
//  茶语
//
//  Created by Leen on 16/7/27.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYMyCommentModel.h"

@protocol CYQuanZiAllCommentViewDelegate;

@interface CYQuanZiAllCommentView : UIView

@property (nonatomic, strong) NSString * topicId;
@property (nonatomic, assign) id<CYQuanZiAllCommentViewDelegate> delegate;

-(void)loadTableViewData:(BOOL)loadMore;
@end

@protocol CYQuanZiAllCommentViewDelegate <NSObject>

- (void)commentBtnClicked:(CYQuanZiCommentModel *)model;

@optional
- (void)zanBtnClicked:(id)sender;

@end