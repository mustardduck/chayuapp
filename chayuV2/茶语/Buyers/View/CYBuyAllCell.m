//
//  CYBuyAllself.m
//  茶语
//
//  Created by Leen on 16/6/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyAllCell.h"
#import "CALayer+CALayer_CALayer_XibConfiguration.h"
#import "UILabel+Utilities.h"
#import "UIColor+Additions.h"

@interface CYBuyAllCell()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *desTopCons;


@end


@implementation CYBuyAllCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellForTableView:(UITableView *)tableView
{
    static NSString *cellID = @"CYBuyAllCell";
    
    CYBuyAllCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)allListCellfollowBtnClicked:(id)sender
{
    [self doAttend:_allListCellmodel.uid];
}

- (void)mainCellfollowBtnClicked:(id)sender
{
    [self doAttend:_model.selleruid];
}

-(void)doAttendAllListCellModel:(NSString *)masterId
{
    [CYWebClient Post:@"DoAttend" parametes:@{@"sellerUid":masterId} success:^(id responObj) {
        NSInteger status = [[responObj objectForKey:@"status"] integerValue];
        if (status == 1) {
            _allListCellmodel.isAttend = @"0";
            _followBtn.selected = NO;
        }else{
            _allListCellmodel.isAttend = @"1";
            _followBtn.selected = YES;
        }
        
        _followIcon.hidden = _followBtn.selected;
        _followBtn.layer.borderUIColor = _followBtn.selected ? [UIColor grayTitleOrLineColor] : [UIColor brownTitleColor];
        
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
}

-(void)doAttend:(NSString *)masterId
{
    [CYWebClient Post:@"DoAttend" parametes:@{@"sellerUid":masterId} success:^(id responObj) {
        NSInteger status = [[responObj objectForKey:@"status"] integerValue];
        if (status == 1) {
            _model.isAttend = NO;
            _followBtn.selected = NO;
        }else{
            _model.isAttend = YES;
            _followBtn.selected = YES;
        }
        
        _followIcon.hidden = _followBtn.selected;
        _followBtn.layer.borderUIColor = _followBtn.selected ? [UIColor grayTitleOrLineColor] : [UIColor brownTitleColor];
        
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
}

- (void)setAllListCellmodel:(CYBuyerAllListCellModel *)model
{
    _allListCellmodel = model;
    
    self.nameLbl.text = model.realname;
    
    _imgview.height = 250 * SCREEN_WIDTH / 375;
    [_imgview sd_setImageWithURL:[NSURL URLWithString:model.visualize_picture]];

    _desLbl.text = [NSString stringWithFormat:@"简介：%@",model.introduce];
    
    [_desLbl setFontColor:[UIColor blackTitleColor] range:NSMakeRange(0, 3)];
    
    _followBtn.selected = [model.isAttend integerValue] ? YES : NO;
    _followIcon.hidden = _followBtn.selected;
    _followBtn.layer.borderUIColor = _followBtn.selected ? [UIColor grayTitleOrLineColor] : [UIColor brownTitleColor];

    [self.followBtn addTarget:self action:@selector(allListCellfollowBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addTagView:model.majorids];

}

- (void) addTagView:(NSArray *)tagArr
{
    for (UIView *view in _tagView.subviews) {
        [view removeFromSuperview];
    }
    
    NSInteger row = 1;
    
    CGFloat tagLbl_X = 0;
    
    CGFloat tagLbl_Y = (19 + 5) * (row - 1);
    
    
    for(int i = 0; i < tagArr.count; i ++)
    {
        UILabel * lbl = [[UILabel alloc] initWithFrame:CGRectMake(tagLbl_X, tagLbl_Y, 50, 19)];
        lbl.backgroundColor = [UIColor grayDarkBackgroundColor];
        lbl.textColor = [UIColor grayDarkerTitleColor];
        lbl.font = FONT(12);
        
        lbl.text = tagArr[i];
        lbl.width = lbl.boundingRectWithWidth + 14;
        
        lbl.textAlignment = NSTextAlignmentCenter;
        
        tagLbl_X += lbl.width + 5;
        
        if(tagLbl_X + lbl.width + 5 >= self.tagView.width)
        {
            if(i == tagArr.count - 1)
            {
                
            }
            else
            {
                row ++;
                
                tagLbl_Y = (19 + 5) * (row - 1);
                
                tagLbl_X = 0;
                
                lbl.x = tagLbl_X;
                
                lbl.y = tagLbl_Y;
                
                tagLbl_X += lbl.width + 5;
            }
        }
        
        [self.tagView addSubview:lbl];
        
    }
    
    self.tagViewHeightCons.constant = row * (19 + 5);
    
    self.height = _tagView.y + _tagView.height - 250 + _imgview.height  + 10;

}

- (void)setModel:(CYBuyerMainCellModel *)model
{
    _model = model;
    
    if(_isOnlyShowContent)
    {
        _desTopCons.constant = - 34;
        
        _vipIcon.hidden = YES;
        _followBtn.hidden = YES;
        _followIcon.hidden = YES;
        
        _imgview.height = 250 * SCREEN_WIDTH / 375;
        [_imgview sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
        
        _desLbl.text = [NSString stringWithFormat:@"简介：%@",model.content];
        [_desLbl setFontColor:[UIColor blackTitleColor] range:NSMakeRange(0, 3)];

        self.height = _imgview.height + _desLbl.height + 10;
    }
    else
    {
        self.nameLbl.text = model.sellername;
        
        _imgview.height = 250 * SCREEN_WIDTH / 375;
        [_imgview sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
        
        _desLbl.text = [NSString stringWithFormat:@"简介：%@",model.content];
        [_desLbl setFontColor:[UIColor blackTitleColor] range:NSMakeRange(0, 3)];
        
        _followBtn.selected = model.isAttend;
        
        [self.followBtn addTarget:self action:@selector(mainCellfollowBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _followIcon.hidden = _followBtn.selected;
        _followBtn.layer.borderUIColor = _followBtn.selected ? [UIColor grayTitleOrLineColor] : [UIColor brownTitleColor];
        
        NSArray * tagArr = model.catarr;
        
        [self addTagView:tagArr];
    }
}

@end
