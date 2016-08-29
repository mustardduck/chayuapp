//
//  CYArticleCommentInfo.h
//  茶语
//
//  Created by 李峥 on 16/2/23.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYArticleCommentInfo : NSObject

/**
 *  内容id，即文章id
 */
@property (nonatomic, strong) NSString *itemid;
/**
 *  用户Id
 */
@property (nonatomic, strong) NSString *uid;

/**
 *  回复评论人的uid
 */
@property (nonatomic, strong) NSString *touid;

/**
 *  上级评论id,为0直接评论，反之为评论该文章的评论
 */
@property (nonatomic, strong) NSString *pid;
/**
 *  评论Id
 */
@property (nonatomic, strong) NSString *commentid;

/**
 *  文章默认为1，98为专题
 */
@property (nonatomic, assign) NSInteger type;

/**
 *  总分
 */
@property (nonatomic, strong) NSString *score;
/**
 *  评论时间
 */
@property (nonatomic, strong) NSString *created;
/**
 *  评论内容
 */
@property (nonatomic, strong) NSString *content;
/**
 *  用户昵称
 */
@property (nonatomic, strong) NSString *nickname;
/**
 *  被评论者的昵称
 */
@property (nonatomic, strong) NSString *toNickname;

/**
 *  用户头像
 */
@property (nonatomic, strong) NSString *avatar;
/**
 *  被评论数
 */
@property (nonatomic, strong) NSString *comments;

@property (nonatomic,assign)BOOL isSuported;

@property (nonatomic,strong)NSString *suports;

@end
