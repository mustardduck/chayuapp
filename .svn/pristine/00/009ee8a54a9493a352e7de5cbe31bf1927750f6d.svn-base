//
//  CYChaPingTopCell.h
//  茶语
//
//  Created by Chayu on 16/6/29.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYChaPingTopCellDelegate <NSObject>

-(void)topSelect:(NSInteger)selecIndex;

@end

@interface CYChaPingTopCell : UITableViewCell


@property (nonatomic,assign)id<CYChaPingTopCellDelegate>delegate;

- (IBAction)topbtn_click:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *contentBgView;


@end
