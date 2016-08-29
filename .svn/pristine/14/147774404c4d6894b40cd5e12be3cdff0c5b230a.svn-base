//
//  CYClassView.m
//  茶语
//
//  Created by Chayu on 16/2/23.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYClassView.h"
#import "BaseButton.h"
#import "CYClassicTableViewCell.h"
@interface CYClassView ()<UITableViewDataSource,UITableViewDelegate>
{
}

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *openView;


@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation CYClassView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    _tableView.dataSource = self;
    _tableView.delegate = self;
    hiddenSepretor(_tableView);
}
- (void)setIsLast:(BOOL)isLast
{
    _isLast = isLast;
    if (_isLast) {
        _tableView.backgroundColor = [UIColor getColorWithHexString:@"f5f5f5"];
    }else{
        _tableView.backgroundColor = [UIColor whiteColor];
    }
}
- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    [_tableView reloadData];
}

- (void)setInfo:(NSDictionary *)info
{
    _info = info;
    
}

-(void)selectClass_click:(UIButton *)sender
{
    
}

+(CGFloat)classicViewHeight:(NSArray *)secArr andisLast:(BOOL)islast{
    CGFloat height = 0;
    for (int i=0; i<[secArr count]; i++) {
        NSArray *itemarr = secArr[i][@"list"];
        height +=[CYClassicTableViewCell cellHeightWithInfo:itemarr andisLast:islast];
//        height +=15;
        NSString *title = secArr[i][@"title"];
        if (title.length >0) {
            height +=45;
        }
    }
    height +=45;
    return height;
}

#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return [_dataArr count];
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *itemArr =_dataArr[indexPath.section][@"list"];
    return [CYClassicTableViewCell cellHeightWithInfo:itemArr andisLast:_isLast];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYClassicTableViewCell *cell = [CYClassicTableViewCell cellWidthTableView:tableView];
    if (_isLast) {
        cell.contentView.backgroundColor = [UIColor getColorWithHexString:@"f5f5f5"];
    }else{
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    cell.itemArr = _dataArr[indexPath.section][@"list"];
    cell.isAllClass = YES;
    __weak __typeof(self) weakSelf = self;
    cell.itemClick = ^(NSDictionary *data,NSIndexPath *seledIndexPath){
        if ([weakSelf.delegate respondsToSelector:@selector(selectClassType:andIsLast:)]) {
            [weakSelf.delegate selectClassType:data andIsLast:weakSelf.isLast];
        }
    };
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = _dataArr[section][@"title"];
    if (title.length>0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(14, 14,SCREEN_WIDTH-14,15)];
        titleLbl.font = FONT(14.0);
        titleLbl.textColor = CONTENTCOLOR;
        titleLbl.text = [NSString stringWithFormat:@"· %@",title];
        [headerView addSubview:titleLbl];
        return headerView;
    }else{
        return nil;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *title = _dataArr[section][@"title"];
    if (title.length>0) {
        return 30;
    }else{
        return 0.0000001;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    
    NSString *title = _dataArr[section][@"title"];
    if (title.length>0) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
        UIView *lin = [[UIView alloc] initWithFrame:CGRectMake(14,14,SCREEN_WIDTH-28,0.5)];
        lin.backgroundColor = BORDERCOLOR;
        [footerView addSubview:lin];
        return footerView;
    }else{
        return nil;
    }
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSString *title = _dataArr[section][@"title"];
    if (title.length>0) {
        return 10.;
    }else{
        return 0.0000001;
    }
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
