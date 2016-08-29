//
//  CYBuyerEvaView.h
//  茶语
//
//  Created by Leen on 16/7/6.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceholderTextView.h"

@protocol CYBuyerEvaViewDelegate;

@interface CYBuyerEvaView : UIView
@property (weak, nonatomic) IBOutlet PlaceholderTextView *textView;
@property (assign, nonatomic) id<CYBuyerEvaViewDelegate> delegate;


@end


@protocol CYBuyerEvaViewDelegate <NSObject>

@optional

- (void)evaViewCancelClicked;
- (void)evaViewCommentClicked;

@end