//
//  CYWenZhangCell.h
//  茶语
//
//  Created by Chayu on 16/6/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
#import "CYHomeWenZhangView.h"
@interface CYHomeWenZhangCell : BaseCell

@property (nonatomic,strong)void (^gotosomeViewBlock)(CYHomeToDayNewsInfo *info);

@property (nonatomic,copy)void (^gengduoBlock)();

@end
