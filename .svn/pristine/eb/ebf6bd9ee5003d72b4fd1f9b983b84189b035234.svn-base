//
//  CYSearchViewController.m
//  TeaMall
//
//  Created by Chayu on 15/11/4.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYSearchViewController.h"
#import "CYMasterDetailViewController.h"
#import "CYMerchListVC.h"
#import "BaseButton.h"
#import "CYProductDetViewController.h"
#import "CYTeaReviewDetailViewController.h"
#import "CYArticleDetailViewController.h"
#import "CYArticleInfo.h"
#import "CYTopicDetailController.h"
#import "CYTeaReviewCell.h"
#import "CYHomeArticleCell.h"
#import "CYThemeItemCell.h"
#import "CYHomeInfo.h"
#import "CYMerchCollectionCell.h"
#import "CYTopicDetailController.h"
#import "CYArticleDetailViewController.h"
@interface CYSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UIView *listView;
    NSMutableArray *_dataArr;
    BOOL rigViewShow;
    UIButton *selectBtn;
    NSInteger page;
    NSString *gid;
    NSMutableArray *_publicArr;
    UITapGestureRecognizer *tapGes;
    NSInteger select;
    NSString *searchTypeStr;
    NSMutableArray *keyWordArr;
    NSMutableArray *arcArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)cancel_click:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *publicTableView;

@property (weak, nonatomic) IBOutlet UITextField *inputTxt;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet BaseButton *cleanBtn;
- (IBAction)clean_click:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *titleView;

- (IBAction)showrightItem_click:(id)sender;

- (IBAction)searchtype_click:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right_height;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UIView *rightItemBg;
@property (weak, nonatomic) IBOutlet UILabel *resultnumLbl;

@end

@implementation CYSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _rightItemBg.layer.cornerRadius = 2.0f;
    select = 0;
    page = 1;
    arcArr = [NSMutableArray array];
    keyWordArr = [NSMutableArray array];
    [self.collectionView registerClass:[CYMerchCollectionCell class] forCellWithReuseIdentifier:merchIdentify];
    self.collectionView.collectionViewLayout = [self settingLayout];
    _dataArr = [[NSMutableArray alloc] init];
    _publicArr = [[NSMutableArray alloc] init];
    hiddenSepretor(_tableView);
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.backBarButtonItem = nil;
    [self creatSearchUI];
////
    NSString *type= nil;
    switch (_searchtype) {
        case CYSearchTypeTea:
        {
            _statusLbl.text = @"茶评";
            _inputTxt.placeholder =  @"搜索茶评";
            type = @"Tea";
            break;
        }
        case CYSearchTypeSample:
        {
            _statusLbl.text = @"茶样";
            type = @"Sample";
            _inputTxt.placeholder =  @"搜索茶样";
            break;
        }
        case CYSearchTypeGoods:
        {
            _statusLbl.text = @"市集";
            type = @"Goods";
            _publicTableView.hidden =YES;
            _collectionView.hidden = NO;
             _inputTxt.placeholder =  @"搜索商品";
            break;
        }
        case CYSearchTypeArticle:
        {
            _statusLbl.text = @"文章";
            _searchtype = CYSearchTypeArticle;
            type = @"Article";
            _inputTxt.placeholder =  @"搜索文章";
            break;
        }
        case CYSearchTypeGroupTopic:
        {
            _statusLbl.text = @"话题";
            type = @"GroupTopic";
            _inputTxt.placeholder =  @"搜索话题";
            break;
        }
            
        default:
            break;
    }
    
    [self searchindexhotWords:type];
    searchTypeStr = type;
    
    __weak __typeof(self) weakSelf = self;
    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf searchtype:searchTypeStr andLoadMore:NO];
    }];
//    [_collecationView.header beginRefreshing];
    
    
    _collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       [weakSelf searchtype:searchTypeStr andLoadMore:YES];
    }];
    
    _publicTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf searchtype:searchTypeStr andLoadMore:NO];
    }];
    //    [_collecationView.header beginRefreshing];
    
    
    _publicTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf searchtype:searchTypeStr andLoadMore:YES];
    }];
   
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    ChaYuer *manager =  MANAGER;
    [_dataArr removeAllObjects];
    [_dataArr addObjectsFromArray:manager.searchArr];
