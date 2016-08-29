//
//  CYTeaReplyCell.h
//  茶语
//
//  Created by Chayu on 16/7/27.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYTeaReplyCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *huifuLbl;

@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *zanLbl;

@property (weak, nonatomic) IBOutlet UIButton *huifuBtn;

+ (CGFloat)calcCellHeight:(id)data;

- (void)parseData:(id)data;

@property (nonatomic,strong)NSDictionary *replyInfo;
@property (weak, nonatomic) IBOutlet UIButton *zanBtn;

@end
