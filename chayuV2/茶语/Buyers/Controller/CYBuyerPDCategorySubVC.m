//
//  CYBuyerPDCategorySubVC.m
//  茶语
//
//  Created by Leen on 16/8/25.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerPDCategorySubVC.h"
#import "SKSTableView.h"
#import "SKSTableViewCell.h"
#import "CYBuyerPDCategorySubCell.h"
#import "CYIndexPath.h"
#import "UIColor+Additions.h"

@interface CYBuyerPDCategorySubVC ()<SKSTableViewDelegate,CYBuyerPDCategorySubCellDelegate>
{
    NSArray * _dataArr;
    UIButton *rightBtn;
    
    NSMutableArray *_selectedIndexArr;
    
}
@property (nonatomic, retain) UIColor *menuColor;
@property (nonatomic) BOOL isOpen;

@property (weak, nonatomic) IBOutlet SKSTableView *mainTableView;
- (IBAction)goback:(id)sender;

@end


@implementation CYBuyerPDCategorySubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initTableView];
    
    //    _dataArr = [NSMutableArray array];
    _selectedIndexArr = [NSMutableArray array];
    
    [self addNavigationItem];
    
    _dataArr = @[
                 @[
                     @[@"茶叶", @"绿茶",@"乌龙", @"红茶", @"白茶", @"黄茶", @"花茶"],
                     @[@"香道", @"沉香"],
                     @[@"服装", @"男装", @"女装"],
                     @[@"茶器", @"茶杯", @"茶盒"],
                     @[@"其他", @"日用品"]]
                 ];
    
    [_mainTableView reloadData];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_selectedIndexArr removeAllObjects];
    
}

- (void)initTitleView
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0,20, 120, 44)];
    titleView.backgroundColor = CLEARCOLOR;
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0,12, 80, 20)];
    titleLbl.text = @"商品种类";
    titleLbl.x = titleView.center.x-40;
    titleLbl.font = FONT(17.0f);
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.backgroundColor = CLEARCOLOR;
    [titleView addSubview:titleLbl];
    
    self.navigationItem.titleView = titleView;
}

- (void)addNavigationItem
{
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    rightBtn.userInteractionEnabled = NO;
    [rightBtn setTitleColor:CONTENTCOLOR forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(doneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn sizeToFit];
    rightBtn.titleLabel.font = FONT(16.0f);
    //    rightBtn.frame = CGRectMake(0, 0, 80, 44);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

#pragma mark -
#pragma mark CYPDCategorySubCellDelegate method
- (void)selectPDCategorySubCell:(CYBuyerPDCategorySubCell *)cell
{
    NSIndexPath *mIndexPath  = [_mainTableView indexPathForCell:cell];
    
    NSIndexPath *correspondingIndexPath = [_mainTableView correspondingIndexPathForRowAtIndexPath:mIndexPath];
    
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

- (void)tableView:(UITableView *)tableView willDisplaySubCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (CYIndexPath *myIndexPath in _selectedIndexArr) {
        
        if (myIndexPath.section == indexPath.section && myIndexPath.row == indexPath.row && myIndexPath.subRow == indexPath.subRow) {
            
            CYBuyerPDCategorySubCell *myCell = (CYBuyerPDCategorySubCell *)cell;
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

- (void)initTableView
{
    hiddenSepretor(_mainTableView);
    
    _mainTableView.shouldExpandOnlyOneCell = YES;
    _mainTableView.SKSTableViewDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKSTableViewCell";
    
    SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    NSString * titleName = _dataArr[indexPath.section][indexPath.row][0];
    
    cell.titleLbl.text = titleName;
    cell.icon.image = [UIImage imageNamed:@"chayeIconTest"];
    cell.backgroundColor = [UIColor whiteColor];
    cell.titleLbl.textColor = [UIColor blackTitleColor];
    
    
    UILabel* bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 49.5, tableView.frame.size.width, 0.5)];
    [bottomLine setBackgroundColor:RGBCOLOR(74, 74, 74)];
    [cell.contentView addSubview:bottomLine];
    
    if ((indexPath.section == 0 && (indexPath.row == 2 || indexPath.row == 1 || indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 4)))
        cell.expandable = YES;
    else
        cell.expandable = NO;
    
    return cell;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYBuyerPDCategorySubCell *cell = [CYBuyerPDCategorySubCell cellWidthTableView:tableView];
    
    NSString * subTitle = _dataArr[indexPath.section][indexPath.row][indexPath.subRow];
    
    cell.titleLbl.text = subTitle;
    
    cell.delegate = self;
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);
}

- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
    //
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
