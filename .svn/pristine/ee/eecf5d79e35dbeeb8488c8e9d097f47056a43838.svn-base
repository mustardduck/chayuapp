//
//  CYClassTableViewCell.m
//  茶语
//
//  Created by Chayu on 16/2/23.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYClassTableViewCell.h"
#import "BaseButton.h"
@interface CYClassTableViewCell ()
{
    NSInteger selectTag;
}

@property (weak, nonatomic) IBOutlet UIView *classView;


@end

@implementation CYClassTableViewCell

- (void)awakeFromNib {
    selectTag = -1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWidthTableView:(UITableView*)tableView{
    CYClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYClassTableViewCell1"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYClassTableViewCell" owner:nil options:nil] firstObject];
    }
   
    return cell;
}

- (void)setDataArr:(NSArray *)dataArr
{
 
    _dataArr = dataArr;
    [self creatClassButton:_dataArr];
}

#define BUTTONWIDTH ((SCREEN_WIDTH-60)/4)
-(void)creatClassButton:(NSArray *)arr
{

    for (int i =0; i<[arr count]; i++) {
        NSInteger row = i %4;
        NSInteger sec = i/4;
        NSDictionary *info = arr[i];
        NSString *title = [NSString stringWithFormat:@"%@%d",info[@"title"],i];
        BaseButton *classBtn = [BaseButton initWithStyle:UIButtonTypeCustom Frame:CGRectMake((BUTTONWIDTH +10)*row,sec *50, BUTTONWIDTH,40) Title:title TitleColor:CONTENTCOLOR Font:FONT(14)];
        classBtn.tag = 2000+i;
        classBtn.borderColor = BORDERCOLOR;
        classBtn.borderWidth = 1.0f;
        classBtn.cornerRadius = 2.0f;
      
        [classBtn addTarget:self action:@selector(selectClass_click:) forControlEvents:UIControlEventTouchUpInside];
        [classBtn setTitle:title forState:UIControlStateSelected];
        [classBtn setTitleColor:MAIN_COLOR forState:UIControlStateSelected];
        [_classView addSubview:classBtn];
        if (classBtn.tag == selectTag) {
            classBtn.selected = YES;
        }else{
            classBtn.selected = NO;
        }
    }
}

-(void)selectClass_click:(BaseButton *)sender
{
    selectTag = sender.tag;
    for (int i =0; i<[_dataArr count]; i++) {
        BaseButton *button = (BaseButton *)[_classView viewWithTag:i+2000];
        if (button.tag == sender.tag) {
            
            button.selected = YES;
            button.borderColor = MAIN_COLOR;
        }else{
            button.selected = NO;
            button.borderColor = BORDERCOLOR;
        }
    }
}

@end
