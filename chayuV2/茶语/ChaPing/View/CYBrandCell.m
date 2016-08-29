//
//  CYBrandCell.m
//  茶语
//
//  Created by 李峥 on 16/4/6.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBrandCell.h"
#import "CYScoreModel.h"
#import "CYHomeInfo.h"

@implementation CYBrandCell

- (void)parseData:(id)data
{
    if ([data isKindOfClass:[CYScoreModel class]])
    {
        CYScoreModel *model = data;
        
        self.mNumberLabel.text = model.top;
        self.mTitleLabel.text = [NSString stringWithFormat:@"[%@]%@",model.brand,model.title];
        
        if (model.review_score) {
            self.mScodeLabel.text = model.review_score;
        }else if (model.number)
        {
            self.mScodeLabel.text = model.number;
        }else if (model.user)
        {
            self.mScodeLabel.text = model.user;
        }else if (model.clicks)
        {
            self.mScodeLabel.text = model.clicks;
        }
        
    }else if ([data isKindOfClass:[CYScoreArticleInfo class]])
    {
        CYScoreArticleInfo *model = data;
        
        self.mNumberLabel.text = model.top;
        self.mTitleLabel.text = model.title;
        self.mScodeLabel.text = model.clicks;
    }else if ([data isKindOfClass:[CYScoreTopicInfo class]])
    {
        CYScoreTopicInfo *model = data;
        
        self.mNumberLabel.text = model.top;
        self.mTitleLabel.text = model.subject;
        self.mScodeLabel.text = model.hits;
    }else if ([data isKindOfClass:[CYScoreTBInfo class]])
    {
        CYScoreTBInfo *info = data;
        
        self.mNumberLabel.text = info.top;
        self.mTitleLabel.text = info.title;
        self.mScodeLabel.text = info.number;
    }
    
    self.contentView.backgroundColor = [UIColor redColor];
    
    NSInteger col = [self.mNumberLabel.text  integerValue];
    if (col % 2 == 1) {
        self.contentView.backgroundColor = [UIColor getColorWithHexString:@"F7F7F7"];
    }else
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    if (col <= 3) {
        self.mScodeLabel.textColor = [UIColor getColorWithHexString:@"893e20"];
    }else
    {
        self.mScodeLabel.textColor = LIGHTCOLOR;
    }
    
    self.mClickData = data;
}

@end
