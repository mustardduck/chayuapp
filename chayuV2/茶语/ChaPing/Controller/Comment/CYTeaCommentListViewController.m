//
//  CYTeaCommentListViewController.m
//  茶语
//
//  Created by 李峥 on 16/2/21.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTeaCommentListViewController.h"
#import "CYWriteCommentViewController.h"
#import "CYWriteArticelCommentViewController.h"
#import "CYArticleCommentInfo.h"

#import "CYCommentTableViewAppear.h"
#import "AppDelegate.h"
@interface CYTeaCommentListViewController ()<CommentProtocol>

@property (weak, nonatomic) IBOutlet UIButton *writeCommentBtn;

@end

@implementation CYTeaCommentListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"全部评鉴";
    switch (_mType) {
        case CommentListType_tea:
        {
            if (_mItemId.length) {
                [self initListAction:@"reviewList" params:@{@"teaid":_mItemId}];
            }
           
        }
            break;
        case CommentListType_article:
        {
            self.title = @"全部评论";
            if (_mItemId.length) {
                [self initListAction:@"ArticleCommentList" params:@{@"itemid":_mItemId}];
            }
            [_writeCommentBtn setTitle:@"我要评论" forState:UIControlStateNormal];
        }
            break;
        case CommentListType_sample:
        {
            
        }
            break;
    }
    self.iTable.separatorColor = UIColorFromRGB(0xdddddd);
    self.iTable.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.iTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 73)];
    _writeCommentBtn.backgroundColor = MAIN_COLOR;
    _writeCommentBtn.layer.masksToBounds = YES;
    _writeCommentBtn.layer.cornerRadius = 4;
    [_writeCommentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _writeCommentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
}

- (NSString *)cellNibName
{
    if (_mType == CommentListType_article) {
        return @"CYArticleCommentCell";
    }else if (_mType == CommentListType_sample)
    {
        return @"";
    }
    
    return @"CYTeaCommentCell";
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

- (BOOL)variableCellHeight
{
    return YES;
}

- (BaseTableViewAppear *)tableViewAppear
{
    return [[CYCommentTableViewAppear alloc] init];
}

- (void)tableViewApperDidClicked:(id)data
{
    if (_mType == CommentListType_article) {
        CYArticleCommentInfo *info = data;
        
#pragma Mark - 文章回复评论
        CYWriteArticelCommentViewController *comment = [[CYWriteArticelCommentViewController alloc] initWithNibName:@"CYWriteArticelCommentViewController" bundle: nil];
        comment.mItemid = info.itemid;
        comment.pid = info.commentid;
        comment.touid = info.uid;
        comment.delegate = self;
        [self.navigationController pushViewController:comment animated:YES];
    }else if (_mType == CommentListType_tea)
    {
//        CYEvaCommentInfo *info = [CYEvaCommentInfo objectWithKeyValues:data];
//        CYWriteArticelCommentViewController *comment = [[CYWriteArticelCommentViewController alloc] initWithNibName:@"CYWriteArticelCommentViewController" bundle: nil];
//        comment.isTea = YES;
//        comment.mItemid = _mItemId;
//        comment.pid = info.itemid;
//        comment.touid = info.uid;
//        comment.delegate = self;
//        [self.navigationController pushViewController:comment animated:YES];

    }
}

- (void)tableViewApperButtonDidClicked:(id)data
{
    
    
    if (_mType == CommentListType_tea) {
        CYEvaCommentInfo *info = [CYEvaCommentInfo objectWithKeyValues:data];
       __block BOOL hasZan = NO;
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSMutableArray *list = [NSMutableArray arrayWithArray:[user objectForKey:@"zan"]];
        [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *data = obj;
            NSDictionary *info1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            if ([[info1 objectForKey:@"id"] isEqualToString:info.itemid]) {
                hasZan = YES;
            }
        }];
        NSString *type = hasZan?@"2":@"1";
        NSMutableDictionary *param = [NSMutableDictionary new];
        [param setObject:info.itemid forKey:@"itemid"];
        [param setObject:type forKey:@"class"];
        [CYWebClient Post:@"suport" parametes:param success:^(id responObject) {
            BOOL is_suport = [[responObject objectForKey:@"is_suport"] boolValue];
    
            //            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            //            NSMutableArray *list = [NSMutableArray arrayWithArray:[user objectForKey:@"zan"]];
            if (!is_suport) {
                [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSData *data = obj;
                    NSDictionary *info1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                    if ([[info1 objectForKey:@"id"] isEqualToString:info.itemid]) {
                        [list removeObjectAtIndex:idx];
                    }
                }];
            }else{
                
                NSMutableDictionary *info1 = [NSMutableDictionary dictionary];
                [info1  setObject:info.itemid forKey:@"id"];
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:info1];
                [list addObject:data];
            }
            
            NSArray *resList = [NSArray arrayWithArray:list];
            [user setObject:resList forKey:@"zan"];
            
            [self initListAction:@"reviewList" params:@{@"teaid":_mItemId}];
            
        } failure:^(id error) {
            //            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            //            [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
            //            [SVProgressHUD showErrorWithStatus:@"点赞失败"];
        }];
       
    }else{
        
        CYArticleCommentInfo *info = [CYArticleCommentInfo objectWithKeyValues:data];
        NSString *class =@"";
        if (info.isSuported) {
            class = @"2";
        }else{
            class = @"1";
        }
        [SVProgressHUD setBackgroundColor:CLEARCOLOR];
        [SVProgressHUD setForegroundColor:[UIColor blackColor]];
        [SVProgressHUD show];
        [CYWebClient Post:@"do_suport" parametes:@{@"itemid":info.commentid,@"type":@"10",@"class":class} success:^(id responObject) {
            [self initListAction:@"ArticleCommentList" params:@{@"itemid":_mItemId}];
        } failure:^(id error) {
//            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
//            [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
//            [SVProgressHUD showErrorWithStatus:@"点赞失败"];
        }];
    
    }
 
}

