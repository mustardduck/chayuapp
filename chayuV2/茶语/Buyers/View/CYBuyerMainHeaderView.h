//
//  CYBuyerMainHeaderView.h
//  茶语
//
//  Created by Leen on 16/7/21.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYBuyerMainHeaderViewDelegate;

@interface CYBuyerMainHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *recomBtn;
@property (weak, nonatomic) IBOutlet UIButton *latestBtn;
@property (weak, nonatomic) IBOutlet UIButton *popularBtn;
@property (weak, nonatomic) IBOutlet UIButton *allBuyerBtn;

@property (nonatomic, strong)NSString * touUrl;

@property (nonatomic,assign)id<CYBuyerMainHeaderViewDelegate>delegate;

@end


@protocol CYBuyerMainHeaderViewDelegate <NSObject>

-(void)topMenuSelect:(NSInteger)tag;

@end