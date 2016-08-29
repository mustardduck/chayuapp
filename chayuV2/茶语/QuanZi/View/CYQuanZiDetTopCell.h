//
//  CYQuanZiDetTopCell.h
//  茶语
//
//  Created by Chayu on 16/7/6.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYQuanZiDetTopCell : UITableViewCell


@property (nonatomic,copy)void(^fatieBlock)();


- (IBAction)menu_click:(id)sender;


- (IBAction)fatie_click:(id)sender;

@property (nonatomic,copy)void (^ menuBlock)(NSInteger);

//- (IBAction)shenqingquanzhu_click:(id)sender;

@property (nonatomic,strong)NSDictionary *info;

@property (weak, nonatomic) IBOutlet UIButton *shenqingBtn;


@end
