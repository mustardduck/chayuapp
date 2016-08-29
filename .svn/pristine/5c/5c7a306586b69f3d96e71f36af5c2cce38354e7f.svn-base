//
//  CYHuaTiDetContentCell.m
//  茶语
//
//  Created by Chayu on 16/7/7.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYHuaTiDetContentCell.h"

@interface CYHuaTiDetContentCell ()<BBWebViewSizeAdjust>


@end

@implementation CYHuaTiDetContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setContentStr:(NSString *)contentStr
{
    _contentStr = contentStr;
    _webView.sizeDelegate = self;
    [_webView loadHTMLString:_contentStr baseURL:[NSURL URLWithString:@"http://app.chauyu.com"]];
}

-(void)bbweb:(BBWebView *)web didAdjustSizeTo:(CGSize)endSize from:(CGSize)startSize
{
    if (endSize.height>startSize.height) {
        NSLog(@"endSize.height = %.2f",endSize.height);
        if (self.reloadBlock) {
            self.reloadBlock(endSize.height);
        }
    }
}

@end
