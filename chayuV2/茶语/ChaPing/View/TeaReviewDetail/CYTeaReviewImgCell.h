//
//  CYTeaReviewImgCell.h
//  茶语
//
//  Created by 李峥 on 16/2/19.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "BaseCell.h"

@interface CYTeaReviewImgCell : BaseCell<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;
@property (weak, nonatomic) IBOutlet UILabel *mTitleLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *mPageControl;

//@property (nonatomic, copy) void (^seeFullScreenBlock)(NSInteger);

@end
