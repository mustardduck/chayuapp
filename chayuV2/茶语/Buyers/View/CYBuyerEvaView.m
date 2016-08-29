//
//  CYBuyerEvaView.m
//  茶语
//
//  Created by Leen on 16/7/6.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerEvaView.h"
#import "UICommon.h"

@implementation CYBuyerEvaView

- (IBAction)cancelClicked:(id)sender {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(evaViewCancelClicked)])
    {
        [self.delegate evaViewCancelClicked];
    }
    
}

- (IBAction)commentClicked:(id)sender {
    
    if([UICommon isBlankString:_textView.text])
    {
        [Itost showMsg:@"评论内容不能为空" inView:self];
        [_textView becomeFirstResponder];
        
        return;
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(evaViewCommentClicked)])
    {
        [self.delegate evaViewCommentClicked];
    }
}

@end