//    [_inputTxt becomeFirstResponder];
//    if ([_dataArr count]>0) {
////        _topView.hidden = NO;
//    }else{
//        _tableView.tableFooterView = nil;
////        _topView.hidden = YES;
//    }
    
    [MobClick beginLogPageView:@"搜索"];
    [_tableView reloadData];
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"搜索"];
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self showorHiddenRightItem:NO];
     [self.navigationController setNavigationBarHidden:NO animated:YES];
    [_inputTxt resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)creatBackItem
{
    
}


#pragma mark 设置布局
- (UICollectionViewFlowLayout *)settingLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    // 设置间距
    CGFloat spacing = 5;
    layout.minimumLineSpacing = spacing;
    layout.minimumInteritemSpacing = spacing;
    layout.sectionInset = UIEdgeInsetsMake(spacing, spacing, 0, spacing); // 上部内边距
    
    CGFloat ItemW = (SCREEN_WIDTH - spacing) / 2 - spacing;
    CGFloat ItemH = ItemW;
    CGSize itemSize = CGSizeMake(ItemW, ItemH+90);
    layout.itemSize = itemSize;
    return layout;
    
}



-(void)searchindexhotWords:(NSString *)hotWord
{
//    NSString *url = @"http://app.chayu.alp/chayu/1.0/search/index/hotWords";
    [CYWebClient Post:@"searchindexhotWords" parametes:@{@"type":hotWord} success:^(id responObject) {
        [self loadSearchWordFooterView:responObject];
    } failure:^(id error) {
        
    }];
    
}

-(void)searchtype:(NSString *)type andLoadMore:(BOOL)hasMore
{
        __typeof(self) weakSelf = self;
    if (_inputTxt.text.length == 0) {
        _inputTxt.text = @"";
    }
    
    if (hasMore) {
        page ++;
    }else{
        page = 1;
    }
    
    [CYWebClient Post:@"searchList" parametes:@{@"type":type,@"query":_inputTxt.text,@"pageSize":@"20",@"p":@(page)} success:^(id responObject) {
        NSLog(@"返回结果：%@",responObject);
        weakSelf.resultnumLbl.text = [NSString stringWithFormat:@"共找到%@条数据",[responObject objectForJSONKey:@"total"]];
        if (hasMore) {
            if (_searchtype != CYSearchTypeGoods) {
                [_publicTableView.footer endRefreshing];
            }else{
                [_collectionView.footer endRefreshing];
            }
        }else{
            if (_searchtype != CYSearchTypeGoods) {
                [_publicTableView.header endRefreshing];
            }else{
                [_collectionView.header endRefreshing];
            }
            [_publicArr removeAllObjects];
            [arcArr removeAllObjects];
        }
       
        NSArray *list = [responObject objectForJSONKey:@"hits"];
        if (_searchtype == CYSearchTypeArticle) {
            [_publicArr addObjectsFromArray:[CYHomeToDayNewsInfo objectArrayWithKeyValuesArray:list]];
            [arcArr addObjectsFromArray:list];
        }else if(_searchtype == CYSearchTypeGoods){
            [_publicArr addObjectsFromArray:[CYMerchCellModel objectArrayWithKeyValuesArray:list]];
        }else{
            [_publicArr addObjectsFromArray:list];
        }
        
        if (_searchtype != CYSearchTypeGoods) {
            if ([list count]<20) {
                [_publicTableView.footer endRefreshingWithNoMoreData];
            }else{
                [_publicTableView.footer resetNoMoreData];
            }
            
            if ([_publicArr count] <20) {
                _publicTableView.footer = nil;
            }
            
            [_publicTableView reloadData];

        }else{
           
            if ([list count]<20) {
                [_collectionView.footer endRefreshingWithNoMoreData];
            }else{
                 [_collectionView.footer resetNoMoreData];
            }
            
            if ([_publicArr count] <20) {
                _collectionView.footer = nil;
            }
            
             [_collectionView reloadData];
        }
    } failure:^(id error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#define HGAP 14
#define ITEMWIDTH ((SCREEN_WIDTH-HGAP*5)/4)
#define ITEMHEIGHT 32.
-(void)loadSearchWordFooterView:(NSArray *)itemArr
{
    
    [keyWordArr removeAllObjects];
    [keyWordArr addObjectsFromArray:itemArr];
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    footerView.backgroundColor = MAIN_BGCOLOR;
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 30)];
    contentView.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:contentView];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 20)];
    lable.textColor = TITLECOLOR;
    lable.text = @"大家都在搜";
    lable.font = FONT(14.0);
    [contentView addSubview:lable];
    
    UIView *itemBgView = [[UIView alloc] initWithFrame:CGRectMake(0,30, SCREEN_WIDTH, 1)];
    itemBgView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:itemBgView];
    for (int i =0; i<[itemArr count]; i++) {
        NSInteger row = i%4;
        NSInteger sec = i/4;
        BaseButton *button = [BaseButton initWithStyle:UIButtonTypeCustom Frame:CGRectMake(row*ITEMWIDTH +(1+row)*HGAP,sec * ITEMHEIGHT +(sec +1)*HGAP, ITEMWIDTH, ITEMHEIGHT) Title:itemArr[i] TitleColor:TITLECOLOR Font:FONT(14.0)];
        button.borderColor = [UIColor getColorWithHexString:@"bbbbbb"];
        button.borderWidth = 1.0;
        button.cornerRadius = 2.0;
        button.titleLabel.textAlignment = NSTextAlignmentLeft;
        button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        button.tag = 45000+i;
        [button addTarget:self action:@selector(selectKeyWord:) forControlEvents:UIControlEventTouchUpInside];
        [itemBgView addSubview:button];
    }
    CGFloat item_height = ceilf(itemArr.count/4.) *(ITEMHEIGHT+HGAP)+HGAP;
    itemBgView.height = item_height;
    contentView.height = item_height +30;
    footerView.height = item_height + 40;
    if (keyWordArr.count) {
        self.tableView.tableFooterView = footerView;
        [self.tableView reloadData];
    }else{
        self.tableView.tableFooterView = nil;
    }

    
    
    
}


