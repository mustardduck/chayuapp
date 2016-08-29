//
//  CYTopicReplyCell.h
//  茶语
//
//  Created by iXcoder on 16/2/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBBSItemCell.h"

@interface CYTopicReplyCell : CYBBSItemCell

@property (nonatomic, copy) void(^praiseCallback)(NSDictionary*);
@property (nonatomic, copy) void(^replyCallback)(NSDictionary*);

@end
