//
//  CYHandmadeView.h
//  TeaMall
//
//  Created by Chayu on 15/10/21.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYHandmadeViewDelegate;

@interface CYHandmadeView : UIView

@property (nonatomic,copy)NSString *contentStr;

@property (nonatomic,copy)NSString *teasnum;

@property (nonatomic,assign)id<CYHandmadeViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIButton *insbtn;


@end

@protocol CYHandmadeViewDelegate <NSObject>

@optional
/**
 *  大师介绍
 */
-(void)masterIntroduced;

/**
 *  好茶详情
 */
-(void)goodTeadetails;

@end