-(void)selectKeyWord:(BaseButton *)sender
{
    _inputTxt.text = sender.titleLabel.text;
    [_inputTxt resignFirstResponder];
    _view1.hidden = YES;
    _view2.hidden = NO;
    if (_searchtype == CYSearchTypeGoods) {
        _collectionView.hidden = NO;
        _publicTableView.hidden = YES;
    }else{
        _collectionView.hidden = YES;
        _publicTableView.hidden = NO;
    }
     [self searchtype:searchTypeStr andLoadMore:NO];
}

//顶部搜索相关
-(void)creatSearchUI
{
    _titleView.clipsToBounds = YES;
    _titleView.layer.cornerRadius = 3.0f;
}





- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)hiddenKeyBoard:(UITapGestureRecognizer *)sender
{
    [_inputTxt resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//-(void)cancel_click:(UIButton *)sender
//{
//    [self.navigationController popViewControllerAnimated:NO];
//}

-(void)removeAllMessage:(UIButton *)sender
{
    _topView.hidden = YES;
    [_dataArr removeAllObjects];
    _tableView.tableFooterView = nil;
    ChaYuer *user = [ChaYuManager getCurrentUser];
    user.searchArr = _dataArr;
    [ChaYuManager archiveCurrentUser:user];
    [_tableView reloadData];
}
#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tableView) {
        return [_dataArr count];
    }else{
        return [_publicArr count];
    }
    
    
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _publicTableView) {
        switch (_searchtype) {
            case CYSearchTypeTea:
                
                return 133.;
                break;
            case CYSearchTypeSample:
                
                return 119.;
                break;
            case CYSearchTypeArticle:
                
                return 101.;
                break;
            case CYSearchTypeGroupTopic:

                return [CYThemeItemCell cellHeightWithInfo:_publicArr[indexPath.row]];
                break;
    
            default:
                return 10;
                break;
        }
    }else{
      return 45.f;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView == _tableView) {
        static NSString *searchidentify = @"searchidentify";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchidentify];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchidentify];
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 1)];
            view.backgroundColor = BORDERCOLOR;
            [cell.contentView addSubview:view];
        }
        cell.textLabel.textColor = TITLECOLOR;
        cell.textLabel.text = _dataArr[indexPath.row];
        return cell;
    }else{
        if (_searchtype == CYSearchTypeTea) {
            CYTeaReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYTeaReviewCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"CYTeaReviewCell" owner:nil options:nil] firstObject];
            }
            [cell parseData:_publicArr[indexPath.row]];
            return cell;
        }else if (_searchtype == CYSearchTypeSample){
            
            return nil;
            
        }else if (_searchtype == CYSearchTypeArticle){
            CYHomeArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYHomeArticleCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"CYHomeArticleCell" owner:nil options:nil] firstObject];
            }

            CYHomeToDayNewsInfo *info = _publicArr[indexPath.row];
            [cell parseData:info];
            
            return cell;
        
        }else if (_searchtype == CYSearchTypeGroupTopic){
            CYThemeItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYThemeItemCell"];
            cell.itemInfo = _publicArr[indexPath.row];
            return cell;
        }else{
            return nil;
        }
    }
    
   
    
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tableView == tableView) {
        [_inputTxt resignFirstResponder];
        _inputTxt.text = _dataArr[indexPath.row];
        ChaYuer *user = [ChaYuManager getCurrentUser];
        [_dataArr exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        user.searchArr = _dataArr;
        
        
        [ChaYuManager archiveCurrentUser:user];
        [tableView reloadData];
        _view1.hidden = YES;
        _view2.hidden = NO;
        if (_searchtype == CYSearchTypeGoods) {
            _collectionView.hidden = NO;
            _publicTableView.hidden = YES;
        }else{
            _collectionView.hidden = YES;
            _publicTableView.hidden = NO;
        }
       [self searchtype:searchTypeStr andLoadMore:NO];
    }else{
        switch (_searchtype) {
            case CYSearchTypeTea:
            {
                NSDictionary *info = _publicArr[indexPath.row];
                CYTeaReviewDetailViewController *vc = [[CYTeaReviewDetailViewController alloc] initWithNibName:@"CYTeaReviewDetailViewController" bundle:nil];
                vc.mTeaId = [info objectForKey:@"teaid"];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case CYSearchTypeSample:
            {
//                        NSDictionary *info = _publCYEvaListViewControllericArr[indexPath.row];
//                CYTeaSampleDetailViewController *vc = [[CYTeaSampleDetailViewController alloc] initWithNibName:@"CYTeaSampleDetailViewController" bundle:nil];
//                vc.mSampleid = [info objectForKey:@"teaid"];
//                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case CYSearchTypeGoods:
            {
                

                break;
            }
            case CYSearchTypeArticle:
            {
                NSDictionary *info = arcArr[indexPath.row];
                CYHomeToDayNewsInfo *newsInfo = _publicArr[indexPath.row];
                CYArticleInfo *articleInfo = [CYArticleInfo new];
                articleInfo.itemid = [info objectForKey:@"itemid"];
                articleInfo.title = newsInfo.title;
                CYArticleDetailViewController *vc = [[CYArticleDetailViewController alloc] initWithNibName:@"CYArticleDetailViewController" bundle:nil];
                vc.mArticleInfo = articleInfo;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case CYSearchTypeGroupTopic:
            {
                NSDictionary *info = _publicArr[indexPath.row];
                CYTopicDetailController *vc = viewControllerInStoryBoard(@"CYTopicDetailController", @"BBS");
                vc.tid = [info objectForKey:@"tid"];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
                
            default:
                break;
        }
    }
    
}


#pragma mark -
#pragma mark UICollectionViewDataSource method

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _publicArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYMerchCollectionCell *cell = [CYMerchCollectionCell cellWithCollectionView:collectionView ItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    //    cell.backgroundColor = MAIN_BGCOLOR;
    CYMerchCellModel *merchModel = _publicArr[indexPath.item];
    cell.merchModel = merchModel;
    return cell;
}


#pragma mark -
#pragma mark UICollectionViewDelegate method
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CYMerchCellModel *info = _publicArr[indexPath.item];
    CYProductDetViewController *vc= viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
    vc.goodId = info.goods_id;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -
#pragma mark UITextFieldDelegate method
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *strUrl = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (strUrl.length == 0) {
        [Itost showMsg:@"输入的关键字不能为空" inView:self.view];
        return NO;
    }
    _view1.hidden = YES;
    _view2.hidden = NO;
    _topView.hidden = NO;
    [textField resignFirstResponder];
    
    ChaYuer *user = [ChaYuManager getCurrentUser];
    NSMutableArray *searchArr= [[NSMutableArray alloc] init];
    [searchArr addObjectsFromArray:user.searchArr];
    [searchArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:textField.text]) {
            [searchArr removeObject:obj];
        }
    }];
        [searchArr insertObject:textField.text atIndex:0];
        user.searchArr = searchArr;
        [ChaYuManager archiveCurrentUser:user];
    [_dataArr removeAllObjects];
    [_dataArr addObjectsFromArray:user.searchArr];
    [_tableView reloadData];
    

    
    [self searchtype:searchTypeStr andLoadMore:NO];
    
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    _view2.hidden = YES;
    _view1.hidden = NO;
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (_right_height.constant == 225.0) {
         [self showorHiddenRightItem:NO];
    }
   
}

