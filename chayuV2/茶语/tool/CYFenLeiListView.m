//
//  CYFenLeiListView.m
//  茶语
//
//  Created by Chayu on 16/7/11.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYFenLeiListView.h"




@interface CYFenLeiListView ()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *selectButton;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation CYFenLeiListView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    [super awakeFromNib];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

-(void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    [_tableView reloadData];
}


#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr count];
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
     NSString *identify = [NSString stringWithFormat:@"%d",(int)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        for (id view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    NSDictionary *info = _dataArr[indexPath.row];
    NSString *title = nil;//
    if (_isTitle) {
       title =  [info objectForKey:@"title"];
    }else{
       title = [info objectForKey:@"name"];
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor getColorWithHexString:@"666666"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    button.titleLabel.font = FONT(14.0);
    [button sizeToFit];
    button.width = button.width +10;
    button.height = button.height +5;
    button.tag = indexPath.row +6000;
    button.userInteractionEnabled = NO;
    
    
    
    button.frame = CGRectMake(20,cell.contentView.height-button.height, button.width, button.height);
    [cell.contentView addSubview:button];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info = _dataArr[indexPath.row];
    if (self.selectCateBlock) {
        self.selectCateBlock([info objectForKey:@"id"],[info objectForKey:@"name"]);
    }
    
    
    if (self.quanziCateBlock) {
        self.quanziCateBlock(info);
    }
    
    if (self.shijiCateBlock) {
        self.shijiCateBlock(info);
    }
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIButton *button = (UIButton *)[cell.contentView viewWithTag:indexPath.row +6000];
    if (button == selectButton && selectButton) {
        return;
    }
    
    selectButton.selected = NO;
    [selectButton setBackgroundColor:[UIColor whiteColor]];
    button.selected = YES;
    [button setBackgroundColor:[UIColor getColorWithHexString:@"893e20"]];
    selectButton = button;
    
}




@end
