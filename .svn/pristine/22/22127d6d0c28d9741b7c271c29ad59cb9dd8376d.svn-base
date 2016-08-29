//
//  CYMyGroupViewController.m
//  茶语
//
//  Created by Leen on 16/2/25.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYMyGroupViewController.h"
#import "CYToolBar.h"
#import "CYThemeItemCell.h"
#import "CYTopicItemCell.h"
#import "CYMyCommentCell.h"

#import "CYTopicDetailController.h"
#import "CYTopicListController.h"
#import "CYHuaTiListCell.h"
#import "CYQuanZiListCell.h"
#import "BaseButton.h"
#import "CYQuanZiDetailController.h"
#import "CYPublicQuanZiViewController.h"
@interface CYMyGroupViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger page;
    NSMutableArray *dataArr;
    NSMutableArray *attendArr;
    NSMutableArray *createArr;
    NSMutableArray *managerArr;
    
}

@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UILabel *emptyMsgLbl;

@property (weak, nonatomic) IBOutlet UIView *emptyMyQuanZiView;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lin_leading_cons;

@property (weak, nonatomic) IBOutlet UIView *topBg;
- (IBAction)goback:(id)sender;


@property (weak, nonatomic) IBOutlet UITableView *quanziTable;

@property (weak, nonatomic) IBOutlet UIButton *dongtaiBtn;
@property (weak, nonatomic) IBOutlet UIButton *huatiBtn;
@property (weak, nonatomic) IBOutlet UIButton *quanziBtn;


@end

@implementation CYMyGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"圈子";
    page = 1;
    dataArr =[NSMutableArray array];
    attendArr = [NSMutableArray array];
    createArr = [NSMutableArray array];
    managerArr = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [[UIButton alloc] init];
    if(_quanzitype == WoDeQuanZiTypeHuaTi)
    {
        btn = _huatiBtn;
    }
    else if (_quanzitype == WoDeQuanZiTypeDongTai)
    {
        btn = _dongtaiBtn;
    }
    else if (_quanzitype == WoDeQuanZiTypeQuanZi)
    {
        btn = _quanziBtn;
    }
    
    btn.selected = YES;
    
    [self topmenu_click:btn];
    
//    __weak __typeof(self) weakSelf = self;
//    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf loadQuanZiDongTai:NO];
//        
//    }];
//    [_tableView.header beginRefreshing];
//    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf loadQuanZiDongTai:YES];
//    }];
    
 
//    MyQuanzi
//    2.0.user.group.get_create
//    2.0.user.group.get_manager
//    [self loadwodequanziData];
    
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


-(void)loadwodequanziData
{
    [attendArr removeAllObjects];
    [createArr removeAllObjects];
    [managerArr removeAllObjects];
    
    [CYWebClient Post:@"2.0.user.group" parametes:nil success:^(id responObj) {
        [attendArr addObjectsFromArray:[responObj objectForJSONKey:@"attend"]];
        [createArr addObjectsFromArray:[responObj objectForJSONKey:@"create"]];
        [managerArr addObjectsFromArray:[responObj objectForJSONKey:@"manager"]];
        
        NSInteger count = 0;
        
        if(attendArr.count)
        {
            count ++;
        }
        if(createArr.count)
        {
            count ++;
        }
        if(managerArr.count)
        {
            count ++;
        }
        
        [_quanziTable.header endRefreshing];
        
        if(count)
        {
            [_quanziTable reloadData];
            _emptyMyQuanZiView.hidden = YES;
        }
        else
        {
            _emptyMyQuanZiView.hidden = NO;
        }
        
    } failure:^(id err) {

    }];

}

- (void)loadQuanZiDongTai:(BOOL)hasMore
{
    if (hasMore) {
        page ++;
    }else{
        page =1 ;
    }
    __weak __typeof(self) weakSelf = self;
    [CYWebClient Post:@"MyQuanZiDongTai" parametes:@{@"p":@(page),@"pageSize":@"10"} success:^(id responObj) {
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
//            [weakSelf.tableView.footer];
        }else{
            _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [weakSelf loadQuanZiDongTai:YES];
            }];
        }
        
        
    } failure:^(id err) {
        if (hasMore) {
            [weakSelf.tableView.footer endRefreshing];
        }else{
            [weakSelf.tableView.header endRefreshing];
        }
    }];
    
    
}


