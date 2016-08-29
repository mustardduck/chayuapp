//
//  CYSelectWeiQuanController.m
//  茶语
//
//  Created by Chayu on 16/7/21.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYSelectWeiQuanController.h"
#import "CYSelectWeiQuanHeader.h"
#import "CYSelectWeiQuanCell.h"
@interface CYSelectWeiQuanController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataArr;
    NSInteger page;
}

- (IBAction)goback:(id)sender;


@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation CYSelectWeiQuanController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr = [NSMutableArray array];
    page = 1;
//    2.0_user.rights.chooseOrder
    
    __weak __typeof(self) weakSelf = self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadWeiQuanListData:NO];
        
    }];
    [_tableView.header beginRefreshing];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadWeiQuanListData:YES];
    }];
    
}


//维权列表
-(void)loadWeiQuanListData:(BOOL)hasMore
{
    //    2.0_shiji.rights
    
    if (hasMore) {
        page ++;
    }else{
        page =1 ;
    }
    __weak __typeof(self) weakSelf = self;
    [CYWebClient Post:@"2.0_user.rights.chooseOrder" parametes:@{@"p":@(page),@"pageSize":@"10"} success:^(id responObj) {
        if (hasMore) {
            [weakSelf.tableView.footer endRefreshing];
        }else{
            [weakSelf.tableView.header endRefreshing];
            [dataArr removeAllObjects];
            [weakSelf.tableView reloadData];
        }
        NSArray *arr = responObj;
        if ([arr count]<10) {
            [weakSelf.tableView.footer endRefreshingWithNoMoreData];
            
        }else{
            [weakSelf.tableView.footer resetNoMoreData];
        }
        
        [dataArr addObjectsFromArray:arr];
        [weakSelf.tableView reloadData];
        
        if (dataArr.count<10) {
            weakSelf.tableView.footer = nil;
        }else{
            [weakSelf.tableView.footer resetNoMoreData];
        }
    } failure:^(id err) {
        if (hasMore) {
            [weakSelf.tableView.footer endRefreshing];
        }else{
            [weakSelf.tableView.header endRefreshing];
        }
    }];
    
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
    NSDictionary *info = dataArr[section];
    NSArray *goodsList = [info objectForKey:@"goodsList"];
    return goodsList.count;
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return [dataArr count];
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CYSelectWeiQuanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYSelectWeiQuanCell"];
    NSDictionary *info = dataArr[indexPath.section];
    NSArray *goodsList = [info objectForKey:@"goodsList"];
    NSDictionary *goodsInfo = goodsList[indexPath.row];
    NSString *thumb = [goodsInfo objectForJSONKey:@"thumb"];
    if (thumb.length>0) {
        [cell.showImg sd_setImageWithURL:[NSURL URLWithString:thumb] placeholderImage:SQUARE];
    }
    
    cell.contentLbl.text = [goodsInfo objectForJSONKey:@"goods_name"];
//    NSString *
    cell.guigeLbl.text = [goodsInfo objectForJSONKey:@"spec"];
    ;
    cell.priceLbl.text = [NSString stringWithFormat:@"￥%.2f",[[goodsInfo objectForJSONKey:@"price_sell"] floatValue]];
    cell.numLbl.text = [NSString stringWithFormat:@"x%@",[goodsInfo objectForJSONKey:@"goods_number"]];
    
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CYSelectWeiQuanHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"CYSelectWeiQuanHeader" owner:nil options:nil] firstObject];
    NSDictionary *info = dataArr[section];
    NSString *orderStr = [info objectForJSONKey:@"order_sn"];
    if ([orderStr isEqualToString:_selectOrderStr]) {
        header.statusImg.highlighted = YES;
    }else{
        header.statusImg.highlighted = NO;
    }
    header.bianhaoLbl.text = [NSString stringWithFormat:@"订单编号：%@",orderStr];
    header.selectBtn.tag = 500 +section;
    [header.selectBtn addTarget:self action:@selector(selectOrder:) forControlEvents:UIControlEventTouchUpInside];
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.0f;
}

-(void)selectOrder:(UIButton *)sender
{
    NSDictionary *info = dataArr[sender.tag - 500];
    NSString *orderStr = [info objectForJSONKey:@"order_sn"];
    if (self.backInfoBlock) {
        self.backInfoBlock(orderStr);
    }
    _selectOrderStr = orderStr;
    [self goback:nil];
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
