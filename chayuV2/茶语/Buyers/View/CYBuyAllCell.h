//
//  CYBuyAllCell.h
//  茶语
//
//  Created by Leen on 16/6/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYBuyerMainCellModel.h"
#import "PYMultiLabel.h"
#import "CYBuyerAllListCellModel.h"


@interface CYBuyAllCell : UITableViewCell

+ (instancetype) cellForTableView:(UITableView *)tableView;

@property (nonatomic, strong) CYBuyerMainCellModel * model;
@property (nonatomic, strong) CYBuyerAllListCellModel * allListCellmodel;

@property (weak, nonatomic) IBOutlet UIImageView *imgview;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *vipIcon;
@property (weak, nonatomic) IBOutlet PYMultiLabel *desLbl;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (weak, nonatomic) IBOutlet UIImageView *followIcon;
@property (weak, nonatomic) IBOutlet UIView *tagView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagViewHeightCons;
@property (nonatomic, assign) BOOL isOnlyShowContent;

@end