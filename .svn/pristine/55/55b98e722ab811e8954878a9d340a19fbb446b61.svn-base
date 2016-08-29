//
//  CYWenZhangCommentCell.m
//  茶语
//
//  Created by Leen on 16/7/30.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYWenZhangCommentCell.h"
#import "CYWenZhangCommentView.h"

@interface CYWenZhangCommentCell()<CYWenZhangCommentViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (nonatomic, strong) CYWenZhangCommentView * commentView;

@end

@implementation CYWenZhangCommentCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self addSubview:self.commentView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setWenzhangId:(NSString *)wenzhangId
{
    _wenzhangId = wenzhangId;
    
    _commentView.itemid = _wenzhangId;
}

- (void)showAllEvaluation
{
    if ([self.delegate respondsToSelector:@selector(showAllEvaluation)]) {
        [self.delegate showAllEvaluation];
    }
}

- (IBAction)huifu_click
{
    if ([self.delegate respondsToSelector:@selector(huifu_click)]) {
        [self.delegate huifu_click];
    }
}

- (void)commentBtnClicked:(CYWenZhangCommentModel *)model
{
    if ([self.delegate respondsToSelector:@selector(commentBtnClicked:)]) {
        [self.delegate commentBtnClicked:model];
    }
}

- (CYWenZhangCommentView *) commentView
{
    if(!_commentView)
    {
        _commentView = [[[NSBundle mainBundle] loadNibNamed:@"CYWenZhangCommentView" owner:nil options:nil] firstObject];
        _commentView.delegate = self;
        _commentView.frame = CGRectMake(0, 50, SCREEN_WIDTH, 1);
        _commentView.pageSize = 10;
        _commentView.itemid = _wenzhangId;
    }
    
    return _commentView;
}

#pragma mark -
#pragma mark CYBuyerEvaluationViewDelegate method
- (void)evaluationViewendHeight:(CGFloat)endheight commentCount:(NSInteger)count
{
    self.height = endheight + 50;
    
    if(self.reloadBlock)
    {
        self.reloadBlock(self.height);
    }
    
    if(count)
    {
        _titleLbl.text = [NSString stringWithFormat:@"评论(%ld)", count];
    }
}

@end

