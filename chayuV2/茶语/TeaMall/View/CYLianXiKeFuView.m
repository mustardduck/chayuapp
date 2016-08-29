//
//  CYLinXiKeFuView.m
//  茶语
//
//  Created by Chayu on 16/7/6.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYLianXiKeFuView.h"

@interface CYLianXiKeFuView ()


@property (weak, nonatomic) IBOutlet UILabel *calnumLbl;

- (IBAction)cancel_click:(id)sender;

- (IBAction)bodadianhua_click:(id)sender;

@end

@implementation CYLianXiKeFuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setCalnum:(NSString *)calnum
{
    _calnum = calnum;
    if (_calnum.length) {
       _calnumLbl.text = [NSString stringWithFormat:@"拨打客服电话 %@",_calnum];
    }
   

}

- (IBAction)cancel_click:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)bodadianhua_click:(id)sender {
    
    [self removeFromSuperview];
    if (_calnum.length) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel://%@",_calnum];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }

    
}
@end
