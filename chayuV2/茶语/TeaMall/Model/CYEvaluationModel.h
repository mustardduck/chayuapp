//
//  CYEvaluationModel.h
//  TeaMall
//
//  Created by Chayu on 15/10/27.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYEvaluationModel : NSObject


@property (nonatomic,copy)NSString *content;
/**
 *  星星数量
 */
@property (nonatomic,copy)NSString *score;


/**
 *  评价时间
 */
@property (nonatomic,copy)NSString *created;

/**
 *  规格等信息
 */
@property (nonatomic,copy)NSString *spec;

/**
 *  cell高度
 */
@property (nonatomic,assign)CGFloat cellHeight;

/**
 *  用户信息
 */
@property (nonatomic,strong)NSDictionary *user;


//追加评论
@property (nonatomic,strong)NSDictionary *secreview;


/**
 *  卖家首次回复
 */
@property (nonatomic,strong)NSDictionary *adminreview;

///
/**
 *  卖家回复追评
 */
@property (nonatomic,strong)NSDictionary *secadminreview;


@property (nonatomic, strong)NSArray * attach;//评论图片arr

@end
