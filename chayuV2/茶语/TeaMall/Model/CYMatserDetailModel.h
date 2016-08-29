//
//  CYMatserDetail.h
//  茶语
//
//  Created by Leen on 16/2/26.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYMatserDetailModel : NSObject



@property (nonatomic,copy)NSString *count;

@property (nonatomic,copy)NSString *gid;

@property (nonatomic,copy)NSString *des;

@property (nonatomic,copy)NSString *isAttend;

@property (nonatomic,copy)NSString *videoPath;

@property (nonatomic,strong)NSString *video_thumb;

@property (nonatomic,strong)NSString *wap_content;

@property (nonatomic,strong)NSString *wap_thumb;

@property (nonatomic,strong)NSArray *list;

@property (nonatomic,strong)NSString *mainid;


@property (nonatomic,strong)NSString *sellerName;


@property (nonatomic,strong)NSString *avatar;

@property (nonatomic,strong)NSString *is_video;

@end
