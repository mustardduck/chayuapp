//
//  CYHuaTiDetLikeCell.m
//  茶语
//
//  Created by Chayu on 16/7/7.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYHuaTiDetLikeCell.h"

@interface CYHuaTiDetLikeCell ()
{
    
}

@property (weak, nonatomic) IBOutlet UIView *likeListView;


@end

@implementation CYHuaTiDetLikeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setLikeArr:(NSArray *)likeArr
{
    for(UIView * view in [_likeListView subviews])
    {
        [view removeFromSuperview];
    }
    
    _likeArr = likeArr;
    for (int i = 0; i<[_likeArr count]; i++) {
        NSDictionary *info = _likeArr[i];
        UILabel *button = [[UILabel alloc] initWithFrame:CGRectMake(20,i*35,SCREEN_WIDTH-40,35)];
//        button.frame = CGRectMake(20,i*35,SCREEN_WIDTH-40,35);
        NSString *title = [NSString stringWithFormat:@"· %@",[info objectForKey:@"subject"]];
        button.text = title;
        button.font = FONT(14.0);
        button.textAlignment = NSTextAlignmentLeft;
        button.textColor = [UIColor getColorWithHexString:@"333333"];
        button.tag = 5000+i;
        button.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selcthuati:)];
        [button addGestureRecognizer:tap];
        tap = nil;
        [_likeListView addSubview:button];
    }
}


-(void)selcthuati:(UITapGestureRecognizer *)sender
{
    UILabel *lable = (UILabel *)sender.view;
    NSInteger selectIndex = lable.tag - 5000;
    if (self.selecthuatiBlock) {
        NSDictionary *info = _likeArr[selectIndex];
        self.selecthuatiBlock([info objectForKey:@"tid"]);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}




@end
