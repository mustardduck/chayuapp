//
//  CYHomeShiJiView.h
//  茶语
//
//  Created by Chayu on 16/6/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYHomeInfo.h"
@interface CYHomeShiJiView : UIView

@property (nonatomic,strong)CYHomeMarkertInfo *markerInfo;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end
