//
//  CYAllEvaluationView.m
//  茶语
//
//  Created by Chayu on 16/4/7.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYAllEvaluationView.h"
//#import "CYEvaluationModel.h"
#import "CYEvaluationCell.h"
@interface CYAllEvaluationView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataArr;
    NSInteger page;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation CYAllEvaluationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
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
    CGFloat cellhegigt =[CYEvaluationCell tableViewCellHeight:model];
    return cellhegigt;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *evaidentify = @"CYEvaluationCell";
    CYEvaluationCell *cell = [tableView dequeueReusableCellWithIdentifier:evaidentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYEvaluationCell" owner:nil options:nil] firstObject];
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
