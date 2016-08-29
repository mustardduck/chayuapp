//
//  CYToolBar.m
//  茶语
//
//  Created by Leen on 16/2/23.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYToolBar.h"

@implementation CYToolBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithArrar:(id)array block:(ToolBarSelBlock)block
{
    self = [super init];
    if (self) {
        [self setItems:array block:selBlock];
    }
    return self;

}

- (void)setItems:(NSArray*)array block:(ToolBarSelBlock)block
{
    if (block) {
        selBlock = block;
    }
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:self.bounds];
//    sv.backgroundColor = [UIColor redColor];
    
    CGFloat btnWidth = CGRectGetWidth(self.frame)/MIN(5, array.count);
    
    for (NSInteger i = 0;i < array.count;i++){
        NSDictionary *dict = [array objectAtIndex:i];
        UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(btnWidth*(i+1),0,1,sv.height)];
        linView.backgroundColor = [UIColor getColorWithHexString:@"eeeeee"];
        [sv addSubview:linView];
//        btnWidth +=btnWidth;
        UIButton *sortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sortBtn.frame = CGRectMake(i*btnWidth, 0, btnWidth, CGRectGetHeight(sv.frame));
        [sortBtn setTitle:[dict objectForKey:@"name"] forState:UIControlStateNormal];
        [sortBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [sortBtn setTitleColor:RGB(137, 62, 32) forState:UIControlStateSelected];
        sortBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        sortBtn.tag = 100+i;
        [sortBtn addTarget:self action:@selector(clickSort:) forControlEvents:UIControlEventTouchUpInside];
        
        [sv addSubview:sortBtn];
    }
    

    sv.contentSize = CGSizeMake(btnWidth*array.count,CGRectGetHeight(self.frame));
//    sv.scrollEnabled = (array.count>5);

    [self addSubview:sv];
    
    [self clickSort:[self viewWithTag:100]];
}

- (void)clickSort:(UIButton*)sender
{
    
    UIButton *btn = (UIButton *)sender;
    if (lastSelectedBtn == btn) {
        return;
    }
    lastSelectedBtn.selected = NO;
    btn.selected = YES;
    lastSelectedBtn = btn;
    
    if (selBlock) {
        selBlock(sender.tag - 100);
    }
    
//    NSDictionary *dict = [self.mToolsBtnNameList objectAtIndex:[sender tag] - 100];
//    NSString *sort = [dict objectForKey:@"sort"];
//    
//    if (_mType == EvaType_TeaReview) {
//        [self initListAction:@"tea" params:@{@"order":sort}];
//    }else
//    {
//        [self initListAction:@"sample" params:@{@"order":sort}];
//    }
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat xIndex = 0;
    [path moveToPoint:CGPointMake(xIndex, CGRectGetHeight(rect) - 1)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(rect) - xIndex, CGRectGetHeight(rect) - 1)];
    [[UIColor getColorWithHexString:@"eeeeee"] setStroke];
    [path stroke];
}
@end
