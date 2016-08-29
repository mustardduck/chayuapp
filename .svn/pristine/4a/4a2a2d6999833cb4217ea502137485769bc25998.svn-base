//
//  CYTopicReplyCell.m
//  茶语
//
//  Created by iXcoder on 16/2/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTopicReplyCell.h"

@interface CYTopicReplyCell ()
{
    
}

@property (nonatomic, weak) IBOutlet UIImageView *avatar;

@property (nonatomic, weak) IBOutlet UILabel *nameLbl;
@property (nonatomic, weak) IBOutlet UILabel *scoreLbl;
@property (nonatomic, weak) IBOutlet UILabel *textLbl;
@property (nonatomic, weak) IBOutlet UILabel *timeLbl;

@property (nonatomic, weak) IBOutlet UIButton *approveBtn;
@property (nonatomic, weak) IBOutlet UIButton *replyBtn;

@property (weak, nonatomic) IBOutlet UILabel *commLbl;

@property (weak, nonatomic) IBOutlet UILabel *zanLbl;

@property (weak, nonatomic) IBOutlet UIImageView *zanImg;


@end

@implementation CYTopicReplyCell

- (void)awakeFromNib {
    // Initialization code
    self.avatar.layer.cornerRadius = 15.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
 
    // Configure the view for the selected state
}

- (void)setItemInfo:(NSDictionary *)itemInfo
{
    [super setItemInfo:itemInfo];
    NSString *path = [itemInfo objectForKey:@"avatar"];
    if (path.length > 0) {
        [self.avatar sd_cancelCurrentImageLoad];
        [self.avatar sd_setImageWithURL:[NSURL URLWithString:path]];
    }
    
    self.nameLbl.text = [itemInfo objectForKey:@"nickname"];
    self.scoreLbl.text = [itemInfo objectForKey:@"score"];
    
    NSString *content = [itemInfo objectForKey:@"content"];
    NSString *rpostCreatedNickname = [itemInfo objectForKey:@"rpostCreatedNickname"];
    if (rpostCreatedNickname.length > 0) {
        NSString *prefix = [NSString stringWithFormat:@"@%@: ", rpostCreatedNickname];
        content = [prefix stringByAppendingString:content];
    }
    self.textLabel.attributedText = nil;
    self.textLbl.text = content;
    BOOL isSuported =[[itemInfo objectForKey:@"isSuported"] boolValue];
    _zanImg.highlighted = isSuported;
    _zanLbl.textColor = isSuported?MAIN_COLOR:CONTENTCOLOR;
    NSUInteger time = [[itemInfo objectForKey:@"created_time"] integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    self.timeLbl.text = [df stringFromDate:date];
    df = nil;
    NSString *approve = [NSString stringWithFormat:@"%@", itemInfo[@"praises"]];
    _zanLbl.text = approve;
    NSString *reply = [NSString stringWithFormat:@"%@", itemInfo[@"replies"]];
    _commLbl.text = reply;
}

+ (CGFloat)cellHeightWithInfo:(NSDictionary *)itemInfo
{
    NSString *content = [itemInfo objectForKey:@"content"];
    NSString *rpostCreatedNickname = [itemInfo objectForKey:@"rpostCreatedNickname"];
    if (rpostCreatedNickname.length > 0) {
        NSString *prefix = [NSString stringWithFormat:@"@%@: ", rpostCreatedNickname];
        content = [prefix stringByAppendingString:content];
    }
    
    CGFloat height = [content boundingRectWithSize:CGSizeMake(APP_FRAME_WIDTH - 52 - 14, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
    return 115 + height - 17.f;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.avatar.image = nil;
    
}

- (IBAction)onPraiseAction:(id)sender
{
    if (!self.praiseCallback) {
        return ;
    }
    self.praiseCallback(self.itemInfo);
}

- (IBAction)onReplyAction:(id)sender
{
    if (!self.replyCallback) {
        return ;
    }
    self.replyCallback(self.itemInfo);
}

@end
