//
//  CYWriteArticelCommentViewController.h
//  茶语
//
//  Created by 李峥 on 16/2/23.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBaseViewController.h"
#import "CommentProtocol.h"

@interface CYWriteArticelCommentViewController : CYBaseViewController

/**
 *  内容id，文章id
 */
@property (nonatomic, copy) NSString *mItemid;

/**
 *  上级评论id
 */
@property (nonatomic, copy) NSString *pid;

/**
 *  回复用户id
 */
@property (nonatomic, copy) NSString *touid;

@property (nonatomic,assign)BOOL isTea;//是否是茶评茶样


@property (nonatomic, weak) id<CommentProtocol> delegate;

@end
