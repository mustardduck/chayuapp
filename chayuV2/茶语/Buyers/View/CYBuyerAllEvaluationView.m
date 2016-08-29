//
//  CYBuyerAllEvaluationView.m
//  茶语
//
//  Created by Leen on 16/7/29.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerAllEvaluationView.h"
//#import "CYEvaluationCell.h"
#import "CYBuyerEvaluationCell.h"

@interface CYBuyerAllEvaluationView ()<UITableViewDelegate,UITableViewDataSource>

{
    NSMutableArray *_dataArr;
    NSInteger page;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CYBuyerAllEvaluationView

- (void)setGoodsId:(NSString *)goodsId
{
    _goodsId = goodsId;
    if ([_dataArr count] ==0) {
        [self loadTableViewData:NO];
    }
}

- (void)awakeFromNib
{
    page = 1;
    _dataArr =[[NSMutableArray alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    hiddenSepretor(_tableView);
    __weak __typeof(self) weakSelf = self;
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadTableViewData:YES];
    }];
    
    
}


-(void)loadTableViewData:(BOOL)loadMode
{
    if (loadMode) {
        page ++;
    }
    __weak typeof(self) weakSelf = self;
    [CYWebClient Post:@"Comment_list" parametes:@{@"goods_id":_goodsId,@"p":@(page),@"pageSize":@"10"} success:^(id responObj) {
        if ([responObj count] <10) {
            weakSelf.tableView.footer = nil;
        }
        [_dataArr addObjectsFromArray:[CYEvaluationModel objectArrayWithKeyValuesArray:responObj]];
        [weakSelf.tableView reloadData];
        if (loadMode) {
            [weakSelf.tableView.footer endRefreshing];
        }
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
}



#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr count];
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYEvaluationModel *model = _dataArr[indexPath.row];
    CGFloat cellhegigt =[CYBuyerEvaluationCell tableViewCellHeight:model];
    return cellhegigt;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *evaidentify = @"CYBuyerEvaluationCell";
    CYBuyerEvaluationCell *cell = [tableView dequeueReusableCellWithIdentifier:evaidentify];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerEvaluationCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.evaModel = _dataArr[indexPath.row];
    
    return cell;
}

-(void)viewDidLayoutSubviews
{
    
    setSepretor(self.tableView);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    setCellSepretor();
}


#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end

