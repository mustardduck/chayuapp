//
//  CYWenZhangCommentCell.h
//  茶语
//
//  Created by Leen on 16/7/30.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYMyCommentModel.h"

@protocol CYWenZhangCommentCellDelegate;

@interface CYWenZhangCommentCell : UITableViewCell

@property (nonatomic, strong) NSString * wenzhangId;


@property (nonatomic,copy)void(^reloadBlock)(CGFloat);

@property (nonatomic, assign) id <CYWenZhangCommentCellDelegate> delegate;

@end

@protocol CYWenZhangCommentCellDelegate <NSObject>

- (void)showAllEvaluation;
- (void)huifu_click;
- (void)commentBtnClicked:(CYWenZhangCommentModel *)model;

@end


