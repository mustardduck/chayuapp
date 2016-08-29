//
//  BaseLable.h
//  鲜蜂队
//
//  Created by Chayu on 15/12/23.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseLable : UILabel


+(BaseLable *)initWithFrame:(CGRect)rect TxtColor:(UIColor *)txtColor textAlignment:(NSTextAlignment)alignment Font:(UIFont *)font title:(NSString *)title;

@property(nonatomic,assign)IBInspectable CGFloat cornerRadius;
@property (nonatomic,assign)IBInspectable CGFloat borderWidth;

@property (nonatomic,strong)IBInspectable UIColor *borderColor;

@end
