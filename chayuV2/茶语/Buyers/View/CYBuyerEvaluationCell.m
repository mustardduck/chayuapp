//
//  CYBuyerEvaluationCell.m
//  茶语
//
//  Created by Leen on 16/7/21.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerEvaluationCell.h"
#import "LDXScore.h"
#import "PYMultiLabel.h"
#import "UIColor+Additions.h"
#import "UICommon.h"

static const CGFloat LINE_PADDING = 7.0;
static const CGFloat LABLE_TOP_PADDING = 12.0;
static const CGFloat LABLE_FONTSIZE = 14.0;

@interface CYBuyerEvaluationCell ()

@property (weak, nonatomic) IBOutlet LDXScore *starView;

@property (strong,nonatomic)PYMultiLabel *contentLable;
@property (weak, nonatomic) IBOutlet UIImageView *showImg;

@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;
@property (strong, nonatomic) UILabel *standLbl;

/**
 *  买家第一次评价
 */
@property (nonatomic,strong)UIView *userView;


/**
 *  追加评价
 */
@property (nonatomic,strong)UIView *zjView;


//卖家回复相关
@property (strong,nonatomic) UIView *adminreview;

//卖家回复追评
@property (strong,nonatomic) UIView *secadminreview;

@end

@implementation CYBuyerEvaluationCell

- (void)awakeFromNib {
    _starView.show_star = 3;
    
    
    [self.contentView addSubview:self.userView];
    [self.contentView addSubview:self.standLbl];
    
    
}

-(PYMultiLabel *)contentLable
{
    if (!_contentLable) {
        _contentLable = [[PYMultiLabel alloc] init];
        _contentLable.frame = CGRectMake(0,0,_userView.width,20);
        _contentLable.backgroundColor = CLEARCOLOR;
        _contentLable.font = FONT(LABLE_FONTSIZE);
        _contentLable.numberOfLines = 0;
        _contentLable.textColor = TITLECOLOR;
        
    }
    return _contentLable;
}


- (UIView *)adminreview
{
    if (!_adminreview) {
        _adminreview = [[UIView alloc] initWithFrame:CGRectMake(20,self.userView.height + self.userView.y +10, SCREEN_WIDTH-40,1)];
        _adminreview.clipsToBounds = YES;
        _adminreview.backgroundColor = MAIN_BGCOLOR;
        [UICommon setViewCornerRadius:_adminreview cornerRadius:2.0 borderColor:[UIColor grayTitleOrLineColor]];
        
        PYMultiLabel *replycommLbl = [[PYMultiLabel alloc] initWithFrame:CGRectMake(10,5,_adminreview.width -20,_adminreview.height -10)];
        replycommLbl.tag = 3000;
        replycommLbl.textColor = CONTENTCOLOR;
        replycommLbl.font = FONT(LABLE_FONTSIZE);
        replycommLbl.numberOfLines = 0;
        [_adminreview addSubview:replycommLbl];
        _adminreview.layer.cornerRadius = 3.0f;
    }
    return _adminreview;
}

- (UIView *)secadminreview
{
    if (!_secadminreview) {
        _secadminreview = [[UIView alloc] initWithFrame:CGRectMake(20,self.zjView.height + self.zjView.y +10, SCREEN_WIDTH-40,1)];
        _secadminreview.clipsToBounds = YES;
        _secadminreview.backgroundColor = MAIN_BGCOLOR;
        [UICommon setViewCornerRadius:_secadminreview cornerRadius:2.0 borderColor:[UIColor grayTitleOrLineColor]];

        PYMultiLabel *replycommLbl = [[PYMultiLabel alloc] initWithFrame:CGRectMake(10,5,_secadminreview.width -20,_secadminreview.height -10)];
        replycommLbl.tag = 6000;
        replycommLbl.textColor = CONTENTCOLOR;
        replycommLbl.font = FONT(LABLE_FONTSIZE);
        replycommLbl.numberOfLines = 0;
        [_secadminreview addSubview:replycommLbl];
        _secadminreview.layer.cornerRadius = 3.0f;
    }
    return _secadminreview;
}

