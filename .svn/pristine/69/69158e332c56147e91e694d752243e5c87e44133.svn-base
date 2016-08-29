 //
//  BaseTableViewAppear.m
//  PYFrameworks
//
//  Created by 李 峥 on 14/11/29.
//  Copyright (c) 2014年 李 峥. All rights reserved.
//

#import "BaseTableViewAppear.h"

@implementation BaseTableViewAppear
@synthesize selectedCellIndexPath=_selectedCellIndexPath;

- (id)init
{
    self = [super init];
    if (self) {
        self.iCellHeight = 44.0;
        self.iVariableCellHeight = NO;
    }
    
    return  self;
}

#pragma mark - 加载更多时组装数据
- (void)appendDataSource:(NSArray *)moreDatasource
{
    if ([moreDatasource count] > 0 && _iDataSourceArr) {
        [self.iDataSourceArr addObjectsFromArray:moreDatasource];
    }
}

#pragma mark - UITableView Delegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_grouped) {
        return [_iDataSourceArr count];
    }else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_grouped) {
        return 1;
    }else
    {
        return [_iDataSourceArr count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_grouped) {
        return self.iFooterHeight;
    }else
    {
        return 0.1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_grouped) {
        return self.iHeaderHeight;
    }else
    {
        return 0.1;
    }
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    cell.backgroundColor = [UIColor clearColor];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cellObj = NSClassFromString(_iCellNibName);
    return _iVariableCellHeight ? [cellObj calcCellHeight:[_iDataSourceArr objectAtIndex:[indexPath row]]]:_iCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:_iCellNibName];
    
    if (cell == nil) {
        id cellObj = NSClassFromString(_iCellNibName);
        cell = (BaseCell *)[cellObj loadFromNibName:_iCellNibName];
        
        if (_iSelectCellColor) {
            UIView *selView = [[UIView alloc] init];
            selView.backgroundColor = _iSelectCellColor;
            [cell setSelectedBackgroundView:selView];
        }
        
        if (_iSelectCellImg) {
            UIImageView *selImage = [[UIImageView alloc] initWithImage:_iSelectCellImg];
            [cell setSelectedBackgroundView:selImage];
        }
    }
    
    if (_grouped) {
        [cell parseData:[_iDataSourceArr objectAtIndex:[indexPath section]]];
    }else
    {
        [cell parseData:[_iDataSourceArr objectAtIndex:[indexPath row]]];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _selectedCellIndexPath = indexPath;
    
    BaseCell *selCell = (BaseCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (_iDelegate && [_iDelegate respondsToSelector:@selector(tableViewApperDidClicked:)]) {
        [_iDelegate tableViewApperDidClicked:selCell.mClickData];
    }
}

@end
