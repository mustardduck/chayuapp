//
//  CYShippingAddressCell.h
//  TeaMall
//
//  Created by Chayu on 15/11/2.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYShippingAddressModel.h"

@protocol CYShippingAddressCellDelegate;

@interface CYShippingAddressCell : UITableViewCell
+(instancetype)cellWidthTableView:(UITableView*)tableView;
@property (nonatomic,strong)CYShippingAddressModel *model;
@property (nonatomic,assign)id<CYShippingAddressCellDelegate>delegate;

@end


@protocol CYShippingAddressCellDelegate <NSObject>

-(void)shipeditorCell:(CYShippingAddressCell *)cell AndModel:(CYShippingAddressModel *)model;

@end