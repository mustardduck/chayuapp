//
//  CYMoneyDetailViewController.m
//  TeaMall
//
//  Created by Chayu on 15/11/13.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYMoneyDetailViewController.h"
#import "CYMoneyDetailTableViewCell.h"
@interface CYMoneyDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
- (IBAction)goback:(id)sender;

@end

@implementation CYMoneyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.barStyle = NavBarStyleNoneMore;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:self.title];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:self.title];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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
    CYMoneyDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYMoneyDetailTableViewCell"];
    cell.moneyto = _model.moneyTo;
    cell.money = _model.money;
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
