//
//  PYMultiLabel.m
//  PYFrameworks
//
//  Created by 李 峥 on 14/12/2.
//  Copyright (c) 2014年 李 峥. All rights reserved.
//

#import "PYMultiLabel.h"

@interface PYMultiLabel ()

- (NSMutableAttributedString *)attributedString;

@end

@implementation PYMultiLabel

#pragma mark -
#pragma mark - Public methods
- (void)setBoldFontToRange:(NSRange)range
{
    NSString *fontNameBold = [NSString stringWithFormat:@"%@-Bold",
                              [[self.font familyName] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    if (![UIFont fontWithName:fontNameBold size:self.font.pointSize]) {
        NSLog(@"Font not found: %@", fontNameBold);
        return;
    }
    
    UIFont *font = [UIFont fontWithName:fontNameBold size:self.font.pointSize];
    
    NSMutableAttributedString *attributed = [self attributedString];
    [attributed addAttribute:NSFontAttributeName value:font range:range];
    
    self.attributedText = attributed;
}

- (void)setBoldFontToString:(NSString *)string
{
    NSRange range = [self.text rangeOfString:string];
    [self setBoldFontToRange:range];
}

- (void)setFontColor:(UIColor *)color range:(NSRange)range
{
    NSMutableAttributedString *attributed = [self attributedString];
    [attributed addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    self.attributedText = attributed;
}

- (void)setFontColor:(UIColor *)color string:(NSString *)string
{
    NSRange range = [self.text rangeOfString:string];
    [self setFontColor:color range:range];
}

- (void)setFontColor:(UIColor *)color fontSize:(UIFont *)font string:(NSString *)string
{
    NSRange range = [self.text rangeOfString:string];
    
    [self setFontColor:color range:range];
    
    NSMutableAttributedString *attributed = [self attributedString];
    [attributed addAttribute:NSFontAttributeName value:font range:range];
    
    self.attributedText = attributed;
}

- (void)setFont:(UIFont *)font range:(NSRange)range
{
    NSMutableAttributedString *attributed = [self attributedString];
    [attributed addAttribute:NSFontAttributeName value:font range:range];
    
    self.attributedText = attributed;
}

- (void)setFont:(UIFont *)font string:(NSString *)string
{
    NSRange range = [self.text rangeOfString:string];
    [self setFont:font range:range];
}


#pragma mark -
#pragma mark - Private methods

- (NSMutableAttributedString *)attributedString
{
    return [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
}
@end
