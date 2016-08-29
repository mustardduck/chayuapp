//
//  CYTeaCommentListViewController.h
//  茶语
//
//  Created by 李峥 on 16/2/21.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBaseListViewController.h"

typedef NS_ENUM(NSInteger, CommentListType) {
    CommentListType_tea = 0,
    CommentListType_sample = 1,
    CommentListType_article = 2
};

@interface CYTeaCommentListViewController : CYBaseListViewController

@property (nonatomic, copy) NSString *mItemId;
@property (nonatomic, copy) NSString *mBid;
@property (nonatomic, assign) CommentListType mType;

@end
