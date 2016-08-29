//
//  CYCommentTableViewAppear.m
//  茶语
//
//  Created by 李峥 on 16/3/11.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYCommentTableViewAppear.h"


@implementation CYCommentTableViewAppear


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYTeaCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:_iCellNibName];
    
    if (cell == nil) {
        id cellObj = NSClassFromString(_iCellNibName);
        cell = (CYTeaCommentCell *)[cellObj loadFromNibName:_iCellNibName];
        
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
    
    [cell parseData:[_iDataSourceArr objectAtIndex:[indexPath row]]];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapZan:)];
//    cell.mGoodLabel.userInteractionEnabled = YES;
//    cell.mGoodLabel.tag = 100+indexPath.row;
//    [cell.mGoodLabel addGestureRecognizer:tap];
    
    cell.zanBtn.tag = 100+indexPath.row;
    [cell.zanBtn addTarget:self action:@selector(tapZan:) forControlEvents:UIControlEventTouchUpInside];
    cell.commBtn.tag = 10000+indexPath.row;
    [cell.commBtn addTarget: self action:@selector(tapComm:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    return cell;
}

- (void)tapZan:(UIButton *)tap
{
    NSDictionary *data = [_iDataSourceArr objectAtIndex:tap.tag - 100];
    if (self.iDelegate && [self.iDelegate respondsToSelector:@selector(tableViewApperButtonDidClicked:)]) {
        [self.iDelegate tableViewApperButtonDidClicked:data];
    }
}

-(void)tapComm:(UIButton *)sender
{
    NSDictionary *data = [_iDataSourceArr objectAtIndex:sender.tag - 10000];
    if (self.iDelegate && [self.iDelegate respondsToSelector:@selector(tableViewApperButtonDidClicked:)]) {
        [self.iDelegate tableViewApperButtonDidClicked:data];
    }
}


@end
