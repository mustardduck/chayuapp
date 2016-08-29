//
//  CYPingJiaTableViewCell.h
//  茶语
//
//  Created by Chayu on 16/8/1.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceholderTextView.h"
#import "LDXScore.h"
#import "CYShopTrolleyModel.h"
#import "NTAlbum.h"
@interface CYPingJiaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *showimg;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet UILabel *guigeLbl;

@property (weak, nonatomic) IBOutlet UILabel *priceLbl;

@property (weak, nonatomic) IBOutlet PlaceholderTextView *evaTxt;
@property (weak, nonatomic) IBOutlet LDXScore *starView;


@property (weak, nonatomic) IBOutlet UIView *evaBg;



@property (nonatomic,strong)CYShopTrolleyModel *model;

@end
