    //
//  CYTeaListCell.h
//  TeaMall
//
//  Created by Chayu on 15/10/27.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYTeaListModel.h"

@interface CYTeaListCell : UITableViewCell

@property (nonatomic,strong)CYTeaListModel  *teaModel;

+(instancetype)cellWidthTableView:(UITableView*)tableView;

@end
