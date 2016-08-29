//
//  CYBuyerTodaySumListVC.m
//  茶语
//
//  Created by Leen on 16/8/26.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerTodaySumListVC.h"
#import "CYBuyerTodaySumCell.h"

@interface CYBuyerTodaySumListVC ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray * _dataArr;
}

@property (weak, nonatomic) IBOutlet UIView *emptyView;

@end

@implementation CYBuyerTodaySumListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYBuyerTodaySumCell * cell = [CYBuyerTodaySumCell cellWidthTableView:tableView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

@end
