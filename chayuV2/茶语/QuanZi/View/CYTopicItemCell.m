//
//  CYTopicItemCell.m
//  茶语
//
//  Created by iXcoder on 16/2/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTopicItemCell.h"

@interface CYTopicItemCell ()

@property (nonatomic, weak) IBOutlet UIImageView *topicImg;
@property (nonatomic, weak) IBOutlet UILabel *titleLbl;
@property (nonatomic, weak) IBOutlet UIButton *attenBtn;
@property (nonatomic, weak) IBOutlet UILabel *attentionsLbl;
@property (nonatomic, weak) IBOutlet UILabel *themesLbl;
@property (nonatomic, weak) IBOutlet UILabel *descLbl;

- (IBAction)onMakeAttentionAction:(id)sender;

@end


@implementation CYTopicItemCell

- (void)awakeFromNib {
    // Initialization code
    self.attenBtn.layer.cornerRadius = CGRectGetHeight(self.attenBtn.frame) / 2.;
    self.attenBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItemInfo:(NSDictionary *)itemInfo
{
    [super setItemInfo:itemInfo];
    NSString *logoPath = [itemInfo objectForKey:@"logo"];
    [self.topicImg sd_setImageWithURL:[NSURL URLWithString:logoPath] placeholderImage:SQUARE];
    
    self.titleLbl.text = [itemInfo objectForKey:@"name"];
    
    self.attentionsLbl.text = [NSString stringWithFormat:@"%@",[itemInfo objectForKey:@"attentionnum"]];
    self.themesLbl.text = [NSString stringWithFormat:@"%@",[itemInfo objectForKey:@"topics"]];
    
    self.descLbl.text = [itemInfo objectForKey:@"descrip"];
    
    BOOL attentioned = [[itemInfo objectForKey:@"isattention"] boolValue];
    self.attenBtn.selected = attentioned;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}

+ (CGFloat)cellHeightWithInfo:(NSDictionary *)itemInfo
{
    return 44.f;
}

#pragma mark - self defined method
- (IBAction)onMakeAttentionAction:(id)sender
{
    if (!self.needAttention) {
        return;
    }
    self.needAttention(self.itemInfo);
}


@end
