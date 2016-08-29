//
//  CYSelectCoupViewController.m
//  茶语
//
//  Created by Chayu on 16/2/25.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYSelectCoupViewController.h"
#import "UILabel+Utilities.h"
#import "UIColor+Additions.h"

@interface CYSelectCoupViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


- (IBAction)goback:(id)sender;

@end

@implementation CYSelectCoupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    hiddenSepretor(_tableView);
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
-(void)viewDidLayoutSubviews
{
    setSepretor(self.tableView);
}
#pragma mark -
#pragma mark UITableViewDataSource method
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
        setCellSepretor();
}


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
    static NSString *selectcoupidentify = @"selectcoup";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:selectcoupidentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sdadad"];
    }
    else
    {
        for(UIView * view in [cell subviews])
        {
            [view removeFromSuperview];
        }
    }
    
    NSDictionary *info = _dataArr[indexPath.row];
    
    cell.textLabel.text = [info objectForKey:@"title"];
    cell.textLabel.font = FONT(16);
    cell.textLabel.hidden = YES;
    
    CGFloat width = cell.textLabel.boundingRectWithWidth + 20;
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, width, 44)];
    if([_selectDic allKeys].count)
    {
        NSString * selectID = [_selectDic objectForJSONKey:@"id"];
        NSString * cellInfoID = [info objectForJSONKey:@"id"];
        
        if([cellInfoID isEqualToString:selectID])
        {
            bgView.backgroundColor = [UIColor brownTitleColor];
            [cell.contentView addSubview:bgView];
            
            UILabel * titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, bgView.width - 20, bgView.height)];
            titleLbl.backgroundColor = [UIColor clearColor];
            titleLbl.textColor = [UIColor whiteColor];
            titleLbl.font = FONT(16);
            titleLbl.text = [info objectForKey:@"title"];
            [bgView addSubview:titleLbl];
        }
        else
        {
            UILabel * titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, bgView.width - 20, bgView.height)];
            titleLbl.backgroundColor = [UIColor clearColor];
            titleLbl.textColor = [UIColor grayDarkerTitleColor];
            titleLbl.font = FONT(16);
            titleLbl.text = [info objectForKey:@"title"];
            [cell.contentView addSubview:titleLbl];
        }
    }
    else
    {
        UILabel * titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, bgView.width - 20, 44)];
        titleLbl.backgroundColor = [UIColor clearColor];
        titleLbl.textColor = [UIColor grayDarkerTitleColor];
        titleLbl.font = FONT(16);
        titleLbl.text = [info objectForKey:@"title"];
        [cell.contentView addSubview:titleLbl];
    }
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSDictionary *info = _dataArr[indexPath.row];
    if (self.block) {
        self.block(info);
    }
    [self goback:nil];
}


- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
