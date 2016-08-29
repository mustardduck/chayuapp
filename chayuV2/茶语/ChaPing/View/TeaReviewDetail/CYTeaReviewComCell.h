//
//  CYTeaReviewComCell.h
//  茶语
//
//  Created by 李峥 on 16/2/19.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYTeaReviewComCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mDesLabel;

@property (weak, nonatomic) IBOutlet UIView *shopnameBg;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLbl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shopbg_cons;

@property (weak, nonatomic) IBOutlet UIButton *mShopBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom_cons;



@end