- (IBAction)clickWriteComment:(id)sender {
    if (!MANAGER.isLoged) {
        [APP_DELEGATE showLogView];
        return;
    }
    if (_mItemId.length) {
        if (_mType == CommentListType_article) {
            CYWriteArticelCommentViewController *comment = [[CYWriteArticelCommentViewController alloc] initWithNibName:@"CYWriteArticelCommentViewController" bundle: nil];
            comment.mItemid = self.mItemId;
            [self.navigationController pushViewController:comment animated:YES];
        }else
        {
            CYWriteCommentViewController *comment = [[CYWriteCommentViewController alloc] initWithNibName:@"CYWriteCommentViewController" bundle: nil];
            comment.mItemid = self.mItemId;
            comment.bid = self.mBid;
            comment.backBlock = ^(){
                [self initListAction:@"reviewList" params:@{@"teaid":_mItemId}];
            };
            [self.navigationController pushViewController:comment animated:YES];
        }
    }

    
}

- (void)commentSuccess
{
    [self.iTable startPullRefresh];
}

- (void)showListData:(id)listData refresh:(BOOL)bRefresh{
    
    NSArray *list = nil;
    if ([listData isKindOfClass:[ NSDictionary class]]) {
        id review = [listData objectForKey:@"review"];
        if ([review isKindOfClass:[NSArray class]]) {
            list = review;
        }
    }else if ([listData isKindOfClass:[NSArray class]])
    {
        list = listData;
    }
    
    if (bRefresh) {
        _mTableAppear.iDataSourceArr   = [NSMutableArray arrayWithArray:list];
        if (list.count == 0) {
            self.mNoDataView.hidden = NO;
            [self.view sendSubviewToBack:self.mNoDataView];
            _iTable.hidden = YES;
        }else
        {
            self.mNoDataView.hidden = YES;
            _iTable.hidden = NO;
        }
         [_iTable stopPullRefresh];
    
    }else{
            [_iTable stopLoadMore];
        
        if ([list count] > 0)
        {
            [_mTableAppear appendDataSource:list];
        }
    }
    
    if ([list count] < [self requestCount]) {
         [_iTable.footer endRefreshingWithNoMoreData];
    }else{
        [_iTable.footer  resetNoMoreData];
    }
    
    if (_mTableAppear.iDataSourceArr.count < [self requestCount]) {
        _iTable.footer = nil;
    }
    
    [_iTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
