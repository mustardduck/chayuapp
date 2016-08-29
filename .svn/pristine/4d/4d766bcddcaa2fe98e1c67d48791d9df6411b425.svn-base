//
//  CYAddressManagementCell.h
//  TeaMall
//
//  Created by Chayu on 15/11/2.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYShippingAddressModel.h"

@protocol CYAddressManagementCellDelegate;


@interface CYAddressManagementCell : UITableViewCell

+(instancetype)cellWidthTableView:(UITableView*)tableView;

@property (nonatomic,strong)CYShippingAddressModel *model;

@property (nonatomic,assign)id<CYAddressManagementCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;
@end


@protocol CYAddressManagementCellDelegate <NSObject>

-(void)setAsDefaultCell:(CYAddressManagementCell *)cell andModel:(CYShippingAddressModel *)model;

-(void)editorCell:(CYAddressManagementCell *)cell AndModel:(CYShippingAddressModel *)model;

- (void)deleteCell:(CYAddressManagementCell*)cell AndModel:(CYShippingAddressModel *)model;

@end