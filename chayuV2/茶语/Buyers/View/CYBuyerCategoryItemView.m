//
//  CYBuyerCategoryItemView.m
//  茶语
//
//  Created by Leen on 16/5/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerCategoryItemView.h"
#import "CYBuyerCateItemCell.h"

@interface CYBuyerCategoryItemView ()<UITableViewDataSource,UITableViewDelegate>
{
    
}

- (IBAction)select_sectionHeader:(id)sender;

@end

@implementation CYBuyerCategoryItemView

- (void)awakeFromNib
{
    _tableView.dataSource = self;
    _tableView.delegate = self;
    hiddenSepretor(_tableView);
}
- (void)setIsLast:(BOOL)isLast
{
    _isLast = isLast;
}
- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    [_tableView reloadData];
}

- (void)setInfo:(NSDictionary *)info
{
    _info = info;
    
}

+(CGFloat)classicViewHeight:(NSArray *)secArr andislast:(BOOL)islast isAddLastBtn:(BOOL)isAddLastBtn
{
    CGFloat height = 0;
    for (int i=0; i<[secArr count]; i++) {
        NSArray *itemarr = secArr[i][@"list"];
        
        NSInteger itemCount = isAddLastBtn ? itemarr.count + 1 : itemarr.count;
        
        CGFloat cellHeight =[CYBuyerCateItemCell cellHeightWithInfo:itemCount andisLast:islast];
        
        height +=cellHeight;
        NSString *title = secArr[i][@"title"];
        if (title.length >0) {
            height +=45;
        }
    }
    height +=45 + 15;
    return height;
}
#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return [_dataArr count];
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *itemArr =_dataArr[indexPath.section][@"list"];
    NSInteger count = _isAddLastBtn ? itemArr.count + 1 : itemArr.count;
    
    return [CYBuyerCateItemCell cellHeightWithInfo:count andisLast:_isLast];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYBuyerCateItemCell *cell = [CYBuyerCateItemCell cellWidthTableView:tableView];
    __weak __typeof(self) weakSelf = self;
    cell.itemClick = ^(NSDictionary *data,NSIndexPath *selecIndexPath){
        
        NSString * str = [data objectForKey:@"type"];
        
        if(str.length)
        {
            if ([self.delegate respondsToSelector:@selector(addAreaBtnClicked)]) {
                [self.delegate addAreaBtnClicked];
            }
        }
        else
        {
            weakSelf.catId = [data objectForKey:@"data"];
            for (int i = 0; i<[_dataArr count]; i++) {
                if (i != selecIndexPath.section) {
                    NSIndexPath *cellindexPath = [NSIndexPath indexPathForRow:0 inSection:i];
                    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:cellindexPath] withRowAnimation:UITableViewRowAnimationNone];
                }
            }
            weakSelf.typeLbl.text = [data objectForKey:@"title"];
        }

    };
    
    cell.isAddLastBtn = _isAddLastBtn;
    cell.itemArr = _dataArr[indexPath.section][@"list"];
    cell.catId = _catId;
    cell.isAllClass = NO;
    cell.cellIndePath = indexPath;

    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = _dataArr[section][@"title"];
    if (title.length>0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(14, 14,SCREEN_WIDTH-14,15)];
        titleLbl.font = FONT(14.0);
        titleLbl.textColor = CONTENTCOLOR;
        titleLbl.text = [NSString stringWithFormat:@"· %@",title];
        [headerView addSubview:titleLbl];
        return headerView;
    }else{
        return nil;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *title = _dataArr[section][@"title"];
    if (title.length>0) {
        return 30;
    }else{
        return 0.0000001;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    NSString *title = _dataArr[section][@"title"];
    if (title.length>0) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
        UIView *lin = [[UIView alloc] initWithFrame:CGRectMake(14,14,SCREEN_WIDTH-28,0.5)];
//        lin.backgroundColor = [UIColor getColorWithHexString:@"f5f5f5"];
        lin.backgroundColor = [UIColor purpleColor];
        [footerView addSubview:lin];
        return footerView;
    }else{
        return nil;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSString *title = _dataArr[section][@"title"];
    if (title.length>0) {
        return 15;
//        return 0;
    }else{
        return 0.0000001;
    }
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (IBAction)select_sectionHeader:(id)sender {
    if ([self.delegate respondsToSelector:@selector(openOrCloseItemView:andView:)]) {
        [self.delegate openOrCloseItemView:_indexPath andView:self];
    }
    
}
@end

