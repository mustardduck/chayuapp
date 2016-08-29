//
//  CYMyTeaViewController.m
//  茶语
//
//  Created by Leen on 16/3/4.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYMyTeaViewController.h"
#import "CYMyChaPingTableViewCell.h"
#import "CYDuiHuanLiShiController.h"
#import "CYTeaReviewDetailViewController.h"
@interface CYMyTeaViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //已发布
    NSMutableArray *fabuArr;;
    NSInteger page_chaping;
    
    //待审核
    NSMutableArray *shenheArr;;
    NSInteger page_arc;
    
    NSInteger stauts;//0为已发布1为待审核
}

- (IBAction)goback:(id)sender;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UILabel *emptyMsgLbl;

- (IBAction)menu_click:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lin_leading_cons;

@property (weak, nonatomic) IBOutlet UIView *topBg;

@property (weak, nonatomic) IBOutlet UIView *lineView;




@property (weak, nonatomic) IBOutlet UITableView *daishenheTable;

@end

@implementation CYMyTeaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    page_chaping = 1;
    page_arc =1;
    stauts = 0;
    fabuArr =[NSMutableArray array];
    shenheArr = [NSMutableArray array];
    self.title = @"我的茶评";
    hiddenSepretor(_tableView);
    hiddenSepretor(_daishenheTable);
    __weak __typeof(self) weakSelf = self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadwodepinglunData:NO];
        
    }];
    [_tableView.header beginRefreshing];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadwodepinglunData:YES];
    }];
    
    
    
    _daishenheTable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadHuifuwodeData:NO];
        
    }];
    _daishenheTable.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadHuifuwodeData:YES];
    }];
}


