//
//  CYHuaTiDetLikeCell.h
//  茶语
//
//  Created by Chayu on 16/7/7.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYHuaTiDetLikeCell : UITableViewCell

@property (nonatomic,strong)NSArray *likeArr;

@property (nonatomic,copy)void(^selecthuatiBlock)(NSString *tid);

@end