- (UIView *)userView
{
    if (!_userView) {
        _userView= [[UIView alloc] initWithFrame:CGRectMake(20,70,SCREEN_WIDTH-40, 40)];
        _userView.backgroundColor = CLEARCOLOR;
        [_userView addSubview:self.contentLable];
        UILabel *timeLbl = [[UILabel alloc] initWithFrame:CGRectMake(0,_userView.height -15,SCREEN_WIDTH, 15)];
        timeLbl.font = FONT(12.f);
        timeLbl.textColor = LIGHTCOLOR;
        timeLbl.tag = 2000;
        [_userView addSubview:timeLbl];
        
    }
    return _userView;
}


- (UIView *)zjView
{
    if (!_zjView) {
        _zjView = [[UIView alloc] initWithFrame:CGRectMake(20,self.adminreview.height + self.adminreview.y +10, SCREEN_WIDTH-40,1)];
        PYMultiLabel *appendReplyLbl = [[PYMultiLabel alloc] initWithFrame:CGRectMake(0,0,_zjView.width, 1)];
        appendReplyLbl.textColor = CONTENTCOLOR;
        appendReplyLbl.numberOfLines = 0;
        appendReplyLbl.font = FONT(LABLE_FONTSIZE);
        appendReplyLbl.tag = 4000;
        [_zjView addSubview:appendReplyLbl];
        UILabel *appendTimeLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, _zjView.height -15, _zjView.width, 15)];
        appendTimeLbl.tag = 5000;
        appendTimeLbl.textColor = LIGHTCOLOR;
        appendTimeLbl.font = FONT(12.);
        [_zjView addSubview:appendTimeLbl];
    }
    return _zjView;
}
- (UILabel *)standLbl
{
    if (!_standLbl) {
        _standLbl = [[UILabel alloc] initWithFrame:CGRectMake(20,self.contentView.height - 25, SCREEN_WIDTH-20, 15)];
        _standLbl.textColor = LIGHTCOLOR;
        _standLbl.font = FONT(12.0f);
    }
    return _standLbl;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setEvaModel:(CYEvaluationModel *)evaModel
{
    _evaModel = evaModel;
    _starView.show_star = [_evaModel.score integerValue]/2;
    NSDictionary *user = _evaModel.user;
    _userNameLbl.text = [user objectForJSONKey:@"nickname"];
    NSString *avatar = [user objectForJSONKey:@"avatar"];
    if (avatar) {
        NSURL *url = [NSURL URLWithString:avatar];
        [_showImg sd_setImageWithURL:url placeholderImage:DEFAULTHEADER];
    }
    [self.zjView removeFromSuperview];
    [self.adminreview removeFromSuperview];
    [self.secadminreview removeFromSuperview];
    
    UIView * imgViewTag = [self viewWithTag:10000];
    if(imgViewTag)
    {
        [imgViewTag removeFromSuperview];
    }
    
    CGFloat offect_y = 0.0f;
    //买家评价
    NSString *userComm = [NSString stringWithFormat:@"[买家评价]：%@",_evaModel.content];
    CGFloat labHeight = [self lableHeightWithString:userComm Size:CGSizeMake(_contentLable.width,MAXFLOAT) fontSize:LABLE_FONTSIZE];
    
    [UICommon setLabelPadding:_contentLable text:userComm padding:LINE_PADDING];
    NSInteger numberOfLines = labHeight / LABLE_FONTSIZE;
    self.contentLable.height = labHeight + LINE_PADDING * (numberOfLines - 1);
    
    [_contentLable setFontColor:[UIColor brownTitleColor] range:NSMakeRange(0, 7)];
    
    
    CGFloat imgWidth = (SCREEN_WIDTH - 40 - 5 * 4 ) / 5;
    //首次评价图片(最多5张 一行显示完）
    if(_evaModel.attach.count)
    {
        UIView * imgView = [[UIView alloc] initWithFrame:CGRectMake(20, _contentLable.y + _contentLable.height + 10, SCREEN_WIDTH - 40, imgWidth)];
        imgView.tag = 10000;
        
        for(int i = 0 ; i < _evaModel.attach.count; i ++ )
        {
            NSString * url = _evaModel.attach[i];
            
            UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake((imgWidth + 5) * i, 0, imgWidth, imgWidth)];
            
            [img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:SQUARE];
            
            [imgView addSubview:img];
        }
        
        [self.contentView addSubview:imgView];
    }
    
    //首次评价时间
    UILabel *usertimeLbl = (UILabel *)[_userView viewWithTag:2000];
    usertimeLbl.text = _evaModel.created;
    usertimeLbl.y = self.contentLable.y+self.contentLable.height +10;
    if(_evaModel.attach.count)
    {//首次评价图片(最多5张 一行显示完）
        usertimeLbl.y = self.contentLable.y+self.contentLable.height +10 + imgWidth + 10;
    }
    self.userView.height = self.contentLable.y+self.contentLable.height +37;
    
    //买家评论相关加载完成 后的偏移量
    offect_y = self.userView.y +self.userView.height;
    
    //卖家回复
    if ([_evaModel.adminreview allKeys].count) {
        self.adminreview.y = offect_y;
        [self.contentView addSubview:self.adminreview];
        NSDictionary *adminreviewDic = _evaModel.adminreview;
        NSString *adminStr =[NSString stringWithFormat:@"[卖家回复]：%@",adminreviewDic[@"content"]];
        PYMultiLabel *adminreLbl = (PYMultiLabel *)[self.adminreview viewWithTag:3000];
        adminreLbl.y = 0;
        
        CGFloat adminlabHeight = [self lableHeightWithString:adminStr Size:CGSizeMake(adminreLbl.width,MAXFLOAT) fontSize:LABLE_FONTSIZE];

        
        //设置行间距和内容
        [UICommon setLabelPadding:adminreLbl text:adminStr padding:LINE_PADDING];
        NSInteger numberOfLines = adminlabHeight / LABLE_FONTSIZE;
        adminreLbl.height = adminlabHeight + LABLE_TOP_PADDING * 2 + LINE_PADDING * (numberOfLines - 1);
        
        [adminreLbl setFontColor:[UIColor brownTitleColor] range:NSMakeRange(0, 7)];
        
        self.adminreview.height = adminreLbl.height;
        //卖家回复之后的偏移量
        offect_y = self.adminreview.y + self.adminreview.height + 10;
    }
    
    //追加
    if ([_evaModel.secreview allKeys].count) {
        [self.contentView addSubview:self.zjView];
        self.zjView.y = offect_y;
        NSDictionary *secDic = _evaModel.secreview;
        NSString *appendStr = [NSString stringWithFormat:@"[追加评价]：%@",[secDic objectForJSONKey:@"content"]];
        PYMultiLabel *appendReplyLbl = (PYMultiLabel *)[self.zjView viewWithTag:4000];
        CGFloat appendViewHeight = [self lableHeightWithString:appendStr Size:CGSizeMake(appendReplyLbl.width,MAXFLOAT) fontSize:LABLE_FONTSIZE] + 5;

        appendReplyLbl.y = 0;
        
        [UICommon setLabelPadding:appendReplyLbl text:appendStr padding:LINE_PADDING];
        NSInteger numberOfLines = appendViewHeight / LABLE_FONTSIZE;
        appendReplyLbl.height = appendViewHeight + LINE_PADDING * (numberOfLines - 1);
        
        [appendReplyLbl setFontColor:[UIColor brownTitleColor] range:NSMakeRange(0, 7)];
        
        
        //追加评价时间
        UILabel *appendTimeLbl = (UILabel *)[self.zjView viewWithTag:5000];
        appendTimeLbl.text = [secDic objectForJSONKey:@"created"];
        appendTimeLbl.y = appendReplyLbl.y + appendReplyLbl.height + 10;
        
        self.zjView.height = appendReplyLbl.y + appendReplyLbl.height +27;
        
        offect_y = self.zjView.y +self.zjView.height +10;
    }
    
    //卖家回复追评
    if ([_evaModel.secadminreview allKeys].count) {
        self.secadminreview.y = offect_y;
        [self.contentView addSubview:self.secadminreview];
        NSDictionary *secadminreviewDic = _evaModel.secadminreview;
        NSString *adminStr =[NSString stringWithFormat:@"[追加回复]：%@",secadminreviewDic[@"content"]];
        PYMultiLabel *adminreLbl = (PYMultiLabel *)[self.secadminreview viewWithTag:6000];
        CGFloat adminlabHeight = [self lableHeightWithString:adminStr Size:CGSizeMake(adminreLbl.width,MAXFLOAT) fontSize:LABLE_FONTSIZE];

        adminreLbl.y = 0;
        
        [UICommon setLabelPadding:adminreLbl text:adminStr padding:LINE_PADDING];
        NSInteger numberOfLines = adminlabHeight / LABLE_FONTSIZE;
        adminreLbl.height = adminlabHeight + LABLE_TOP_PADDING * 2 + LINE_PADDING * (numberOfLines - 1);
        
        [adminreLbl setFontColor:[UIColor brownTitleColor] range:NSMakeRange(0, 7)];
        
        self.secadminreview.height = adminreLbl.y + adminreLbl.height;
        
        //卖家回复之后的偏移量
        offect_y = self.secadminreview.y + self.secadminreview.height + 10;
    }

    //规格
    if (!_evaModel.spec || ![_evaModel.spec isKindOfClass:[NSNull class]] ) {
        
        if (_evaModel.spec.length) {
            self.standLbl.text = [NSString stringWithFormat:@"规格：%@",_evaModel.spec];
        }
        
        //        self.height = offect_y + 30;
        
    }else{
        self.standLbl.text = @"";
        
        //        self.height = offect_y;
        
    }
    
    self.standLbl.y = offect_y;
    
}

