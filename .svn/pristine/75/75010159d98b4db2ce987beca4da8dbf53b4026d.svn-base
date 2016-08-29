//
//  CYClassicTableViewCell.m
//  茶语
//
//  Created by Chayu on 16/3/16.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYClassicTableViewCell.h"
#import "BaseButton.h"

@interface CYClassicTableViewCell ()
{
    NSInteger itemnum;
}

@end

@implementation CYClassicTableViewCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWidthTableView:(UITableView*)tableView{
    CYClassicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYClassicTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYClassicTableViewCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (void)setItemArr:(NSArray *)itemArr
{
    _itemArr = itemArr;
    [self addItems:_itemArr];
}

- (void)setIsLast:(BOOL)isLast
{
    _isLast = isLast;
}
- (void)setIsAllClass:(BOOL)isAllClass
{
    _isAllClass = isAllClass;
}
-(void)setCatId:(NSString *)catId
{
    _catId = catId;
    if (!_isAllClass) {
     [self updateButtonStates];
    }
}

#define BUTTONHEIGHT 32.
#define WGAP 14.
#define HGAP 12.5
#define SELECTCOLOR [UIColor getColorWithHexString:@"c0501f"]
-(void)updateButtonStates
{
    for (int i =0; i<[_itemArr count]; i++) {
        BaseButton *defaultBtn = [self.contentView viewWithTag:i+50000];
        NSDictionary *info = _itemArr[i];
         NSString *dataId = [info objectForKey:@"data"];
        if ([dataId isEqualToString:_catId]) {
            defaultBtn.borderColor = SELECTCOLOR;
            [defaultBtn setTitleColor:SELECTCOLOR forState:UIControlStateNormal];
        }else{
            defaultBtn.borderColor = MAIN_BGCOLOR;
            [defaultBtn setTitleColor:CONTENTCOLOR forState:UIControlStateNormal];
        }
    }
}



-(void)addItems:(NSArray *)arr
{
    CGFloat buttonweight = SCREEN_WIDTH>320?((SCREEN_WIDTH-14.*5)/4):((SCREEN_WIDTH-14.*4)/3);
    if (_isLast) {
        buttonweight =((SCREEN_WIDTH-14.*4)/3);
    }
    for (int i = 0; i<[arr count]; i++) {
        NSDictionary *info = arr[i];
        NSString *dataId = [info objectForKey:@"data"];
        NSInteger row = i%(SCREEN_WIDTH>320?4:3);
        NSInteger sec = i/(SCREEN_WIDTH>320?4:3);
        BaseButton *button = [BaseButton initWithStyle:UIButtonTypeCustom Frame:CGRectMake(buttonweight*row +WGAP*(row +1),BUTTONHEIGHT*sec +HGAP *(sec+1),buttonweight, BUTTONHEIGHT) Title:[info objectForKey:@"title"] TitleColor:CONTENTCOLOR Font:FONT(14.0)];
        button.borderColor = MAIN_BGCOLOR;
        button.borderWidth = 1.0f;
        button.cornerRadius = 2.0f;
    
        button.tag = 50000+i;
        [button addTarget:self action:@selector(item_click:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        if ([dataId isEqualToString:_catId]) {
            [self item_click:button];
        }
    }
}


-(void)item_click:(BaseButton *)sender
{
    
    if (_itemClick) {
        NSDictionary *info = _itemArr[sender.tag-50000];
        _itemClick(info,_cellIndePath);
    }
    
    
    if (!_isAllClass) {
        for (int i =0; i<[_itemArr count]; i++) {
            BaseButton *defaultBtn = [self.contentView viewWithTag:i+50000];
            if (defaultBtn.tag == sender.tag) {
                defaultBtn.borderColor = SELECTCOLOR;
                [defaultBtn setTitleColor:SELECTCOLOR forState:UIControlStateNormal];
            }else{
                defaultBtn.borderColor = MAIN_BGCOLOR;
                [defaultBtn setTitleColor:CONTENTCOLOR forState:UIControlStateNormal];
            }
        }
    }
 
}

+ (CGFloat)cellHeightWithInfo:(id)info andisLast:(BOOL)isLast{
    CGFloat cell_height = 0.0;
    NSArray *arr = info;
    CGFloat itemnum =(SCREEN_WIDTH>320?4.:3.);
    if (isLast) {
        itemnum = 3.;
    }

    cell_height =  ceilf(arr.count/itemnum) *(BUTTONHEIGHT+HGAP);
    return cell_height;
}
@end