-(void)loadwodepinglunData:(BOOL)hasMore
{
    if (hasMore) {
        page_chaping ++;
    }else{
        page_chaping =1 ;
    }
    __weak __typeof(self) weakSelf = self;
    [CYWebClient Post:@"MyComment" parametes:@{@"p":@(page_chaping),@"pageSize":@"10",@"status":@"1"} success:^(id responObj) {
        if (hasMore) {
            [weakSelf.tableView.footer endRefreshing];
        }else{
            [weakSelf.tableView.header endRefreshing];
            [fabuArr removeAllObjects];
            [weakSelf.tableView reloadData];
        }
        NSArray *arr = [responObj objectForKey:@"items"];
        if ([arr count]<10) {
            [weakSelf.tableView.footer endRefreshingWithNoMoreData];
            
        }else{
            [weakSelf.tableView.footer resetNoMoreData];
        }
        
        [fabuArr addObjectsFromArray:arr];
        if(fabuArr.count)
        {
            [weakSelf.tableView reloadData];
            weakSelf.emptyView.hidden = YES;
        }
        else
        {
            weakSelf.emptyView.hidden = NO;
        }
        
        if (fabuArr.count<10) {
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


-(void)loadHuifuwodeData:(BOOL)hasMore{
    //    2.0comment.article_reply
    if (hasMore) {
        page_arc ++;
    }else{
        page_arc =1 ;
    }
    __weak __typeof(self) weakSelf = self;
    [CYWebClient Post:@"MyComment" parametes:@{@"p":@(page_chaping),@"pageSize":@"10",@"status":@"0"} success:^(id responObj) {
        if (hasMore) {
            [weakSelf.daishenheTable.footer endRefreshing];
        }else{
            [weakSelf.daishenheTable.header endRefreshing];
            [shenheArr removeAllObjects];
            [weakSelf.daishenheTable reloadData];
            
        }
        NSArray *arr = [responObj objectForKey:@"items"];
        if ([arr count]<10) {
            [weakSelf.daishenheTable.footer endRefreshingWithNoMoreData];
            
        }else{
            [weakSelf.daishenheTable.footer resetNoMoreData];
        }
        
        [shenheArr addObjectsFromArray:arr];
        
        if(shenheArr.count)
        {
            [weakSelf.daishenheTable reloadData];
            weakSelf.emptyView.hidden = YES;
        }
        else
        {
            weakSelf.emptyView.hidden = NO;
        }
        
        if (shenheArr.count<10) {
            weakSelf.daishenheTable.footer = nil;
        }else{
            [weakSelf.daishenheTable.footer resetNoMoreData];
        }
        
        
    } failure:^(id err) {
        if (hasMore) {
            [weakSelf.daishenheTable.footer endRefreshing];
        }else{
            [weakSelf.daishenheTable.header endRefreshing];
        }
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:self.title];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:self.title];
}
#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (stauts == 0) {
        return [fabuArr count];
    }else{
        return [shenheArr count];
    }
    
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellheight = 125.0;
    NSDictionary *info = nil;
    if (stauts == 0) {
        info = fabuArr[indexPath.row];
        
    }else{
        info = shenheArr[indexPath.row];
    }
    
    NSString *content = [info objectForJSONKey:@"content"];
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14.]};
    CGSize lableSize = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-40,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    cellheight-=17.0;
    cellheight+=lableSize.height+1;
    return cellheight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (stauts == 0) {
        CYMyChaPingTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CYMyChaPingTableViewCell"];
        NSDictionary *info = fabuArr[indexPath.row];
        cell.titleLbl.text = [NSString stringWithFormat:@"[%@]%@",[info objectForKey:@"brand"],[info objectForKey:@"teaTitle"]];
        cell.zongfenLbl.text =[info objectForKey:@"score"];
        cell.contentLbl.text = [info objectForKey:@"content"];
        cell.timeLbl.text = [self dataWithSince:[[info objectForKey:@"created"] doubleValue]];;
        cell.statusLbl.hidden = YES;
        cell.deleteBtn.tag = 6000 +indexPath.row;
        [cell.deleteBtn addTarget:self action:@selector(deletechaping_click:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        CYMyChaPingTableViewCell *cell = [_daishenheTable dequeueReusableCellWithIdentifier:@"CYMyChaPingDaiShenHe"];
        NSDictionary *info = shenheArr[indexPath.row];
        cell.titleLbl.text = [NSString stringWithFormat:@"[%@]%@",[info objectForKey:@"brand"],[info objectForKey:@"teaTitle"]];
        cell.zongfenLbl.text =[info objectForKey:@"score"];
        cell.contentLbl.text = [info objectForKey:@"content"];
        cell.timeLbl.text = [self dataWithSince:[[info objectForKey:@"created"] doubleValue]];;
        cell.deleteBtn.tag = 10000 +indexPath.row;
        [cell.deleteBtn addTarget:self action:@selector(deletedaishenhechaping_click:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
}


-(void)deletechaping_click:(UIButton *)sender
{
    NSInteger selectIndex = sender.tag - 6000;
    //    2.0_comment.tea_delete
    NSDictionary *info = fabuArr[selectIndex];
    //    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:selectIndex];
    NSString *itemId = [info objectForKey:@"id"];
    //    2.0_comment.article_delete
    [CYWebClient basePost:@"2.0_comment.tea_delete" parametes:@{@"id":itemId} success:^(id responObj) {
        NSInteger state = [[responObj objectForKey:@"state"] integerValue];
        if (state == 400) {
            [fabuArr removeObjectAtIndex:selectIndex];
            [_tableView reloadData];
        }
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
}

-(void)deletedaishenhechaping_click:(UIButton *)sender
{
    NSInteger selectIndex = sender.tag - 10000;
    //    2.0_comment.tea_delete
    NSDictionary *info = shenheArr[selectIndex];
    //    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:selectIndex];
    NSString *itemId = [info objectForKey:@"id"];
    //    2.0_comment.article_delete
    [CYWebClient basePost:@"2.0_comment.tea_delete" parametes:@{@"id":itemId} success:^(id responObj) {
        NSInteger state = [[responObj objectForKey:@"state"] integerValue];
        if (state == 400) {
            [shenheArr removeObjectAtIndex:selectIndex];
            [_daishenheTable reloadData];
        }
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
}

- (NSString *)dataWithSince:(NSTimeInterval )dataString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^{
    //        ];
    //    });
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dataString];
    NSLog(@"1296035591  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info = nil;
    if (stauts == 0) {
        info = fabuArr[indexPath.row];
    }else{
        info = shenheArr[indexPath.row];
    }
    CYTeaReviewDetailViewController *vc = [[CYTeaReviewDetailViewController alloc] initWithNibName:@"CYTeaReviewDetailViewController" bundle:nil];
    vc.mTeaId = [info objectForKey:@"teaid"];
    [self.navigationController pushViewController:vc animated:YES];
    
}




- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)menu_click:(id)sender {
    UIButton *selectButton = (UIButton *)sender;
    
    _emptyView.hidden = YES;
    
    for (int i = 6325; i<6327; i++) {
        UIButton *button = (UIButton *)[_topBg viewWithTag:i];
        if (button.tag == selectButton.tag) {
            button.selected = YES;
        }else{
            button.selected = NO;
        }
    }
    
    
    switch (selectButton.tag) {
        case 6325://已发布
        {
            stauts = 0;
            _tableView.hidden = NO;
            _daishenheTable.hidden = YES;
            if ([fabuArr count]==0) {
                [self loadwodepinglunData:NO];
            }
            
            _emptyMsgLbl.text = @"您暂无茶评记录";
            break;
        }
        case 6326://已待审核
        {
            _tableView.hidden = YES;
            _daishenheTable.hidden = NO;
            stauts =1;
            if ([shenheArr count]==0) {
                [self loadHuifuwodeData:NO];
            }
            _emptyMsgLbl.text = @"您暂无待审核的茶评记录";
            
            break;
        }
            
        default:
            break;
    }
    [UIView animateWithDuration:0.25 animations:^{
        _lin_leading_cons.constant = selectButton.x;
        [_topBg layoutIfNeeded];
    }];
    
}
@end