-(void)gotoMerchList
{
    CYMerchListVC *vc = viewControllerInStoryBoard(@"CYMerchListVC", @"TeaMall");
    vc.searchTitle = _inputTxt.text;
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)cancel_click:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)clean_click:(id)sender {

    [self removeAllMessage:nil];

}

- (IBAction)showrightItem_click:(id)sender {
    if (_right_height.constant == 225.0) {
        [self showorHiddenRightItem:NO];
    }else{
        [self showorHiddenRightItem:YES];
    }
}

-(void)showorHiddenRightItem:(BOOL)show
{
    [UIView animateWithDuration:0.25 animations:^{
        if (show) {
            _right_height.constant = 225.;
        }else{
            _right_height.constant = 0.0f;
        }
        [self.view layoutIfNeeded];
       
    }];
}

- (IBAction)searchtype_click:(UIButton *)sender {
    
    [_inputTxt resignFirstResponder];
    _view1.hidden = NO;
    _view2.height = YES;
    NSString *type = nil;
    _publicTableView.hidden = NO;
    _collectionView.hidden = YES;
    switch (sender.tag) {
        case 7000:
        {
            _searchtype = CYSearchTypeTea;
            type = @"Tea";
            _statusLbl.text = @"茶评";
            _inputTxt.placeholder =  @"搜索茶评";
            
            break;
        }
        case 7001:
        {
              _searchtype = CYSearchTypeSample;
            type = @"Sample";
            _statusLbl.text = @"茶样";
            _inputTxt.placeholder =  @"搜索茶样";
            break;
        }
        case 7002:
        {
            _collectionView.hidden = NO;
            _publicTableView.hidden = YES;
              _searchtype = CYSearchTypeGoods;
            type = @"Goods";
            _statusLbl.text = @"市集";
            _inputTxt.placeholder =  @"搜索商品";
            break;
        }
        case 7003:
        {
              _searchtype = CYSearchTypeArticle;
            type = @"Article";
            _statusLbl.text = @"文章";
             _inputTxt.placeholder =  @"搜索文章";
            break;
        }
        case 7004:
        {
              _searchtype = CYSearchTypeGroupTopic;
            type = @"GroupTopic";
            _statusLbl.text = @"话题";
            _inputTxt.placeholder =  @"搜索话题";
            break;
        }
            
        default:
            break;
    }
    searchTypeStr = type;
    [self searchindexhotWords:searchTypeStr];
    [self showorHiddenRightItem:NO];
    
    
}
@end
