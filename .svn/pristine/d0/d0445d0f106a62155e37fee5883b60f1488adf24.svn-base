//
//  CYBuyerPDCategoryVC.m
//  茶语
//
//  Created by Leen on 16/6/17.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerPDCategoryVC.h"
#import "SKSTableView.h"
#import "SKSTableViewCell.h"
#import "CYBuyerPDCategoryCell.h"
#import "CYIndexPath.h"
#import "UIColor+Additions.h"


@interface CYBuyerPDCategoryVC () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray * _dataArr;
    UIButton *rightBtn;
    
    NSMutableArray *_selectedIndexArr;

}
@property (nonatomic, retain) UIColor *menuColor;

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
- (IBAction)goback:(id)sender;

@end

@implementation CYBuyerPDCategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    hiddenSepretor(_mainTableView);

//    _dataArr = [NSMutableArray array];
    _selectedIndexArr = [NSMutableArray array];
    
    _dataArr = @[@"茶叶", @"绿茶",@"乌龙", @"红茶", @"白茶", @"黄茶", @"花茶"];
    
    [_mainTableView reloadData];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_selectedIndexArr removeAllObjects];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYBuyerPDCategoryCell *cell = [CYBuyerPDCategoryCell cellWidthTableView:tableView];
    
    [cell.selectBtn setTitle:_dataArr[indexPath.row] forState:UIControlStateNormal];
    
    __weak __typeof(cell) weakCell = cell;
    
    cell.selectBtnBlock = ^()
    {
        for (NSIndexPath *myIndexPath in _selectedIndexArr) {
            
            if (indexPath.section == myIndexPath.section
                && indexPath.row == myIndexPath.row) {
                {//取消选中
                    [weakCell.selectBtn setSelected:NO];
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
        
        [_selectedIndexArr addObject:indexPath];
        [weakCell.selectBtn setSelected:YES];
        
    };

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (NSIndexPath *myIndexPath in _selectedIndexArr) {

        if (myIndexPath.section == indexPath.section && myIndexPath.row == indexPath.row) {
            
            CYBuyerPDCategoryCell *myCell = (CYBuyerPDCategoryCell *)cell;
            myCell.selectBtn.selected = YES;
        }
    }
    
}

-(void)doneBtnClick:(UIButton *)sender
{
    
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
