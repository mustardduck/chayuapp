//
//  CYMyChaPingCell.h
//  茶语
//
//  Created by Chayu on 16/7/11.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYMyChaPingCell : UITableViewCell

- (IBAction)menu_click:(id)sender;
@property(nonatomic,copy)void (^menuclickBlock)(NSInteger);


@end