//我的话题
-(void)loadwodehuati:(BOOL)hasMore
{
    if (hasMore) {
        page ++;
    }else{
        page =1 ;
    }
    __weak __typeof(self) weakSelf = self;
    [CYWebClient Post:@"MyHuaTi" parametes:@{@"p":@(page),@"pageSize":@"10"} success:^(id responObj) {
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
            [weakSelf.tableView.footer endRefreshingWithNoMoreData];
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
    if (_quanzitype == WoDeQuanZiTypeQuanZi && tableView == _quanziTable) {
        if (section == 0) {
            return [attendArr count];
        }else if (section ==1){
            return [createArr count];
        }else{
            return [managerArr count];
        }
    }else{
        return [dataArr count];
    }
    
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    if (_quanzitype == WoDeQuanZiTypeQuanZi&& tableView == _quanziTable) {
        return 3;
    }else{
        return 1;
    }
   
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_quanzitype == WoDeQuanZiTypeQuanZi&& tableView == _quanziTable) {
        return 110.0f;
    }
    return 131.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_quanzitype == WoDeQuanZiTypeQuanZi&& tableView == _quanziTable) {
        CYQuanZiListCell *cell = [_quanziTable dequeueReusableCellWithIdentifier:@"CYQuanZiListCell"];
//        cell.titleLbl.text =
        NSDictionary *info = nil;
        
        if (indexPath.section == 0) {
            info = attendArr[indexPath.row];
            cell.titleLbl.text = [info objectForKey:@"name"];
            cell.guanzhuLbl.text = [NSString stringWithFormat:@"关注：%@",[info objectForKey:@"attentionnum"]];
            cell.tieziLbl.text = [NSString stringWithFormat:@"帖子：%@",[info objectForKey:@"topics"]];
            NSString *logoStr = [info objectForKey:@"logo"];
            if (logoStr.length) {
                [cell.showimg sd_setImageWithURL:[NSURL URLWithString:logoStr] placeholderImage:SQUARE];
            }
            if (indexPath.row == [attendArr count]-1) {
                cell.linView.hidden = YES;
            }
        }
        return cell;
    }else{
        CYHuaTiListCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CYHuaTiListCell"];
        NSDictionary *info = dataArr[indexPath.row];
        cell.contentLbl.text = [info objectForKey:@"content"];
        cell.titleLbl.text = [info objectForKey:@"subject"];
        cell.pinglunLbl.text =[info objectForJSONKey:@"replies"];
        cell.liulanLbl.text = [info objectForJSONKey:@"hits"];
        
        return cell;
    }
   
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_quanzitype == WoDeQuanZiTypeQuanZi&& tableView == _quanziTable) {
        if (section == 0) {
            UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,45)];
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20,0,150,45)];
            lable.text = @"我关注的圈子";
            lable.font = FONT(16.0);
            lable.textColor = btnTitle_COLOR;
            [header addSubview:lable];
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,44, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = [UIColor getColorWithHexString:@"eeeeee"];
            [header addSubview:lineView];
            return header;
        }else if(section == 1){
            UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,45)];
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20,0,150,45)];
            lable.text = @"我创建的圈子";
            lable.font = FONT(16.0);
            lable.textColor = btnTitle_COLOR;
            [header addSubview:lable];
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,44, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = [UIColor getColorWithHexString:@"eeeeee"];
            [header addSubview:lineView];
            return header;
        }else if(section ==2){
            UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,45)];
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 0,150,45)];
            lable.text = @"我管理的圈子";
            lable.font = FONT(16.0);
            lable.textColor = btnTitle_COLOR;
            [header addSubview:lable];
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,44, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = [UIColor getColorWithHexString:@"eeeeee"];
            [header addSubview:lineView];
            return header;
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_quanzitype == WoDeQuanZiTypeQuanZi&& tableView == _quanziTable) {
        return 45.0;
    }else{
       return 0.0000001;
    }
 
    
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_quanzitype == WoDeQuanZiTypeQuanZi&& tableView == _quanziTable) {
        
        switch (section) {
            case 0:
            {
                if ([attendArr count]>0) {
                    return 65;
                }else{
                    return 165;
                }
                break;
            }
            case 1:
            {
                if ([createArr count]>0) {
                    return 65;
                }else{
                    return 165;
                }
                break;
            }
            case 2:
            {
                if ([managerArr count]>0) {
                    return 65;
                }else{
                    return 165;
                }
                break;
            }
            default:
                return 0.0000001;
                break;
        }
    }else{
        return 0.0000001;
    }
  
    
   
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (_quanzitype == WoDeQuanZiTypeQuanZi&& tableView == _quanziTable) {
        
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
        BaseButton *button = [BaseButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20,0, SCREEN_WIDTH-40, 40);
        button.cornerRadius = 2.0f;
        [button setTitle:@"更多" forState:UIControlStateNormal];
        button.titleLabel.font = FONT(15.0);
        button.tag = 600+section;
        [button setTitleColor:TITLECOLOR forState:UIControlStateNormal];
        [button addTarget:self action:@selector(moreData:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:[UIColor getColorWithHexString:@"eeeeee"]];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 55, SCREEN_WIDTH, 10)];
        line.backgroundColor = [UIColor getColorWithHexString:@"eeeeee"];
        [footer addSubview:line];
        [footer addSubview:button];
        
        
        UIView *modataView  =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 165)];
        modataView.backgroundColor = [UIColor whiteColor];
        UILabel *nomoreLbl = [[UILabel alloc] initWithFrame:modataView.bounds];
        nomoreLbl.height = modataView.height -10;
        nomoreLbl.textAlignment = NSTextAlignmentCenter;
        nomoreLbl.textColor = CONTENTCOLOR;
        nomoreLbl.font = FONT(14.0);
        [modataView addSubview:nomoreLbl];
        UIView *garyView = [[UIView alloc] initWithFrame:CGRectMake(0,modataView.height -10, SCREEN_WIDTH, 10)];
        garyView.backgroundColor = [UIColor getColorWithHexString:@"eeeeee"];
        [modataView addSubview:garyView];
        switch (section) {
            case 0:
            {
                if ([attendArr count]>0) {
                    return footer;
                }else{
                    nomoreLbl.text = @"您暂无关注的圈子";
                    return modataView;
                }
                break;
            }
            case 1:
            {
                if ([createArr count]>0) {
                    return footer;
                }else{
                    nomoreLbl.text = @"您暂无创建的圈子";
                     return modataView;
                }
                break;
            }
            case 2:
            {
                if ([managerArr count]>0) {
                    return footer;
                }else{
                     nomoreLbl.text = @"您暂无管理的圈子";
                     return modataView;
                }
                break;
            }
                
            default:
                return nil;
                break;
        }
    }
    return nil;
 
}

