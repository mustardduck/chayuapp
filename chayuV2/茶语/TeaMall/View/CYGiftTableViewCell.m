//
//  CYGiftTableViewCell.m
//  TeaMall
//  礼品信息
//  Created by Chayu on 15/11/10.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYGiftTableViewCell.h"

@interface CYGiftTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *giftNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *giftNumLbl;

@property (weak, nonatomic) IBOutlet UIView *giftView;

@end

@implementation CYGiftTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWidthTableView:(UITableView*)tableView{
    static NSString *giftIdentify = @"CYGiftTableViewCell";
    CYGiftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:giftIdentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYGiftTableViewCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}



- (void)setGoodsordergift:(NSArray *)goodsordergift
{
    _goodsordergift = goodsordergift;
    for (int i = 0; i<[_goodsordergift count]; i++) {
        NSDictionary *info = _goodsordergift[i];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,i*38, SCREEN_WIDTH,38) ];
        [_giftView addSubview:view];
        UILabel *titlelable = [[UILabel alloc] initWithFrame:CGRectZero];
        titlelable.text =[info objectForJSONKey:@"title"];
        titlelable.font = FONT(12.0f);
        titlelable.textColor = CONTENTCOLOR;
        [view addSubview:titlelable];
        titlelable.width  = view.width - 40;
        titlelable.height = 17;
        titlelable.x = 10;
        titlelable.y = view.height/2 -titlelable.height/2;
        UILabel *numLable = [[UILabel alloc] initWithFrame:CGRectMake(view.width - 25, 12,10, 15)];
        numLable.textColor = CONTENTCOLOR;
        numLable.font = FONT(11.0f);
        numLable.text = [NSString stringWithFormat:@"x%@",[info objectForJSONKey:@"number"]];
        [numLable sizeToFit];
        numLable.y = view.height/2 - numLable.height/2;
        [view addSubview:numLable];

    }
    
}
@end
