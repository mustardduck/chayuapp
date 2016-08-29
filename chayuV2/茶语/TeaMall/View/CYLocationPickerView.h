//
//  CYLocationPickerView.h
//  TeaMall
//
//  Created by Chayu on 15/11/18.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYLocationPickerViewDelegate;

@interface CYLocationPickerView : UIView

@property (nonatomic,strong)id<CYLocationPickerViewDelegate>delegate;

@end


@protocol CYLocationPickerViewDelegate <NSObject>

-(void)confirmselectLocationInfo:(NSDictionary *)info;

-(void)cancel;

@end