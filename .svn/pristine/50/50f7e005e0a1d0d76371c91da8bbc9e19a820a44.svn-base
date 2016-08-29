//
//  CYHomeFooterView.m
//  TeaMall
//
//  Created by Chayu on 15/10/21.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYHomeFooterView.h"
#define BGVIEW_WIDTH SCREEN_WIDTH/4
#define BUTTON_TAG  4000
@implementation CYHomeFooterView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}


-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
//        self.clipsToBounds = YES;
    }
    return self;
}


-(void)setTeasArr:(NSArray *)teasArr
{
    _teasArr = teasArr;
    [self creatUI:_teasArr];
}

-(void)creatUI:(NSArray *)teaArr
{
    for (int i =0; i<[teaArr count]; i++) {
        CYGoodsListModel *dict = teaArr[i];
        int sec = i/4;
        int row = i%4;
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(row*BGVIEW_WIDTH,sec*BGVIEW_HEIGHT,BGVIEW_WIDTH, BGVIEW_HEIGHT)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.clipsToBounds = YES;
        [self addSubview:bgView];
        
        //茶样图片
        UIImageView *showImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BGVIEW_WIDTH, BGVIEW_WIDTH)];
        showImg.clipsToBounds = YES;
        NSURL *imgUrl =[NSURL URLWithString:dict.thumb];
        
        [showImg sd_setImageWithURL:imgUrl placeholderImage:nil];
        [bgView addSubview:showImg];
        
        UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(0,BGVIEW_HEIGHT-30,BGVIEW_WIDTH,30)];
        nameLable.backgroundColor = CLEARCOLOR;
        nameLable.numberOfLines = 0;
        nameLable.font = [UIFont systemFontOfSize:9.];
        nameLable.textAlignment = NSTextAlignmentCenter;
        nameLable.textColor = [UIColor getColorWithRed:102 andGreen:102 andBlue:102];
        nameLable.text = dict.title;
        [bgView addSubview:nameLable];
        
        UIButton *clickbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        clickbtn.frame = bgView.bounds;
        clickbtn.tag = BUTTON_TAG +i;
        [clickbtn addTarget:self action:@selector(selectTheTea_click:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:clickbtn];
        UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
        topView.height = 0.5;
        topView.width = bgView.width;
        topView.backgroundColor = LINECOLOR;
        [bgView addSubview:topView];
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
        bottomView.y = bgView.height - 0.5;
        bottomView.height = 0.5;
        bottomView.width = bgView.width;
        bottomView.backgroundColor = LINECOLOR;
        [bgView addSubview:bottomView];
        
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectZero];
        rightView.x = bgView.width - 0.5;
        rightView.height = bgView.height;
        rightView.width = 0.5;
        rightView.backgroundColor = LINECOLOR;
        [bgView addSubview:rightView];
    }
}

-(void)selectTheTea_click:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(selectTheTea: andModel:)]) {
        [self.delegate selectTheTea:sender.tag - BUTTON_TAG andModel:_teasArr[sender.tag - BUTTON_TAG]];
    }
}


@end
