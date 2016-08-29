//
//  CYBuyerReturnMainVC.h
//  茶语
//
//  Created by Leen on 16/7/11.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBaseViewController.h"

@interface CYBuyerReturnMainVC : CYBaseViewController

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITableView *mainTable;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainTableBottomCons;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *refuseBtn;
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;

@end
