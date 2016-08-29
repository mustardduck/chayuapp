//
//  BBWebView.m
//  JiuLongScene
//
//  Created by box on 14/12/9.
//  Copyright (c) 2014年 iXcoder. All rights reserved.
//

#import "BBWebView.h"

@implementation BBWebView

- (void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setContentObserver];
//    [self performSelector:@selector(setContentObserver) withObject:nil afterDelay:0.1];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setContentObserver];
    }
    return self;
}

- (void)setContentObserver
{
    [self.scrollView addObserver:self
                      forKeyPath:@"contentSize"
                         options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                         context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (![keyPath isEqualToString:@"contentSize"]) {
        return ;
    }
    NSValue *oldSize = [change objectForKey:NSKeyValueChangeOldKey];
    NSValue *newSize = [change objectForKey:NSKeyValueChangeNewKey];
    
    if ([self.sizeDelegate respondsToSelector:@selector(bbweb:didAdjustSizeTo:from:)]) {
        [self.sizeDelegate bbweb:self didAdjustSizeTo:[newSize CGSizeValue] from:[oldSize CGSizeValue]];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    [self startSetting];
}



- (void)startSetting
{
    //改变webview字体大小
    
//    CGFloat k = 100;
//    NSString *js = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",300*k];
//    [self stringByEvaluatingJavaScriptFromString:js];
//    
//        NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%f, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"", self.frame.size.width];
////    [self stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
////     "script.type = 'text/javascript';"
////     "script.text = \"function ResizeImages() { "
////     "var myimg,oldwidth,oldheight;"
////     "var maxwidth=320;"// 图片宽度
////     "for(i=0;i  maxwidth){"
////     "myimg.width = maxwidth;"
////     "}"
////     "}"
////     "}\";"
////     "document.getElementsByTagName('head')[0].appendChild(script);"];
//    [self stringByEvaluatingJavaScriptFromString:meta];
    
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
//    js = @"window.onload = function(){\
//    document.body.style.background = 'transparent';\
//    }";
//    [self stringByEvaluatingJavaScriptFromString:js];
    
}

- (CGFloat)height
{
    if (_heightConstraint) {
        _heightConstraint.constant = 1.;
    }else{
        CGRect frame = self.frame;
        frame.size.height = 1;
        self.frame = frame;
    }
    [self layoutIfNeeded];

    NSString *height_str= [self stringByEvaluatingJavaScriptFromString: @"document.body.height;"];
    CGFloat height = [height_str floatValue];
    
    return height;
}


@end
