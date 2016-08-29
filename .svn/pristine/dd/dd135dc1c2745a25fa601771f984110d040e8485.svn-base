//
//  CYTeaReviewImgCell.m
//  茶语
//
//  Created by 李峥 on 16/2/19.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTeaReviewImgCell.h"
#import "CYTeaReviewInfo.h"
#import "UIImageView+WebCache.h"

@implementation CYTeaReviewImgCell

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x/scrollView.frame.size.width;
    NSLog(@"%ld",(long)page);
    
    self.mPageControl.currentPage = page;
}

//- (IBAction)seeFullClicked:(id)sender {
//    
//    if(self.seeFullScreenBlock)
//    {
//        self.seeFullScreenBlock(_mPageControl.currentPage);
//    }
//}


@end
