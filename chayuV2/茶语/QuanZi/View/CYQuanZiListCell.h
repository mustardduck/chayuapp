//
//  CYQuanZiListCell.h
//  茶语
//
//  Created by Chayu on 16/7/6.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYRoundLbl.h"
@interface CYQuanZiListCell : UITableViewCell

- (IBAction)attention_click:(id)sender;

@property (nonatomic,strong)NSDictionary *info;

@property (weak, nonatomic) IBOutlet UIView *linView;


@property (weak, nonatomic) IBOutlet UIImageView *showimg;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;


@property (weak, nonatomic) IBOutlet UILabel *guanzhuLbl;

@property (weak, nonatomic) IBOutlet UILabel *tieziLbl;

@property (weak, nonatomic) IBOutlet UIButton *guanzhuBtn;

@property (weak, nonatomic) IBOutlet CYRoundLbl *brageNumLbl;

@property (nonatomic,copy)void (^guanzhuBlock)(NSDictionary *);

@end
