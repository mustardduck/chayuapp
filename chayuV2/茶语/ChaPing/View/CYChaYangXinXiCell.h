//
//  CYChaYangXinXiCell.h
//  茶语
//
//  Created by Chayu on 16/7/27.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseButton.h"
@interface CYChaYangXinXiCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *chabiLbl;
@property (weak, nonatomic) IBOutlet UILabel *kucunLbl;
@property (weak, nonatomic) IBOutlet UILabel *guigeLbl;
@property (weak, nonatomic) IBOutlet UILabel *pinfenLbl;
@property (weak, nonatomic) IBOutlet UILabel *zongpingLbl;
@property (weak, nonatomic) IBOutlet BaseButton *xiechapingBtn;

@property (weak, nonatomic) IBOutlet UIButton *goumaiBtn;
@property (weak, nonatomic) IBOutlet UIView *goumaiView;


@end
