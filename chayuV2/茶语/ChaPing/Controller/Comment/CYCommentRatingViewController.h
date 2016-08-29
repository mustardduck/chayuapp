//
//  CYCommentRatingViewController.h
//  茶语
//
//  Created by 李峥 on 16/2/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBaseViewController.h"
#import "CYRatingInfo.h"

@protocol CYCommentRatingViewDelegate <NSObject>

/**
 *  评分
 *
 *  @param dict {drytea:soupcolor:smell:flavour:leaves}
 */
- (void)commentRatingData:(CYRatingInfo *)info;

@end

@interface CYCommentRatingViewController : CYBaseViewController

@property (nonatomic, weak) id<CYCommentRatingViewDelegate> delegate;

@property (nonatomic,strong)CYRatingInfo *retInfo;


@end
