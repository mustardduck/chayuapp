//
//  CYHandmadeView.m
//  TeaMall
//
//  Created by Chayu on 15/10/21.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYHandmadeView.h"
#import "CYRoundLbl.h"
@interface CYHandmadeView ()

/**
 *  大师介绍
 */

/**
 *  好茶详情
 */
@property (weak, nonatomic) IBOutlet UIButton *goodteaBtn;

/**
 *  大师介绍文字
 */
@property (weak, nonatomic) IBOutlet UILabel *masinstrLable;

/**
 *  好茶数量
 */
@property (weak, nonatomic) IBOutlet CYRoundLbl *teasNumLbl;


- (IBAction)masterins_click:(id)sender;
- (IBAction)goodTeaDetails_click:(id)sender;


@end


@implementation CYHandmadeView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}
-(void)awakeFromNib
{
    [self viewLayer:_insbtn];
    [self viewLayer:_goodteaBtn];
}

-(void)viewLayer:(UIView *)view
{
    view.layer.borderColor = [UIColor grayColor].CGColor;
    view.layer.borderWidth = 0.5f;
    view.layer.cornerRadius = 3.0f;
}

- (void)setContentStr:(NSString *)contentStr
{
    _contentStr = contentStr;
    _masinstrLable.text = _contentStr;
}

- (void)setTeasnum:(NSString *)teasnum
{
    _teasnum = teasnum;
    if ([_teasnum integerValue] <= 0) {
        _teasNumLbl.hidden = YES;
    }else{
        _teasNumLbl.hidden = NO;
        _teasNumLbl.text = _teasnum;
    }
}



- (IBAction)masterins_click:(id)sender {
    if ([self.delegate respondsToSelector:@selector(masterIntroduced)]) {
        [self.delegate masterIntroduced];
    }
}

- (IBAction)goodTeaDetails_click:(id)sender {
    if ([self.delegate respondsToSelector:@selector(goodTeadetails)]) {
        [self.delegate goodTeadetails];
    }
}
@end
