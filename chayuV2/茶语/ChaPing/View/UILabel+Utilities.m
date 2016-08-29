//
//  UILabel+Utilities.m
//  PYFramework
//
//  Created by 李峥 on 15/8/11.
//  Copyright (c) 2015年 李峥. All rights reserved.
//

#import "UILabel+Utilities.h"

@implementation UILabel (Utilities)

- (CGFloat)boundingRectWithHeight
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = self.textAlignment;
    NSDictionary *attributes = @{NSFontAttributeName : self.font,
                                 NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize size = CGSizeMake(CGRectGetWidth(self.bounds), MAXFLOAT);
    
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading;
    NSLog(@"%@",self.text);
    
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:options
                                          attributes:attributes
                                             context:nil].size;
    
    return retSize.height;
}

- (CGFloat)boundingRectWithWidth
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    
    NSDictionary *attributes = @{NSFontAttributeName : self.font,
                                 NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize size = CGSizeMake(MAXFLOAT, CGRectGetHeight(self.bounds));
    
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading;
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:options
                                          attributes:attributes
                                             context:nil].size;
    
    return retSize.width;
}

@end
