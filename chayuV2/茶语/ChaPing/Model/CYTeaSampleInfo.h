//
//  CYTeaSampleInfo.h
//  茶语
//
//  Created by 李峥 on 16/2/22.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTeaSampleInfo : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *bid;
@property (nonatomic, strong) NSString *created;
@property (nonatomic, strong) NSString *sampleid;
@property (nonatomic, strong) NSString *brand;
@property (nonatomic, strong) NSString *size;
@property (nonatomic, strong) NSString *shareurl;
@property (nonatomic, strong) NSString *remain;
@property (nonatomic, strong) NSString *review;
@property (nonatomic, strong) NSString *goods_id;

#pragma mark - detail
@property (nonatomic, strong) NSString *teaid;


/**
 *  已兑换数-我收藏的茶样
 */
@property (nonatomic, strong) NSString * applys_num;

/**
 *  茶叶名称-我收藏的茶样
 */
@property (nonatomic, strong) NSString *tea_title;


@end
