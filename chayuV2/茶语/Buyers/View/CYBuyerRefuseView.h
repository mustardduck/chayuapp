//
//  CYBuyerRefuseView.h
//  茶语
//
//  Created by Leen on 16/7/12.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceholderTextView.h"

@protocol CYBuyerRefuseViewDelegate;

@interface CYBuyerRefuseView : UIView

@property (weak, nonatomic) IBOutlet PlaceholderTextView *textView;
@property (assign, nonatomic) id<CYBuyerRefuseViewDelegate> delegate;


@end


@protocol CYBuyerRefuseViewDelegate <NSObject>

@optional

- (void)refuseViewCancelClicked;
- (void)refuseViewCommentClicked;

@end
