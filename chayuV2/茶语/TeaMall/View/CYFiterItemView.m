//
//  CYFiterItemView.m
//  茶语
//
//  Created by Chayu on 16/3/17.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYFiterItemView.h"
#import "CYClassicTableViewCell.h"
@interface CYFiterItemView ()<UITableViewDataSource,UITableViewDelegate>
{
    
}

- (IBAction)select_sectionHeader:(id)sender;

@end

@implementation CYFiterItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
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

-(void)selectClass_click:(UIButton *)sender
{
    
}

+(CGFloat)classicViewHeight:(NSArray *)secArr andislast:(BOOL)islast{
    CGFloat height = 0;
    for (int i=0; i<[secArr count]; i++) {
        NSArray *itemarr = secArr[i][@"list"];
        CGFloat cellHeight =[CYClassicTableViewCell cellHeightWithInfo:itemarr andisLast:islast];
        height +=cellHeight;
        NSString *title = secArr[i][@"title"];
        if (title.length >0) {
            height +=45;
        }
    }
    height +=45;
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
    return [CYClassicTableViewCell cellHeightWithInfo:itemArr andisLast:_isLast];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYClassicTableViewCell *cell = [CYClassicTableViewCell cellWidthTableView:tableView];
    __weak __typeof(self) weakSelf = self;
    cell.itemClick = ^(NSDictionary *data,NSIndexPath *selecIndexPath){
        weakSelf.catId = [data objectForKey:@"data"];
        for (int i = 0; i<[_dataArr count]; i++) {
            if (i != selecIndexPath.section) {
                NSIndexPath *cellindexPath = [NSIndexPath indexPathForRow:0 inSection:i];
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:cellindexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }
        
        if ([self.delegate respondsToSelector:@selector(changesearchNum:andIndex:)]) {
            [self.delegate changesearchNum:data andIndex:_indexPath];
        }
        weakSelf.typeLbl.text = [data objectForKey:@"title"];
        
    };
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
        lin.backgroundColor = [UIColor getColorWithHexString:@"f5f5f5"];
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
