//
//  CYTeaProcessCell.m
//  茶语
//
//  Created by 李峥 on 16/2/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTeaProcessCell.h"
#import "CYTeaProcessInfo.h"
#import "UILabel+Utilities.h"


static CYTeaProcessCell *__cell = nil;

@implementation CYTeaProcessCell

- (void)parseData:(id)data atIndex:(NSInteger)idx
{
    NSString *des = @"";
    NSString *name = @"";
    NSString *imgUrl = @"";
    if ([data isKindOfClass:[CYTeaProcessDetailInfo class]]) {
        CYTeaProcessDetailInfo *info = (CYTeaProcessDetailInfo *)data;
        if (idx == 0) {
            des = info.mDescription;
            name = @"干茶";
            imgUrl = info.filename;
        }else if (idx == 2)
        {
            _timeAndTemView.hidden = NO;
//            name = [NSString stringWithFormat:@"第%@泡",info.listorder];
            name = [NSString stringWithFormat:@"第%@泡",info.listorder];
//            _timeLbl.text = [NSString stringWithFormat:@"时  间：%@s       温  度：%@℃",info.brewtime,info.brewtemp];
//            _timeLbl.text = [NSString stringWithFormat:@"时  间：%@       温  度：%@",info.brewtime,info.brewtemp];
            _mTimeLbl.text = info.brewtime;
            _mTemLbl.text = info.brewtemp;
            des = [NSString stringWithFormat:@"%@",info.mDescription];
            imgUrl = info.filename;
        }else if (idx == 3)
        {
               _mtopColorView.backgroundColor = [UIColor whiteColor];
            name = @"叶底";
            des = info.mDescription;
            imgUrl = info.filename;
        }
        
    }else if ([data isKindOfClass:[CYTeaProcessPaoInfo class]])
    {
        CYTeaProcessPaoInfo *info = (CYTeaProcessPaoInfo *)data;

        if (idx == 1)
        {
            name = @"准备冲泡";
            des = [NSString stringWithFormat:@"茶样：%@\n茶具：%@\n用水：%@",info.sample,info.utensil,info.water];
            imgUrl =  info.thumb;
        }
    }
    
    if (idx == 0) {
        self.mTitleLabel.text = @"冲泡过程";
        self.mNameTopMargins.constant = 18;
    }else
    {
        self.mTitleLabel.text = @"";
        self.mNameTopMargins.constant = 0;
    }
    
    self.mNameLabel.text = name;
    
    if (idx ==2) {
        _mtopColorView.backgroundColor = [UIColor whiteColor];
        CYTeaProcessDetailInfo *info = (CYTeaProcessDetailInfo *)data;
//        [info.paorder isEqualToString:@"第1泡"]
        if ([info.listorder isEqualToString:@"1"]) {
            self.mNameLabel.text = @"冲泡";
            _timecenter_cons.constant +=30.;
            des = [NSString stringWithFormat:@"第%@泡\n\n%@",info.listorder,info.mDescription];
        }else{
            self.mNameLabel.textColor = CONTENTCOLOR;
            self.mNameLabel.font = FONT(14.);
        }
    }else{
//       self.mNameLabel.textColor = MAIN_COLOR;
    }
    
    self.mDesLabel.text = des;
    
    if (imgUrl.length > 0) {
        self.mImgHeight.constant = 222*(SCREEN_WIDTH/320.);
        self.mImgTopMargins.constant = 8;
        [_mImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"zwt_chaping"]];
        
    }else
    {
        self.mImgHeight.constant = 0;
        self.mImgTopMargins.constant = 0;
    }
    
}

+ (CGFloat)calcCellHeight:(id)data atIndex:(NSInteger)idx
{
    if (__cell == nil) {
        __cell = [[[NSBundle mainBundle] loadNibNamed:@"CYTeaProcessCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    [__cell parseData:data atIndex:idx];
    
    [__cell setNeedsUpdateConstraints];
    [__cell updateConstraintsIfNeeded];
    
    CGFloat height = [__cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    
    return height;
}


@end
