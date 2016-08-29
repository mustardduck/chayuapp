//
//  CYYinDaoView.m
//  茶语
//
//  Created by taotao on 16/8/6.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYYinDaoView.h"

@interface CYYinDaoView ()
{
    NSInteger page;
}
@property (weak, nonatomic) IBOutlet UIButton *zhidaoBtn;


@end

@implementation CYYinDaoView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)awakeFromNib
{
    [super awakeFromNib];
    page = 1;
    _zhidaoBtn.showsTouchWhenHighlighted = NO;
    _imgview.userInteractionEnabled = YES;
    UITapGestureRecognizer *sender = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(next_click)];
    [_imgview addGestureRecognizer:sender];
    
    
}

- (IBAction)wozhidaole_click:(id)sender {
    //
    [self next_click];
}

-(void)next_click
{
    page ++;
    if (page <5) {
        NSString *imgname = [NSString stringWithFormat:@"home_0%d",(int)page];
        if (page ==4) {
            [_zhidaoBtn setImage:[UIImage imageNamed:@"daohang_lijishiyong_ico"] forState:UIControlStateNormal];
        }
        _imgview.image = [UIImage imageNamed:imgname];
    }else{
        [self removeFromSuperview];
    }
    
    
}
@end
