//
//  CYImpAltView.m
//  茶语
//
//  Created by Chayu on 16/5/30.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYImpAltView.h"
#import "CYImpInfoViewController.h"
#import "BXTabBarController.h"
@interface CYImpAltView ()


- (IBAction)cancel_click:(id)sender;

- (IBAction)perfect_click:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *contentView;


@end


@implementation CYImpAltView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)cancel_click:(id)sender {
    [self removeFromSuperview];
    
}

- (IBAction)perfect_click:(id)sender {
    
     [self removeFromSuperview];
    CYImpInfoViewController *vc = viewControllerInStoryBoard(@"CYImpInfoViewController", @"Log");
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    BXTabBarController *tabVC = (BXTabBarController *)APP_DELEGATE.window.rootViewController;
    [tabVC presentViewController:nav animated:YES completion:^{
        
    }];
    
}


+(void)show
{
    
    CYImpAltView *altView = [[[NSBundle mainBundle] loadNibNamed:@"CYImpAltView" owner:nil options:nil] firstObject];
    altView.frame = WINDOW.bounds;
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.33;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [altView.layer addAnimation:animation forKey:nil];
    [[CYImpAltView getWindow] addSubview:altView];
   
}


-(void)awakeFromNib
{
    _contentView.layer.cornerRadius = 2.0f;
}

+ (UIWindow *)getUnhiddenFrontWindowOfApplication{
    
    NSArray *windows = [[UIApplication sharedApplication] windows];
    NSInteger windowCnt = [windows count];
    for (NSInteger i = windowCnt - 1; i >= 0; i--) {
        UIWindow* window = [windows objectAtIndex:i];
        if (FALSE == window.hidden) {
            //定制：防止产生bar提示，用的是新增window,排除这个window
            if (window.frame.size.height > 50.0f) {
                return window;
            }
        }
    }
    return NULL;
}

+ (UIWindow*)getWindow{
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    return window;
}
@end
