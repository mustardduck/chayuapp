//
//  CYChaLiCell.h
//  茶语
//
//  Created by Chayu on 16/6/3.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseLable.h"

@protocol CYChaLiCellDelegate;

@interface CYChaLiCell : UITableViewCell

@property (nonatomic,strong)NSDictionary *info;

@property (weak, nonatomic) IBOutlet UIImageView *showimg;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet BaseLable *numLbl;

@property (weak, nonatomic) IBOutlet UILabel *chaliNumLbl;

@property (weak, nonatomic) IBOutlet UIView *numBg;

- (IBAction)less_click:(id)sender;

- (IBAction)add_click:(id)sender;

@property (nonatomic,assign)id<CYChaLiCellDelegate>delegate;

@end

@protocol CYChaLiCellDelegate  <NSObject>

- (void)changeTeaSamNum:(CYChaLiCell *)cell andCoinNum:(NSInteger)num;

@end