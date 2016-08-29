//
//  CYBuyerCateItemCell.m
//  茶语
//
//  Created by Leen on 16/5/23.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerCateItemCell.h"
#import "BaseButton.h"

@interface CYBuyerCateItemCell ()
{
    NSInteger itemnum;
}

@end

@implementation CYBuyerCateItemCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+(instancetype)cellWidthTableView:(UITableView*)tableView{
    CYBuyerCateItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYBuyerCateItemCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerCateItemCell" owner:nil options:nil] firstObject];
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
            defaultBtn.borderColor = btnBorderSelected_COLOR;
            [defaultBtn setTitleColor:btnBorderSelected_COLOR forState:UIControlStateNormal];
        }else{
            defaultBtn.borderColor = btnBorder_COLOR;
            [defaultBtn setTitleColor:btnTitle_COLOR forState:UIControlStateNormal];
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
        BaseButton *button = [BaseButton initWithStyle:UIButtonTypeCustom Frame:CGRectMake(buttonweight*row +WGAP*(row +1),BUTTONHEIGHT*sec +HGAP *(sec+1),buttonweight, BUTTONHEIGHT) Title:[info objectForKey:@"title"] TitleColor:btnTitle_COLOR Font:FONT(14.0)];
        button.borderColor = btnBorder_COLOR;
        button.borderWidth = 1.0f;
        button.cornerRadius = 2.0f;
        
        button.tag = 50000+i;
        [button addTarget:self action:@selector(item_click:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        if ([dataId isEqualToString:_catId]) {
            [self item_click:button];
        }
    }
    
    if(_isAddLastBtn)
    {
        NSInteger i = arr.count;
        
        NSInteger row = i%(SCREEN_WIDTH>320?4:3);
        NSInteger sec = i/(SCREEN_WIDTH>320?4:3);
        
        BaseButton *button = [BaseButton initWithStyle:UIButtonTypeCustom Frame:CGRectMake(buttonweight*row +WGAP*(row +1),BUTTONHEIGHT*sec +HGAP *(sec+1),buttonweight, BUTTONHEIGHT) Title:@"+ 其他" TitleColor:btnBorderSelected_COLOR Font:FONT(14.0)];
        button.tag = 60000;

        [button addTarget:self action:@selector(item_click:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];

    }
}


-(void)item_click:(BaseButton *)sender
{
    
    if (_itemClick) {
        
        if(sender.tag == 60000)
        {
            NSDictionary *info = @{@"type": @"addArea"};
            _itemClick(info,_cellIndePath);
        }
        else
        {
            NSDictionary *info = _itemArr[sender.tag-50000];
            _itemClick(info,_cellIndePath);
        }

    }
    
    
    if (!_isAllClass) {
        for (int i =0; i<[_itemArr count]; i++) {
            BaseButton *defaultBtn = [self.contentView viewWithTag:i+50000];
            if (defaultBtn.tag == sender.tag) {
                defaultBtn.borderColor = btnBorderSelected_COLOR;
                [defaultBtn setTitleColor:btnBorderSelected_COLOR forState:UIControlStateNormal];
            }else{
                defaultBtn.borderColor = btnBorder_COLOR;
                [defaultBtn setTitleColor:btnTitle_COLOR forState:UIControlStateNormal];
            }
        }
    }
    
}

+ (CGFloat)cellHeightWithInfo:(NSInteger)arrCount andisLast:(BOOL)isLast
{
    CGFloat cell_height = 0.0;
    CGFloat itemnum =(SCREEN_WIDTH>320?4.:3.);
    if (isLast) {
        itemnum = 3.;
    }
    
    cell_height =  ceilf(arrCount/itemnum) *(BUTTONHEIGHT+HGAP);
    return cell_height;
}
@end

