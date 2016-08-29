//
//  CYCollectTopicCell.m
//  茶语
//
//  Created by Leen on 16/6/1.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYCollectTopicCell.h"
#import "CYHomeInfo.h"

@implementation CYCollectTopicCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)parseData:(id)data
{
    CYHomeTopicInfo *info = [CYHomeTopicInfo objectWithKeyValues:data];
    
    if (info.thumb.length >0) {
        [self.avatar sd_setImageWithURL:[NSURL URLWithString:info.thumb] placeholderImage:SQUARE];
    }


    self.titleLbl.text = info.subject;
    self.contentLbl.text = info.desc;
    _liulanLbl.text = info.hits;
    _pinglunLbl.text = info.replies;
    
    self.mClickData = info;
    
}

+ (instancetype)cellWidthTableView:(UITableView *)tableView
{
    static NSString *cellName = @"CYCollectTopicCell";
    CYCollectTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYCollectTopicCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (IBAction)selectBtnClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(selectCollectTopicCell:)]) {
        [self.delegate selectCollectTopicCell:self];
    }
}

@end
