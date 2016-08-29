//
//  CYWuliuTableViewCell.h
//  茶语
//
//  Created by Chayu on 16/4/23.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYWuliuTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *stateImg;

@property (nonatomic,assign)BOOL isSelect;


@property (nonatomic,strong)NSDictionary *info;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@end
