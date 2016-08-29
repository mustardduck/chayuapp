//
//  CYQuanZiCell.h
//  茶语
//
//  Created by Chayu on 16/6/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
#import "CYHomeQuanZiView.h"
@interface CYHomeQuanZiCell : BaseCell

@property (nonatomic,copy)void (^gotosomeViewBlock)(CYHomeQuanInfo *info);

@property (nonatomic,copy)void (^gengduoBlock)();

@end
