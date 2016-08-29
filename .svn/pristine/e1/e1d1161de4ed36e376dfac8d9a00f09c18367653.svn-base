//
//  CYHuaTiDetCommentCell.h
//  茶语
//
//  Created by Leen on 16/7/27.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYMyCommentModel.h"

@protocol CYHuaTiDetCommentCellDelegate;

@interface CYHuaTiDetCommentCell : UITableViewCell

@property (nonatomic, strong) NSString * topicId;

@property (nonatomic,copy)void(^reloadBlock)(CGFloat);

@property (nonatomic, assign) id <CYHuaTiDetCommentCellDelegate> delegate;

@end

@protocol CYHuaTiDetCommentCellDelegate <NSObject>

- (void)showAllEvaluation;
- (void)huitie_click;
- (void)commentBtnClicked:(CYQuanZiCommentModel *)model;

@end