+ (CGFloat)tableViewCellHeight:(id)data
{
    CYEvaluationModel *model = data;
    
    CGFloat height = 70;
    NSString *userComm = [NSString stringWithFormat:@"[买家评价]：%@",model.content];
    //买家第一次评价
    //第一次评价内容
    NSDictionary *attribute = @{NSFontAttributeName: FONT(LABLE_FONTSIZE)};
    CGSize lableSize = [userComm boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 40,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    NSInteger numberOfLines = lableSize.height / LABLE_FONTSIZE;
    CGFloat labHeight = lableSize.height + LINE_PADDING * (numberOfLines - 1);
    
    height +=labHeight;
    
    //买家第一次评价图片
    CGFloat imgWidth = (SCREEN_WIDTH - 40 - 5 * 4 ) / 5;
    if(model.attach.count)
    {
        height += imgWidth + 10;
    }
    
    //买家第一次评价时间 加 时间相对于评价间隔10像素
    height +=27;
    //间隔10
    height +=10;
    
    //卖家回复
    if ([model.adminreview allKeys].count) {
        NSDictionary *secDic = model.adminreview;
        NSString *appendStr = [NSString stringWithFormat:@"[卖家回复]：%@",[secDic objectForJSONKey:@"content"]];
        lableSize = [appendStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-60,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        NSInteger numberOfLines = lableSize.height / LABLE_FONTSIZE;
        CGFloat adminlabHeight = lableSize.height + LABLE_TOP_PADDING * 2 + LINE_PADDING * (numberOfLines - 1);
        
        height += adminlabHeight;
        //间隔10
        height +=10;
    }
    
    //追加
    if ([model.secreview allKeys].count) {
        NSDictionary *secDic = model.secreview;
        NSString *appendStr = [NSString stringWithFormat:@"[追加评价]：%@",[secDic objectForJSONKey:@"content"]];
        lableSize = [appendStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-40,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        NSInteger numberOfLines = lableSize.height / LABLE_FONTSIZE;
        CGFloat appendViewHeight = lableSize.height + LINE_PADDING * (numberOfLines - 1);
        
        height +=appendViewHeight;
        //追评时间 加间隔10
        height +=27;
        
        //间隔10
        height +=10;
    }

    //卖家回复追评
    if ([model.secadminreview allKeys].count) {
        NSDictionary *secDic = model.secadminreview;
        NSString *appendStr = [NSString stringWithFormat:@"[追加回复]：%@",[secDic objectForJSONKey:@"content"]];
        lableSize = [appendStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-60,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        NSInteger numberOfLines = lableSize.height / LABLE_FONTSIZE;
        CGFloat adminlabHeight = lableSize.height + LABLE_TOP_PADDING * 2 + LINE_PADDING * (numberOfLines - 1);
        
        height += adminlabHeight;
        //间隔10
        height +=10;
    }
    
    if (model.spec.length) {
        height +=27;
    }
    
    return height;
}

-(CGFloat)lableHeightWithString:(NSString *)string Size:(CGSize )size fontSize:(CGFloat)fontSize
{
    NSDictionary *attribute = @{NSFontAttributeName: FONT(fontSize)};
    CGSize lableSize = [string boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return lableSize.height;
}


@end
