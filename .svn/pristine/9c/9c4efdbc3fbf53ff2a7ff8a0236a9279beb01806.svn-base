//
//  CYSearchHuaTiCell.m
//  茶语
//
//  Created by Chayu on 16/3/5.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYSearchHuaTiCell.h"

@interface CYSearchHuaTiCell ()


@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *replyNum;

@end

@implementation CYSearchHuaTiCell

- (void)awakeFromNib {
    // Initialization code
}

+(instancetype)cellWidthTableView:(UITableView*)tableView
{
    static NSString *refundIndentify = @"CYSearchHuaTiCell";
    CYSearchHuaTiCell *cell = [tableView dequeueReusableCellWithIdentifier:refundIndentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYSearchHuaTiCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setInfo:(NSDictionary *)info{
    _info = info;
    _titleLbl.text = [info objectForKey:@"subject"];
    _timeLbl.text = [NSString stringWithFormat:@"回复：%@",[info objectForKey:@"replies"]];;
    _replyNum.text = [self dataWithSince:[[info objectForKey:@"created_time"] doubleValue]];;
}


- (NSString *)dataWithSince:(NSTimeInterval )dataString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^{
    //        ];
    //    });
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dataString];
    NSLog(@"1296035591  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}

@end
