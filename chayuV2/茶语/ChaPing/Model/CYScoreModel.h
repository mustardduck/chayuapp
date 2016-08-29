//
//  CYScoreModel.h
//  茶语
//
//  Created by Leen on 16/3/2.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYScoreArticleInfo : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *articleid;
@property (nonatomic, strong) NSString *copyfrom;
@property (nonatomic, strong) NSString *clicks;
@property (nonatomic, strong) NSString *top;

@end

@interface CYScoreTopicInfo : NSObject

@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *tid;
@property (nonatomic, strong) NSString *copyfrom;
@property (nonatomic, strong) NSString *hits;
@property (nonatomic, strong) NSString *top;

@end

@interface CYScoreTBInfo : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *top;
@property (nonatomic, strong) NSString *tid;

@end

@interface CYScoreModel : NSObject

@property (nonatomic, strong) NSString *teaid;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *brand;

@property (nonatomic, strong) NSString *top;

@property (nonatomic,strong)NSString *sampleid;
//综合评分
@property (nonatomic, strong) NSString *review_score;
//兑换量
@property (nonatomic, strong) NSString *user;
//点击量
@property (nonatomic, strong) NSString *clicks;

@property (nonatomic, strong) NSString *number;


@end
