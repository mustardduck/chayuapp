//
//  CYMyShiJiCell.h
//  茶语
//
//  Created by Chayu on 16/7/11.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYRoundLbl.h"
@interface CYMyShiJiCell : UITableViewCell



@property (weak, nonatomic) IBOutlet CYRoundLbl *daifukuanNumLbl;

@property (weak, nonatomic) IBOutlet CYRoundLbl *daifahuoNumLbl;

@property (weak, nonatomic) IBOutlet CYRoundLbl *daishouhuoNumLbl;

@property (weak, nonatomic) IBOutlet CYRoundLbl *daipingjiaNumLbl;

@property (weak, nonatomic) IBOutlet CYRoundLbl *gouwucheNumLbl;
@property (weak, nonatomic) IBOutlet CYRoundLbl *dikouquanNumLbl;

@property (weak, nonatomic) IBOutlet CYRoundLbl *guanzhuNunLbl;



- (IBAction)menu_click:(id)sender;

@property(nonatomic,copy)void (^menuclickBlock)(NSInteger);
@end
