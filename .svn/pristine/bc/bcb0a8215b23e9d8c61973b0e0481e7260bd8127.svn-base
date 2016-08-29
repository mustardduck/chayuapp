//
//  CYTopMenuView.m
//  茶语
//
//  Created by Chayu on 16/7/5.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTopMenuView.h"

@interface CYTopMenuView ()
{
    UIButton *selectBtn;
}


@end



@implementation CYTopMenuView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *lineview = [[UIView alloc] initWithFrame:CGRectMake(0,self.height-1, SCREEN_WIDTH, 1)];
        lineview.backgroundColor = [UIColor getColorWithHexString:@"eeeeee"];
        [self addSubview:lineview];
    }
    return self;
}

- (void)setSelectTitle:(NSString *)selectTitle{
    _selectTitle = selectTitle;
    [selectBtn setTitle:_selectTitle forState:UIControlStateNormal];
    selectBtn.selected = NO;
}

- (void)setSelectIndexButtonTag:(NSInteger)selectIndexButtonTag
{
    _selectIndexButtonTag = selectIndexButtonTag;
    selectBtn.selected = NO;

}

//weakSelf.orderView.hidden = YES;
-(void)initwithMen:(NSArray *)menuArr
{
    
    CGFloat btnWidth = SCREEN_WIDTH/[menuArr count];
    for (NSInteger i = 0;i < menuArr.count;i++){
        NSDictionary *dict = [menuArr objectAtIndex:i];
        CYTopMenuBtn *sortBtn = [CYTopMenuBtn buttonWithType:UIButtonTypeCustom];
        sortBtn.frame = CGRectMake(i*btnWidth, 0, btnWidth , CGRectGetHeight(self.frame));
        [sortBtn setTitle:[dict objectForKey:@"name"] forState:UIControlStateNormal];
        sortBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        sortBtn.tag = 100+i;
        [sortBtn setTitleColor:TITLECOLOR forState:UIControlStateNormal];
        [sortBtn setTitleColor:[UIColor getColorWithHexString:@"333333"] forState:UIControlStateSelected];
        [sortBtn setImage:[UIImage imageNamed:@"chaping_down_row"] forState:UIControlStateNormal];
        [sortBtn setImage:[UIImage imageNamed:@"chaping_up_row"] forState:UIControlStateSelected];
        [sortBtn addTarget:self action:@selector(clickSort:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sortBtn];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(sortBtn.x + sortBtn.width,10,1,self.height - 20)];
        line.backgroundColor = [UIColor getColorWithHexString:@"eeeeee"];
        [self addSubview:line];
        
        if ([menuArr count]==2 && i == [menuArr count]-1 ) {
            [line removeFromSuperview];
        }
        
    }

}


-(void)clickSort:(UIButton *)sender
{
 
    if (self.buttonSelectIndex) {
        self.buttonSelectIndex(sender.tag - 100);
    }
    sender.selected = !sender.selected;
    if (sender.tag == selectBtn.tag) {
        return;
    }
    selectBtn.selected = NO;
    selectBtn = sender;

}


@end

@implementation CYTopMenuBtn


-(void)drawRect:(CGRect)rect
{
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    // Center image
    CGRect imgFrame = self.imageView.frame;
    imgFrame.origin.y = self.frame.size.height/2 - imgFrame.size.height/2;
    
    //Center text
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.y = self.frame.size.height/2 - newFrame.size.height/2;
    
    newFrame.origin.x = (self.frame.size.width - imgFrame.size.width - newFrame.size.width - 2)/2;
    
    imgFrame.origin.x = CGRectGetMaxX(newFrame) + 2;
    
    self.imageView.frame = imgFrame;
    self.titleLabel.frame = newFrame;
    
}

@end







