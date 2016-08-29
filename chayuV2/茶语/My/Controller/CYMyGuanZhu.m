//
//  CYMyGuanZhu.m
//  茶语
//
//  Created by Chayu on 16/7/18.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYMyGuanZhu.h"
#import "CYWoDeGuanZhuCell.h"
#import "CYGuanZhuDongTaiCell.h"
#import "CYMasterDetailViewController.h"
#import "CYProductDetViewController.h"
@interface CYMyGuanZhu ()
{
    NSInteger page;
    NSInteger dongtai_page;
    NSInteger status; //状态 0 我的关注 1关注动态
    NSMutableArray *dataArr;
    NSMutableArray *dongtaiArr;
    UIButton *selectBtn;
}


- (IBAction)topmenu_click:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lin_leading_cons;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *topBg;


@property (weak, nonatomic) IBOutlet UITableView *dongtaiTab;

@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UILabel *emptyMsgLbl;

@end

@implementation CYMyGuanZhu

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的关注";
    page = 1;
    dongtai_page = 1;
    dataArr = [NSMutableArray array];
    dongtaiArr = [NSMutableArray array];
    hiddenSepretor(_tableView);
    hiddenSepretor(_dongtaiTab);
    __weak __typeof(self) weakSelf = self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadwodepinglunData:NO];
        
    }];
    [_tableView.header beginRefreshing];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadwodepinglunData:YES];
    }];
    
    
    
    _dongtaiTab.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadHuifuwodeData:NO];
        
    }];
    _dongtaiTab.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadHuifuwodeData:YES];
    }];
    
}

