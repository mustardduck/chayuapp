//
//  CYMyChaPingTableViewCell.h
//  茶语
//
//  Created by Chayu on 16/7/18.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYMyChaPingTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet UILabel *statusLbl;

@property (weak, nonatomic) IBOutlet UILabel *zongfenLbl;

@property (weak, nonatomic) IBOutlet UILabel *contentLbl;


@property (weak, nonatomic) IBOutlet UILabel *timeLbl;


@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;





@end
