//
//  BBBaseViewController.h
//  JiuLongScene
//
//  Created by iXcoder on 14/11/27.
//  Copyright (c) 2014年 iXcoder. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AFNetworking.h"
#import "CYActionSheet.h"

#import "NTNavigationBar.h"
typedef NS_ENUM(NSUInteger, BBKeyboardEvent) {
    BBKeyboardEventNone = 0,
    BBKeyboardEventWillShow = 1 << 0,
    BBKeyboardEventWillChangeFrame = 1 << 1,
    BBKeyboardEventWillHide = 1 << 2,
    BBKeyboardEventWillChangeDisplay = BBKeyboardEventWillShow | BBKeyboardEventWillHide,
    BBKeyboardEventAll = BBKeyboardEventWillChangeDisplay | BBKeyboardEventWillChangeFrame
};

//typedef NS_ENUM(NSUInteger, NavBarStyle) {
//    NavBarStyleNone = 0,
//    NavBarStyleNoneMore = 1 << 0,
//    NavBarStyleNoneMoreCar = 1 << 1
//};

@interface CYBaseViewController : UIViewController

@property (strong,nonatomic)NTNavigationBar *navBar;


-(void)showActionSheet:(OSMessage *)message;

-(void)shareWeiXin:(OSMessage *)message;

-(void)sharePengYouQuan:(OSMessage *)message;

-(void)shareQQ:(OSMessage *)message;

-(void)creatkongNavBar;

- (void) navBarClicked:(UINavigationController *)nav tag:(NSInteger) tag shareMessage:(OSMessage *)shareMsg;


-(UIView *)emptyView;

@end