//我的关注
-(void)loadwodepinglunData:(BOOL)hasMore
{
    if (hasMore) {
        page ++;
    }else{
        page =1 ;
    }
    __weak __typeof(self) weakSelf = self;
    [CYWebClient Post:@"2.0_user.attend.seller" parametes:@{@"p":@(page),@"pageSize":@"10"} success:^(id responObj) {
        if (hasMore) {
            [weakSelf.tableView.footer endRefreshing];
        }else{
            [weakSelf.tableView.header endRefreshing];
            [dataArr removeAllObjects];
            [weakSelf.tableView reloadData];
        }
        NSArray *arr = [responObj objectForJSONKey:@"items"];
        if ([arr count]<10) {
            [weakSelf.tableView.footer endRefreshingWithNoMoreData];
            
        }else{
            [weakSelf.tableView.footer resetNoMoreData];
        }
        
        [dataArr addObjectsFromArray:arr];
        
        if(dataArr.count)
        {
            [weakSelf.tableView reloadData];
            weakSelf.emptyView.hidden = YES;
        }
        else
        {
            weakSelf.emptyView.hidden = NO;
        }
        
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

//关注动态
-(void)loadHuifuwodeData:(BOOL)hasMore{
    //    2.0comment.article_reply
    if (hasMore) {
        dongtai_page ++;
    }else{
        dongtai_page =1 ;
    }
    __weak __typeof(self) weakSelf = self;
    [CYWebClient Post:@"2.0_attend.seller_doing" parametes:@{@"p":@(dongtai_page),@"pageSize":@"10"} success:^(id responObj) {
        if (hasMore) {
            [weakSelf.dongtaiTab.footer endRefreshing];
        }else{
            [weakSelf.dongtaiTab.header endRefreshing];
            [dongtaiArr removeAllObjects];
            [weakSelf.dongtaiTab reloadData];
            
        }
        NSArray *arr = [responObj objectForKey:@"items"];
        if ([arr count]<10) {
            [weakSelf.dongtaiTab.footer endRefreshingWithNoMoreData];
            
        }else{
            [weakSelf.dongtaiTab.footer resetNoMoreData];
        }
        
        [dongtaiArr addObjectsFromArray:arr];
        
        if(dongtaiArr.count)
        {
            [weakSelf.dongtaiTab reloadData];
            weakSelf.emptyView.hidden = YES;
        }
        else
        {
            weakSelf.emptyView.hidden = NO;
        }
        
        if (dongtaiArr.count<10) {
            weakSelf.dongtaiTab.footer = nil;
        }else{
            [weakSelf.dongtaiTab.footer resetNoMoreData];
        }
        
        
    } failure:^(id err) {
        if (hasMore) {
            [weakSelf.dongtaiTab.footer endRefreshing];
        }else{
            [weakSelf.dongtaiTab.header endRefreshing];
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
    if (status == 0) {
        return [dataArr count];
    }else{
        return [dongtaiArr count];
    }
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (status == 0) {
        return 70;
    }else{
        return 130.0;
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (status == 0) {
        CYWoDeGuanZhuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYWoDeGuanZhuCell"];
        NSDictionary *info = dataArr[indexPath.row];
        NSString *avatar = [info objectForJSONKey:@"avatar"];
        if (avatar.length) {
            [cell.showImg sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:SQUARE];
        }
        
        cell.nameLbl.text = [info objectForJSONKey:@"realname"];
        cell.contentLbl.text = [info objectForJSONKey:@"description"];
        return cell;
    }else{
        CYGuanZhuDongTaiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYGuanZhuDongTaiCell"];
         NSDictionary *info = dongtaiArr[indexPath.row];
        NSString *avatar = [info objectForJSONKey:@"thumb"];
        if (avatar.length) {
            [cell.showImg sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:SQUARE];
        }
        cell.titleLbl.text = [info objectForJSONKey:@"name"];
        cell.contentLbl.text = [info objectForJSONKey:@"description"];
        cell.nameLbl.text = [info objectForJSONKey:@"realname"];
        cell.priceLbl.text = [NSString stringWithFormat:@"￥%.2f",[[info objectForJSONKey:@"price_sell"] floatValue]];
        cell.saleLbl.text = [NSString stringWithFormat:@"已售%@",[info objectForJSONKey:@"pay_count"]];
        BOOL is_hot = [[info objectForJSONKey:@"is_hot"] integerValue] ==1;
        if (is_hot) {
            cell.statusImg.image = [UIImage imageNamed:@"wode_hot"];
        }else{
            cell.statusImg.image = [UIImage imageNamed:@"wode_new"];
        }
        return cell;
    }

}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (status == 0) {
        NSDictionary *info = dataArr[indexPath.row];
        NSInteger gid = [[info objectForKey:@"gid"] integerValue];
        CYMasterDetailViewController *vc =viewControllerInStoryBoard(@"CYMasterDetailViewController", @"TeaMall");
        if (gid == 9) {
            vc.isMaster = YES;
        }else{
            vc.isMaster = NO;
        }
        
        vc.uid = [info objectForJSONKey:@"uid"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
         NSDictionary *info = dongtaiArr[indexPath.row];
        CYProductDetViewController *vc =viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
        vc.goodId = [[info objectForKey:@"goods_id"] description];
        [self.navigationController pushViewController:vc animated:YES];
    }
}




- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)topmenu_click:(id)sender {
    UIButton *selectButton = (UIButton *)sender;
    
    _emptyView.hidden = YES;
    if (selectButton.tag == 6325) {//我的关注
        status = 0;
        _tableView.hidden = NO;
        _dongtaiTab.hidden = YES;
        if ([dataArr count] ==0) {
            [self loadwodepinglunData:NO];
        }
        
        _emptyMsgLbl.text = @"您暂无关注的人物";
        
    }else{
        status = 1;
        _tableView.hidden = YES;
        _dongtaiTab.hidden = NO;

        if ([dongtaiArr count] == 0) {
            [self loadHuifuwodeData:NO];
        }
        
        _emptyMsgLbl.text = @"您暂无关注动态";

    }
    
    if (selectBtn.tag == selectButton.tag) {
        return;
    }
    
    selectButton.selected = YES;
    selectBtn.selected = NO;
    selectBtn = selectButton;
   
    
    
    [UIView animateWithDuration:0.25 animations:^{
        _lin_leading_cons.constant = selectButton.x;
        [_topBg layoutIfNeeded];
    }];
    
}

@end
