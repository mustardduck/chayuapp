//
//  CYBuyerMainHeaderView.m
//  茶语
//
//  Created by Leen on 16/7/21.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerMainHeaderView.h"

@interface CYBuyerMainHeaderView()

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation CYBuyerMainHeaderView

- (IBAction)selectTopMenu_click:(UIButton *)sender
{
    UIButton * selectBtn = (UIButton *)sender;
    
    if(selectBtn.tag < 103)
    {
        for (int i = 0; i < 3 ; i++) {
            UIButton *button = [_topView viewWithTag:i + 100];
            UIButton *titleButton = [_topView viewWithTag:i + 200];
            
            if (selectBtn.tag - 100 == i) {
                button.selected = YES;
                titleButton.selected = YES;
            }else{
                button.selected = NO;
                titleButton.selected = NO;
            }
        }
    }

    
    if(self.delegate && [self.delegate respondsToSelector:@selector(topMenuSelect:)])
    {
        [self.delegate topMenuSelect:selectBtn.tag];
    }
    
}

- (void)setTouUrl:(NSString *)touUrl
{
    [_imgView sd_setImageWithURL:[NSURL URLWithString:touUrl] placeholderImage:[UIImage imageNamed:@"750×400"]];
}


@end