-(void)moreData:(BaseButton *)sender
{
    NSInteger selectIndex = sender.tag-600;
    CYPublicQuanZiViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CYPublicQuanZiViewController"];
    if (selectIndex == 0) {
        vc.quanzitye = CYQuanZiTypeChuangGuanZhu;
    }else if (selectIndex ==1){
         vc.quanzitye = CYQuanZiTypeChuangJian;
    }else{
         vc.quanzitye = CYQuanZiTypeChuangGuanLi;
    }
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView) {
        NSDictionary *info = dataArr[indexPath.row];
        CYTopicDetailController *vc = viewControllerInStoryBoard(@"CYTopicDetailController", @"BBS");
        vc.tid = [info objectForJSONKey:@"tid"];
        vc.gid = @"";//[info objectForKey:@"gid"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if (indexPath.section == 0) {
            NSDictionary *info = attendArr[indexPath.row];
             CYQuanZiDetailController *vc = viewControllerInStoryBoard(@"CYQuanZiDetailController", @"BBS");
            vc.gid = [[info objectForKey:@"gid"] description];
            [self.navigationController pushViewController:vc animated:YES];
        }else if(indexPath.section ==1){
            NSDictionary *info = createArr[indexPath.row];
            CYQuanZiDetailController *vc = viewControllerInStoryBoard(@"CYQuanZiDetailController", @"BBS");
            vc.gid = [[info objectForKey:@"gid"] description];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            NSDictionary *info = managerArr[indexPath.row];
            CYQuanZiDetailController *vc = viewControllerInStoryBoard(@"CYQuanZiDetailController", @"BBS");
            vc.gid = [[info objectForKey:@"gid"] description];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}


- (IBAction)topmenu_click:(id)sender {
    UIButton *selectButton = (UIButton *)sender;
    
    _emptyView.hidden = YES;
    _emptyMyQuanZiView.hidden = YES;
    
    for (int i = 6325; i<6328; i++) {
        UIButton *button = (UIButton *)[_topBg viewWithTag:i];
        if (button.tag == selectButton.tag) {
            button.selected = YES;
        }else{
            button.selected = NO;
        }
    }
    
    switch (selectButton.tag) {
        case 6325:
        {
            _quanziTable.hidden = YES;
            _tableView.hidden = NO;
            _quanzitype = WoDeQuanZiTypeDongTai;
            _emptyMsgLbl.text = @"您暂无圈子动态";
            
            __weak __typeof(self) weakSelf = self;
            _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [weakSelf loadQuanZiDongTai:NO];
                
            }];
            [self loadQuanZiDongTai:NO];
            _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [weakSelf loadQuanZiDongTai:YES];
            }];
            
            break;
        }
        case 6326:
        {
            _quanziTable.hidden = YES;
            _tableView.hidden = NO;
            _quanzitype = WoDeQuanZiTypeHuaTi;
            _emptyMsgLbl.text = @"您暂未发表话题";

            __weak __typeof(self) weakSelf = self;
            _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [weakSelf loadwodehuati:NO];
                
            }];
            [self loadwodehuati:NO];
            _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [weakSelf loadwodehuati:YES];
            }];
            
            break;
        }
        case 6327:
        {
            _quanziTable.hidden = NO;
            _tableView.hidden = YES;
            _quanzitype = WoDeQuanZiTypeQuanZi;
            
            __weak __typeof(self) weakSelf = self;
            _quanziTable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [weakSelf loadwodequanziData];
                
            }];
            [self loadwodequanziData];
            break;
        }
            
        default:
            break;
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.25 animations:^{
            _lin_leading_cons.constant = selectButton.x;
            [_topBg layoutIfNeeded];
        }];
    });

}


- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
