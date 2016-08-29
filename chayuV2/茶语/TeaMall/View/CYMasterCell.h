//
//  CYMasterCell.h
//  TeaMall
//
//  Created by Chayu on 15/10/22.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYMasterCellModel.h"
@interface CYMasterCell : UITableViewCell

#define MASTERCELL_HEIGHT 244.


@property (nonatomic,strong)CYMasterCellModel *masterModel;

+(instancetype)cellWidthTableView:(UITableView*)tableView;

@property (nonatomic,assign)BOOL isMaster;



@end
