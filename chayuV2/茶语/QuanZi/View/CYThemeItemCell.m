//
//  CYThemeItemCell.m
//  茶语
//
//  Created by iXcoder on 16/2/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#ifndef APP_FRAME_WIDTH
#define APP_FRAME_WIDTH [UIScreen mainScreen].applicationFrame.size.width
#endif

#import "CYThemeItemCell.h"
@interface CYThemeItemCell ()

@property (nonatomic, weak) IBOutlet UIImageView *avatar;
@property (nonatomic, weak) IBOutlet UILabel *nameLbl;
@property (nonatomic, weak) IBOutlet UILabel *timeLbl;
@property (nonatomic, weak) IBOutlet UILabel *titleLbl;
@property (nonatomic, weak) IBOutlet UILabel *ctntLbl;

@property (nonatomic, weak) IBOutlet UIImageView *img0View;
@property (nonatomic, weak) IBOutlet UIImageView *img1View;
@property (nonatomic, weak) IBOutlet UIImageView *img2View;

@end

@implementation CYThemeItemCell

- (void)awakeFromNib {
    // Initialization code
    
    self.avatar.layer.cornerRadius = 15.f;
    self.avatar.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItemInfo:(id)itemInfo
{
    [super setItemInfo:itemInfo];
    
    NSString *avatar = [itemInfo objectForKey:@"avatar"];
    [self.avatar sd_cancelCurrentImageLoad];
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:[UIImage imageNamed:@"bbs_img_load_dft"]];
    
    self.nameLbl.text = [itemInfo objectForKey:@"nickname"];
    NSUInteger time = [[itemInfo objectForKey:@"created_time"] integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    self.timeLbl.text = [df stringFromDate:date];
    df = nil;
    
    NSString *title = [itemInfo objectForKey:@"subject"];
    self.titleLbl.text = title;
    
    self.ctntLbl.text = [itemInfo objectForKey:@"content"];
    
    NSArray *attaches = [itemInfo objectForKey:@"attach"];
    if ([attaches isKindOfClass:[NSString class]]) {
        NSString *str = [(NSString *)attaches stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (str.length > 0) {
            attaches = [str componentsSeparatedByString:@","];
        } else {
            attaches = @[];
        }
    }
    for (int i = 0; i < 3; i++) {
        NSString *imgKey = [NSString stringWithFormat:@"img%dView", i];
        UIImageView *imgView = [self valueForKeyPath:imgKey];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        BOOL hidden = i >= attaches.count;
        imgView.hidden = hidden;
        if (hidden) {
            continue;
        }
        [imgView sd_cancelCurrentImageLoad];
        NSString *path = [attaches objectAtIndex:i];
        [imgView sd_setImageWithURL:[NSURL URLWithString:path] placeholderImage:SQUARE];
    }
}

+ (CGFloat)cellHeightWithInfo:(id)info
{
    CGFloat height = 0.f;
    height += 14.f;
    height += 30.f;
    height += 14.f;
    height += 19.f;
    
    NSString *ctnt = [info objectForKey:@"content"];
    CGFloat ctntHeight = [ctnt boundingRectWithSize:CGSizeMake(APP_FRAME_WIDTH - 14 * 2, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
    height += ctntHeight;
    height += 14.f;
    NSArray *attaches = [info objectForKey:@"attach"];
    if ([attaches isKindOfClass:[NSString class]]) {
        NSString *str = [(NSString *)attaches stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (str.length > 0) {
            attaches = [str componentsSeparatedByString:@","];
        } else {
            attaches = @[];
        }
    }
    if (attaches &&  attaches.count > 0) {
        height += (APP_FRAME_WIDTH - 14. * 2 - 5. * 2) / 3.;
        height += 14.f;
    }
    
    return height + 13;
}

- (void)isSelf:(BOOL)isSelf
{
    ChaYuer *user = MANAGER;
    self.nameLbl.text = user.nickname;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:[UIImage imageNamed:@"bbs_img_load_dft"]];
}

@end
