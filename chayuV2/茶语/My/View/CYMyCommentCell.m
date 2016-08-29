//
//  CYMyCommentCell.m
//  茶语
//
//  Created by Leen on 16/2/23.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYMyCommentCell.h"

@implementation CYMyCommentCell

- (void)awakeFromNib {
    // Initialization code
    _iv_avatar.layer.cornerRadius = CGRectGetWidth(_iv_avatar.frame)/2.f;
    _iv_avatar.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTeaModel:(CYMyTeaCommentModel *)teaModel;
{
    _teaModel = teaModel;
    

    
    _lb_time.text = [self dataWithSince:[_teaModel.created doubleValue]];
    _lb_content.text = _teaModel.content;
    _lb_title.text = [NSString stringWithFormat:@"[%@]   %@",_teaModel.bname,_teaModel.teaTitle];
//    _lb_count.text = [NSString stringWithFormat:@"赞 %@  评论 %@",_teaModel.favors,_teaModel.replies];
//    _bname.text = [NSString stringWithFormat:@"[%@]",_teaModel.bname];
    _zanLbl.text =_teaModel.teaFavorites;
    _commLbl.text = _teaModel.teaComments;
    _zanImg.highlighted = YES;
}


- (void)setArcModel:(CYMyArcCommentModel *)arcModel
{
    _arcModel = arcModel;
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
//    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[_teaModel.created doubleValue]];
//    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    _lb_time.text = [self dataWithSince:[_arcModel.created doubleValue]];
    _lb_content.text = _arcModel.content;
    _lb_title.text = _arcModel.arcTitle;
//    if (_arcModel.praises && !_arcModel.arcFavorites) {
//       _lb_count.text = [NSString stringWithFormat:@"赞 %@  回复%@",_arcModel.praises,_arcModel.replies];
//    }else{
//      _lb_count.text = [NSString stringWithFormat:@"赞 %@  评论%@",_arcModel.arcFavorites,_arcModel.arcComments];
//    }
//    
    _lb_title.text = [NSString stringWithFormat:@"[%@]   %@",_arcModel.arcCatName,_arcModel.arcTitle];
    
    _zanLbl.text =_arcModel.arcSuports;
    _commLbl.text = _arcModel.arcComments;
    _zanImg.highlighted = YES;
//     _bname.text = [NSString stringWithFormat:@"[%@]",_arcModel.arcCatName];
}
- (NSString *)dataWithSince:(NSTimeInterval )dataString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^{
    //        ];
    //    });
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dataString];
    NSLog(@"1296035591  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}



- (void)setThemeModel:(CYMyThemeCommentModel *)themeModel
{
    
    _themeModel = themeModel;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[_themeModel.created_time doubleValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    _lb_time.text = confromTimespStr;
    _lb_content.text = _themeModel.postContent;
    _lb_title.text = _themeModel.topicSubject;
//    _lb_count.text = [NSString stringWithFormat:@"赞 %@  评论%@",_themeModel.praises,_themeModel.replies];
    _zanLbl.text = _themeModel.praises;
    _commLbl.text = _themeModel.replies;
    _zanImg.highlighted = YES;
    
    if (_isGroup) {
        if (_themeModel.rpostCreatedNickname.length) {
               _lb_content.text = [NSString stringWithFormat:@"回复 %@：%@",_themeModel.rpostCreatedNickname,_themeModel.postContent];
        }else{
            
        }
    
    }
    
}
@end
