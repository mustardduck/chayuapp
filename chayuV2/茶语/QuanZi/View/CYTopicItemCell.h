//
//  CYTopicItemCell.h
//  茶语
//
//  Created by iXcoder on 16/2/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBBSItemCell.h"

@interface CYTopicItemCell : CYBBSItemCell

@property (nonatomic, copy) void(^needAttention)(NSDictionary *topicInfo);

@end
