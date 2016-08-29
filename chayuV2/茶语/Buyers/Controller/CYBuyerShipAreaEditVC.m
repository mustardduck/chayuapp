//
//  CYBuyerShipAreaEditVC.m
//  茶语
//
//  Created by Leen on 16/7/1.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerShipAreaEditVC.h"
#import "SKSTableViewCell.h"
#import "SKSTableView.h"
#import "CYBuyerShipAreaSubCell.h"
#import "CYIndexPath.h"


@interface CYBuyerShipAreaEditVC ()<SKSTableViewDelegate, CYBuyerShipAreaSubCellDelegate, CYBuyerSKSTableViewCellDelegate>
{
    NSArray * _dataArr;
    NSMutableArray *_selectedIndexArr;

}

@property (weak, nonatomic) IBOutlet UIButton *allAreaBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectAreaBtn;
@property (weak, nonatomic) IBOutlet UIButton *arrowBtn;
@property (weak, nonatomic) IBOutlet SKSTableView *mainTable;

@end

@implementation CYBuyerShipAreaEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _selectedIndexArr = [NSMutableArray array];

    _dataArr = @[
                 @[
                     @[@"海外及港澳台"],
                     @[@"新疆、西藏、内蒙古"],
                     @[@"华东", @"上海",@"江苏", @"浙江", @"安徽", @"山东", @"江西", @"福建"],
                     @[@"华北", @"男装", @"女装"],
                     @[@"华南", @"茶杯", @"茶盒"],
                     @[@"西南", @"日用品"],
                     @[@"东北", @"日用品"],
                     @[@"中部", @"日用品"]]
                 ];
    
    [self initTableView];
    
    [_mainTable reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)touchUpInsideOn:(id)sender {
    UIButton * btn = (UIButton *)sender;
    
    if(btn == _allAreaBtn)
    {
        _allAreaBtn.selected = YES;
        _selectAreaBtn.selected = !_allAreaBtn.selected;

    }
    else if (btn == _selectAreaBtn)
    {
        _selectAreaBtn.selected = YES;
        _allAreaBtn.selected = !_selectAreaBtn.selected;
    }
    
    if(_selectAreaBtn.selected)
    {
        _mainTable.hidden = NO;
    }
    else
    {
        _mainTable.hidden = YES;
    }
}

- (void)initTableView
{
    hiddenSepretor(_mainTable);
    
    _mainTable.shouldExpandOnlyOneCell = YES;
    _mainTable.SKSTableViewDelegate = self;
    
    _mainTable.hidden = YES;
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)selectShipAreaSubCell:(CYBuyerShipAreaSubCell *)cell
{
    NSIndexPath *mIndexPath  = [_mainTable indexPathForCell:cell];
    
    NSIndexPath *correspondingIndexPath = [_mainTable correspondingIndexPathForRowAtIndexPath:mIndexPath];
    
    for (CYIndexPath *myIndexPath in _selectedIndexArr) {
        
        if (correspondingIndexPath.section == myIndexPath.section && correspondingIndexPath.row == myIndexPath.row && correspondingIndexPath.subRow == myIndexPath.subRow) {
            {//取消选中
                [cell.selectBtn setSelected:NO];
                [_selectedIndexArr removeObject:myIndexPath];
                return;
            }
        }
    }
    
    if(_selectedIndexArr.count >= 5)
    {
        [Itost showMsg:@"最多选择 5 项" inView:self.view];
        
        return;
    }
    
    CYIndexPath * test = [CYIndexPath CYIndexPath:correspondingIndexPath.section row:correspondingIndexPath.row subRow:correspondingIndexPath.subRow];
    
    [_selectedIndexArr addObject:test];
    [cell.selectBtn setSelected:YES];    //选中全部 头部选中
}

- (void) selectCellClicked:(SKSTableViewCell *)cell
{
    NSIndexPath *mIndexPath  = [_mainTable indexPathForCell:cell];
    
    NSLog(@"Section: %d, Row:%d, Subrow:%d", mIndexPath.section, mIndexPath.row, mIndexPath.subRow);
    
    for (CYIndexPath *myIndexPath in _selectedIndexArr) {
        
        if (mIndexPath.section == myIndexPath.section && mIndexPath.row == myIndexPath.row && mIndexPath.subRow == myIndexPath.subRow) {
            {//取消选中
                [cell.selectBtn setSelected:NO];
                [_selectedIndexArr removeObject:myIndexPath];
                
                return;
            }
        }
    }
    
    if(_selectedIndexArr.count >= 5)
    {
        [Itost showMsg:@"最多选择 5 项" inView:self.view];
        
        return;
    }
    
    CYIndexPath * test = [CYIndexPath CYIndexPath:mIndexPath.section row:mIndexPath.row subRow:mIndexPath.subRow];
    
    [_selectedIndexArr addObject:test];
    [cell.selectBtn setSelected:YES];    //选中全部 头部选中
    
}

- (void)tableView:(UITableView *)tableView willDisplaySubCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);

    for (CYIndexPath *myIndexPath in _selectedIndexArr)
    {
        NSLog(@"myIndexPath Section: %d, Row:%d, Subrow:%d", myIndexPath.section, myIndexPath.row, myIndexPath.subRow);

        
        if (myIndexPath.section == indexPath.section && myIndexPath.row == indexPath.row && myIndexPath.subRow == indexPath.subRow) {
            
            CYBuyerShipAreaSubCell *myCell = (CYBuyerShipAreaSubCell *)cell;
            myCell.selectBtn.selected = YES;
        }
    }
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKSTableViewCell";
    
    SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier showSelectBtn:YES];
        
        cell.delegate = self;
    }


    NSString * titleName = _dataArr[indexPath.section][indexPath.row][0];
    
    cell.titleLbl.text = titleName;
    //    cell.iconImg.image = [UIImage imageNamed:@""];
    cell.backgroundColor = [UIColor redColor];
    
    UILabel* bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 49.5, tableView.frame.size.width, 0.5)];
    [bottomLine setBackgroundColor:RGBCOLOR(74, 74, 74)];
    [cell.contentView addSubview:bottomLine];
    
    if ((indexPath.section == 0 && (indexPath.row >= 2 && indexPath.row <= 7)))
        cell.expandable = YES;
    else
        cell.expandable = NO;
    
    cell.selectBtn.selected = NO;
    
    return cell;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYBuyerShipAreaSubCell *cell = [CYBuyerShipAreaSubCell cellWidthTableView:tableView];
    
    NSString * subTitle = _dataArr[indexPath.section][indexPath.row][indexPath.subRow];
    
    cell.titleLbl.text = subTitle;
    
    cell.selectBtn.selected = NO;
    
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);
    
}

- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArr count];
}

- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0 && indexPath.row == 0)
//    {
//        return YES;
//    }
    
    return NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr[section] count];
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    return [_dataArr[indexPath.section][indexPath.row] count] - 1;
}

@end
