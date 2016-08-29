//
//  CYSearchReMenFooter.m
//  茶语
//
//  Created by Chayu on 16/7/5.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYSearchReMenFooter.h"
#import "NSString+Additions.h"
@interface CYSearchReMenFooter ()
{
  
    
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;

- (IBAction)huanyipi_click:(id)sender;

@end


@implementation CYSearchReMenFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)lodbiaoqian:(NSArray *)arr{
    for (int i=0; i<arr.count; i++)
    {
        NSDictionary *info = arr[i];
        NSString *name=info[@"keyword"];
        static UIButton *beforeBtn=nil;
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor=[UIColor clearColor];
        [button setTitleColor:[UIColor getColorWithHexString:@"333333"] forState:UIControlStateNormal];
        button.titleLabel.font = FONT(14.0);
         button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        CGRect rect=[name boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-40, 32) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:button.titleLabel.font} context:nil];
        if (i==0)
        {
            button.frame=CGRectMake(20,10, rect.size.width+15, rect.size.height+15);
        }
        else
        {
            CGFloat leaveWidth=SCREEN_WIDTH-beforeBtn.frame.size.width-beforeBtn.frame.origin.x-20;
            if (leaveWidth>=rect.size.width)
            {
                button.frame=CGRectMake(CGRectGetMaxX(beforeBtn.frame)+10, beforeBtn.frame.origin.y, rect.size.width+15, rect.size.height+15);
            }
            else
            {
                
                button.frame=CGRectMake(20, CGRectGetMaxY(beforeBtn.frame)+10, rect.size.width+15, rect.size.height+15);
            }
            
        }
        button.tag=i;
        button.layer.cornerRadius=3;
        button.layer.borderColor = [UIColor getColorWithHexString:@"bbbbbb"].CGColor;
        button.layer.borderWidth = 1.0f;
        button.clipsToBounds=YES;
        [button setTitle:name forState:UIControlStateNormal];
        beforeBtn=button;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollerView addSubview:button];
    }
}

- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    for (UIView *view in _scrollerView.subviews) {
        [view removeFromSuperview];
    }
    
    [self lodbiaoqian:_dataArr];
 
}

-(void)btnClick:(UIButton *)sender
{
    
    NSDictionary *info = _dataArr[sender.tag];
    if (self.block)
    {
        self.block(sender,info[@"keyword"]);
    }
}

-(void)awakeFromNib
{
    [super awakeFromNib];

}

- (IBAction)huanyipi_click:(id)sender {
    if (self.huanyipiBlock) {
        self.huanyipiBlock();
    }
    
}





@end
