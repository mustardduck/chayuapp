//
//  CYBBSTitleView.h
//  茶语
//
//  Created by iXcoder on 16/2/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYBBSTitleView : UIView

+ (instancetype)titleViewWithNames:(NSArray *)names;

@property (nonatomic, copy) void(^callback)(NSUInteger index);

@property (nonatomic, assign) NSUInteger selectedIndex;

@end
