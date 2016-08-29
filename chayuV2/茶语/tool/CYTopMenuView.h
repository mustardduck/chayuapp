//
//  CYTopMenuView.h
//  茶语
//
//  Created by Chayu on 16/7/5.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CYTopMenuBtn : UIButton

@end

@interface CYTopMenuView : UIView

@property (nonatomic,copy)void (^buttonSelectIndex)(NSInteger );

-(void)initwithMen:(NSArray *)menuArr;

@property (nonatomic,strong)NSString *selectTitle;

@property (nonatomic,assign)NSInteger selectIndexButtonTag;


@end

