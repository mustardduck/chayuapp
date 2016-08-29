//
//  CYBuyerReturnMainVC.m
//  茶语
//
//  Created by Leen on 16/7/11.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerReturnMainVC.h"
#import "CYBuyerReturnGrayCell.h"
#import "CYBuyerReturnOrangeCell.h"
#import "UIColor+Additions.h"
#import "UILabel+Utilities.h"

@interface CYBuyerReturnMainVC ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation CYBuyerReturnMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchUpInsideOn:(id)sender {
    UIButton * btn = (UIButton *)sender;
    
    if(btn == _agreeBtn)
    {
        
    }
    else if (btn == _refuseBtn)
    {
        
    }
    else if (btn == _applyBtn)
    {
        
    }
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!(indexPath.row % 2))
    {
        CYBuyerReturnGrayCell * cell = (CYBuyerReturnGrayCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return cell.height;
    }
    else
    {
        CYBuyerReturnOrangeCell * cell = (CYBuyerReturnOrangeCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return cell.height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!(indexPath.row % 2))
    {
        CYBuyerReturnGrayCell * cell = [CYBuyerReturnGrayCell cellWidthTableView:tableView];
        
        if(indexPath.row == 0)
        {
            cell.bgFirstLbl.text = @"货物状态：重庆市南岸区南滨路1-1 茶语市集（收） 15823381469";
            
            cell.firstLblHeightCons.constant = cell.bgFirstLbl.boundingRectWithHeight + 10;
            cell.secondLblHeightCons.constant = cell.bgSecondLbl.boundingRectWithHeight + 10;
            
            
            
            cell.bgImgHeightCons.constant = 95 + cell.firstLblHeightCons.constant + cell.secondLblHeightCons.constant - 22 * 2 ;
            
            cell.height = cell.bgImgHeightCons.constant + 38 + 5;
        }
        else if (indexPath.row == 2)
        {
            cell.bgImgHeightCons.constant = 95;
            cell.height = cell.bgImgHeightCons.constant + 38 + 5;
        }
        return cell;
    }
    else
    {
        CYBuyerReturnOrangeCell * cell = [CYBuyerReturnOrangeCell cellWidthTableView:tableView];
        
        if (indexPath.row == 1)
        {
            cell.bgFirstLbl.text = @"退货地址：重庆市南岸区南滨路1-1 茶语市集（收） 15823381469";
            cell.bgImgHeightCons.constant = 75 + cell.bgFirstLbl.boundingRectWithHeight - 12;
            cell.height = cell.bgImgHeightCons.constant + 38 + 5;
        }
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    footerView.backgroundColor = [UIColor grayBackgroundColor];
    return footerView;
}

@end
