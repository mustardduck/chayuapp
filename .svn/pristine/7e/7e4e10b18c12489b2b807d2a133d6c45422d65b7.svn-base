//
//  CYPDBaseMesView.m
//  TeaMall
//
//  Created by Chayu on 15/10/26.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYPDBaseMesView.h"

@interface CYPDBaseMesView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end


@implementation CYPDBaseMesView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.tableView.frame = self.bounds;
    [self addSubview:self.tableView];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    [self.tableView reloadData];
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
    return 44.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *pdbaseidentify = @"CYPDBaseMesViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pdbaseidentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pdbaseidentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    }else{
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
   NSDictionary *info = _dataArr[indexPath.row];
    UILabel *titleLbl = [self creatlable:CGRectMake(10,12,50,20) Font:FONT(14)];
//    titleLbl.text = [info[MESSAGE_TITLE]  stringByAppendingString:@"："];
    titleLbl.text = [NSString stringWithFormat:@"%@：",[info objectForJSONKey:@"attrName"]];

    [cell.contentView addSubview:titleLbl];
    [titleLbl sizeToFit];
    titleLbl.y = 12;
    
    UILabel *contentlable = [self creatlable:CGRectMake(titleLbl.x +titleLbl.width,12,SCREEN_WIDTH-titleLbl.x-titleLbl.width-20,20) Font:FONT(14.)];
//    contentlable.text = info[MESSAGE_CONTENT];
    contentlable.text = [info objectForJSONKey:@"attrData"];
    [cell.contentView addSubview:contentlable];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(UILabel *)creatlable:(CGRect)rect Font:(UIFont *)font
{
    UILabel *lable = [[UILabel alloc] initWithFrame:rect];
    lable.backgroundColor = CLEARCOLOR;
    lable.textColor = TITLECOLOR;
    lable.font = font;
    return lable;
}


@end
