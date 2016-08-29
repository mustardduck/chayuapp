//
//  CYSelectCityView.m
//  茶语
//
//  Created by Chayu on 16/3/21.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYSelectCityView.h"
#import "CYCityTableViewCell.h"
@interface CYSelectCityView ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataArr;
    NSString *selectcityId;
    NSInteger selectindex;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)back:(id)sender;

@end

@implementation CYSelectCityView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    selectindex = 0;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    hiddenSepretor(_tableView);
    dataArr = [NSMutableArray array];
    selectcityId = @"北京";
    NSArray *titleArr = @[@"北京",@"上海",@"天津",@"重庆",@"河北",@"山西",@"内蒙古",@"黑龙江",@"吉林",@"辽宁",@"山东",@"江苏",@"浙江",@"安徽",@"福建",@"河南",@"湖北",@"湖南",@"江西",@"四川",@"云南",@"贵州",@"西藏",@"宁夏",@"新疆",@"青海",@"陕西",@"甘肃",@"广东",@"广西",@"海南",@"香港",@"澳门",@"台湾",@"海外",];
    for (int i = 0; i<[titleArr count]; i++) {
        NSString *cityId = [NSString stringWithFormat:@"%d",(int)i+1];
        BOOL selected = i==0?YES:NO;
       [dataArr addObject:@{@"id":cityId,@"title":titleArr[i],@"select":[NSNumber numberWithBool:selected]}];
       
    }
    
 
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self back:nil];
}

- (IBAction)back:(id)sender {
    
    if (_selectCityBlock) {
        _selectCityBlock(selectcityId);
    }
    [UIView animateWithDuration:0.25 animations:^{
        
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
            [cell setPreservesSuperviewLayoutMargins:NO];
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
}

#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArr count];
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYCityTableViewCell *cell = [CYCityTableViewCell cellWidthTableView:tableView];
    cell.titleStr = dataArr[indexPath.row][@"title"];
    cell.isSelect = [dataArr[indexPath.row][@"select"] boolValue];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectcityId = dataArr[indexPath.row][@"title"];
    for (int i =0; i<[dataArr count]; i++) {
        NSMutableDictionary *info = [NSMutableDictionary dictionaryWithDictionary:dataArr[i]];
        BOOL isSelect = [[info objectForKey:@"select"] boolValue];
        if (indexPath.row == i && isSelect == NO) {
            [info setObject:[NSNumber numberWithBool:YES] forKey:@"select"];
            [dataArr replaceObjectAtIndex:i withObject:info];;
        }else{
            [info setObject:[NSNumber numberWithBool:NO] forKey:@"select"];
            [dataArr replaceObjectAtIndex:i withObject:info];
        }
        
    }
    [_tableView reloadData];
    
}


@end
