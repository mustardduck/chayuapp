//
//  HongBaoView.h
//  HongBao
//
//  Created by Chayu on 16/2/23.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HongBaoViewDelegate;

@interface HongBaoView : UIView

/**
 *  <#属性说明#>
 */
@property (nonatomic,assign)id<HongBaoViewDelegate>delegate;

+(instancetype)createViewFromNib;

- (void)hide;
- (void)showInWindow;

@end


@protocol HongBaoViewDelegate <NSObject>

-(void)gotoMyHongBao;


@end