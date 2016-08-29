//
//  HongBaoView.m
//  HongBao
//
//  Created by Chayu on 16/2/23.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "HongBaoView.h"

@interface HongBaoView ()
{

}

@property (weak, nonatomic) IBOutlet UIView *topVIew;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UIButton *clickBtn;

@property (weak, nonatomic) IBOutlet UIView *altView;
@property (weak, nonatomic) IBOutlet UIView *openView;
- (IBAction)homebaorule_click:(id)sender;
- (IBAction)close_click:(id)sender;
- (IBAction)openHongbao_click:(id)sender;
- (IBAction)viewmyhongbao_click:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *clickBg;



@end


@implementation HongBaoView



+ (instancetype)createViewFromNibName:(NSString *)nibName
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    return [nib objectAtIndex:0];
}

+ (instancetype)createViewFromNib
{
    return [self createViewFromNibName:NSStringFromClass(self.class)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        
    }
    return self;
}
-(void)awakeFromNib
{
    _altView.layer.cornerRadius = 5.0f;
}


#pragma mark - add Gesture
- (void)addSingleGesture
{
    //单指单击
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [self addGestureRecognizer:singleTap];
}

#pragma mark 手指点击事件
- (void)singleTap:(UITapGestureRecognizer *)sender
{
    [self hide];
}


- (void)showInWindow
{
    [self show];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//#define kCurrentWindow [UIApplication sharedApplication].window

- (void)show
{
 
    if (self.superview == nil) {
        [WINDOW addSubview:self];
    }
    self.alpha = 0;
    _altView.transform = CGAffineTransformScale(_altView.transform,0.1,0.1);
    [UIView animateWithDuration:0.3 animations:^{
        _altView.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
    
}

- (void)hide
{
    if (self.superview) {
        [UIView animateWithDuration:0.3 animations:^{
            _altView.transform = CGAffineTransformScale(_altView.transform,0.1,0.1);
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

- (IBAction)homebaorule_click:(id)sender {
    
}

- (IBAction)close_click:(id)sender {
    [self hide];
}

- (IBAction)openHongbao_click:(id)sender {
    [self startAnimation];
    [self performSelector:@selector(openTheHongbao) withObject:nil afterDelay:10];
}


-(void) startAnimation
{
    
    _clickBtn.userInteractionEnabled = NO;
    //添加动画
    CABasicAnimation *monkeyAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    monkeyAnimation.toValue = [NSNumber numberWithFloat:2. *M_PI];
    monkeyAnimation.duration = 2;
    monkeyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    monkeyAnimation.cumulative = YES;
    monkeyAnimation.removedOnCompletion = NO; //No Remove
    monkeyAnimation.repeatCount = FLT_MAX;
    [_clickBtn.layer addAnimation:monkeyAnimation forKey:@"AnimatedKey"];
    
}



-(void)openTheHongbao
{
    
    self.clickBg .hidden = YES;
    __block CGRect topRec = _topVIew.frame;
   __block CGRect bottomRec = _bottomView.frame;
    [UIView animateWithDuration:0.25 animations:^{
        topRec.origin.y = -topRec.size.height;
        _topVIew.frame = topRec;
        bottomRec.origin.y = _altView.frame.size.height;
        _bottomView.frame = bottomRec;
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)viewmyhongbao_click:(id)sender {
    if ([self.delegate respondsToSelector:@selector(gotoMyHongBao)]) {
        [self.delegate gotoMyHongBao];
    }
}
@end
