//
//  BBWebView.h
//  JiuLongScene
//
//  Created by box on 14/12/9.
//  Copyright (c) 2014年 iXcoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBWebViewSizeAdjust;


@interface BBWebView : UIWebView
 
@property (strong, nonatomic) NSLayoutConstraint *heightConstraint;
@property (nonatomic,assign,readonly)CGFloat height;

@property (nonatomic, assign) id<BBWebViewSizeAdjust> sizeDelegate;

@end


@protocol BBWebViewSizeAdjust <NSObject>

- (void)bbweb:(BBWebView *)web didAdjustSizeTo:(CGSize)endSize from:(CGSize)startSize;

@end