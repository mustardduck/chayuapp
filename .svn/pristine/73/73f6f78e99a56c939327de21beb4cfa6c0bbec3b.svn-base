//
//  NIDropDown.h
//  NIDropDown
//
//  Created by Bijesh N on 12/28/12.
//  Copyright (c) 2012 Nitor Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LDXDropDown;
@protocol LDXDropDownDelegate<NSObject>
- (void) ldxDropDownDelegateMethod: (LDXDropDown *) sender index:(NSInteger)index title:(NSString*)title;
@end 

@interface LDXDropDown : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id <LDXDropDownDelegate> delegate;

-(void)hideDropDown:(UIButton *)b;
- (id)initDropDown:(UIButton *)b maxHeight:(CGFloat)height titles:(NSArray *)arr inView:(UIView*)view;
@end
