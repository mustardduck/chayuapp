//
//  CYHomeChaPingCell.m
//  茶语
//
//  Created by Chayu on 16/6/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYHomeChaPingCell.h"

@interface CYHomeChaPingCell ()
{
    NSArray *cateList;
}

@property (weak, nonatomic) IBOutlet UIScrollView *contentScro;



@end

@implementation CYHomeChaPingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TeaCategory1" ofType:@"txt"];
    NSArray *list = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:kNilOptions error:nil];
    _contentScro.contentInset = UIEdgeInsetsMake(0, 20, 0, 0);
    [_contentScro layoutIfNeeded];
    cateList = [CYTeaCategoryInfo objectArrayWithKeyValuesArray:list];
    CGFloat itemWidth = (SCREEN_WIDTH-20)/4.5+4*(SCREEN_WIDTH/375.);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i =0; i<[cateList count]; i++) {
            CYChaPingView *view = [[[NSBundle mainBundle] loadNibNamed:@"CYChaPingView" owner:nil options:nil] firstObject];
            view.tag = 100+i;
            view.frame = CGRectMake(i*itemWidth,0, itemWidth, itemWidth);
            view.info = cateList[i];
            [_contentScro addSubview:view];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTea:)];
            [view addGestureRecognizer:tap];
        }
    });
  
    _contentScro.contentSize = CGSizeMake(itemWidth * cateList.count,0);
}

- (void)setCateArr:(NSArray *)cateArr
{
    _cateArr = cateArr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)selectTea:(UITapGestureRecognizer *)sender
{
    UIView *view = sender.view;
    if (self.gotosomeViewBlock) {
        self.gotosomeViewBlock(cateList[view.tag -100]);
    }
}

@end
