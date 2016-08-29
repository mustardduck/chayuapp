//
//  CYXuanZeTuiKuanYuanYinController.m
//  茶语
//
//  Created by Chayu on 16/8/16.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYXuanZeTuiKuanYuanYinController.h"

@interface CYXuanZeTuiKuanYuanYinController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;


- (IBAction)goback:(id)sender;

@end

@implementation CYXuanZeTuiKuanYuanYinController

- (void)viewDidLoad {
    [super viewDidLoad];
    hiddenSepretor(_tableView);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [_dataArr count];
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tuikuanidentify = @"tuikuanyuanyin";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tuikuanidentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tuikuanidentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = _dataArr[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tuikuanyuanyinBlock) {
        self.tuikuanyuanyinBlock(_dataArr[indexPath.row],indexPath.row);
    }
    [self goback:nil];
}


- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
