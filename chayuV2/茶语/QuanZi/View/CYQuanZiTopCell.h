//
//  CYQuanZiTopCell.h
//  茶语
//
//  Created by taotao on 16/7/2.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYQuanZiTopCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *topImg;


@property (nonatomic,copy)void (^ menuclickBlock)(NSInteger select);

- (IBAction)menu_click:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *qiandaoBtn;

@end
