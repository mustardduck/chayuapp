//
//  CYTopicCommentsController.m
//  茶语
//
//  Created by iXcoder on 16/2/20.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTopicCommentsController.h"
#import "CYTopicReplyCell.h"
#import "CYCmmtTopicController.h"
@interface CYTopicCommentsController ()<UITableViewDataSource, UITableViewDelegate>
{
    __block int page;
    __block BOOL needRefresh;
}

@property (nonatomic, weak) IBOutlet UITableView *ctntView;
@property (nonatomic, strong) NSMutableArray *comments;
@property (nonatomic, strong) NSMutableArray *cellHeights;

@property (nonatomic, weak) IBOutlet UIButton *scrollTopBtn;
- (IBAction)onShowScrollTopAction:(id)sender;

@property (nonatomic, weak) IBOutlet UIView *noListTip;

- (IBAction)huifu_click:(id)sender;



@end

@implementation CYTopicCommentsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"全部回复";
    
    self.comments = [NSMutableArray array];
    self.cellHeights = [NSMutableArray array];
    self.ctntView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadComments];
    }];
    self.ctntView.header.lastUpdatedTimeKey = [NSString stringWithFormat:@"%@lastHeaderKey", self.tid];
    self.ctntView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreComments];
    }];
    
    self.ctntView.tableFooterView = [UIView new];
    
    self.scrollTopBtn.layer.cornerRadius = 20.f;
    self.scrollTopBtn.layer.masksToBounds = YES;
    self.scrollTopBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.scrollTopBtn.layer.borderWidth = 1.f;
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"全部回复"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
      [MobClick beginLogPageView:@"全部回复"];
    if (self.comments.count == 0 || needRefresh) {
        [self.ctntView.header beginRefreshing];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *idxPath = [self.ctntView indexPathForSelectedRow];
    NSDictionary *replyInfo = [self.comments objectAtIndex:idxPath.row];
    UIViewController *destVC = segue.destinationViewController;
    NSString *tid = [replyInfo objectForKey:@"tid"];
    [destVC setValue:tid forKey:@"tid"];
    NSString *rpid = [replyInfo objectForKey:@"pid"];
    [destVC setValue:rpid forKey:@"rpid"];
    void (^callback)(NSInteger) = ^(NSInteger count) {
        [self loadComments];
        if (self.callback) {
            self.callback(0);
        }
    };
    [destVC setValue:callback forKey:@"callback"];
    
}

#pragma mark - self defined methods

- (void)loadComments
{
    page = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.tid) {
        [params setObject:self.tid forKey:@"tid"];
    }
    [params setObject:@(page) forKey:@"p"];
    [params setObject:@"20" forKey:@"pageSize"];
    
    [CYWebClient Post:@"bbs_topic_comments" parametes:params success:^(id responObject) {
        [self.cellHeights removeAllObjects];
        [self.comments removeAllObjects];
        [self.comments addObjectsFromArray:responObject];
        [self.ctntView reloadData];
        [self.ctntView.header endRefreshing];
        if (self.comments.count == 0) {
//            self.view bringSubviewToFront:<#(nonnull UIView *)#>
            [self.view insertSubview:self.noListTip atIndex:1];
        } else {
            [self.view sendSubviewToBack:self.noListTip];
        }
        
        if ([responObject count] < 20) {
            self.ctntView.footer =nil;
        } else {
            self.ctntView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [self loadMoreComments];
            }];
        }
        
    } failure:^(id error) {
        page = MAX(1, --page);
        [self.ctntView.header endRefreshing];
        if (self.comments.count > 0) {
            [self.view bringSubviewToFront:self.noListTip];
        } else {
            [self.view sendSubviewToBack:self.noListTip];
        }
    }];
}

- (void)loadMoreComments
{
    page ++;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.tid) {
        [params setObject:self.tid forKey:@"tid"];
    }
    [params setObject:@(page) forKey:@"p"];
    [params setObject:@"20" forKey:@"pageSize"];
    
    [CYWebClient Post:@"bbs_topic_comments" parametes:params success:^(id responObject) {
        [self.comments addObjectsFromArray:responObject];
        [self.ctntView reloadData];
        if ([responObject count] < 20) {
            self.ctntView.footer =nil;
        } else {
            self.ctntView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [self loadMoreComments];
            }];
        }
        self.noListTip.hidden = self.comments.count > 0;
        if (self.comments.count > 0) {
//            [self.view bringSubviewToFront:self.noListTip];
        } else {
            [self.view sendSubviewToBack:self.noListTip];
        }
    } failure:^(id error) {
        page --;
        [self.ctntView.footer endRefreshing];
        self.noListTip.hidden = self.comments.count > 0;
        if (self.comments.count > 0) {
//            [self.view bringSubviewToFront:self.noListTip];
        } else {
            [self.view sendSubviewToBack:self.noListTip];
        }
    }];
}

- (void)approvePost:(NSDictionary *)postInfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *pid = [postInfo objectForKey:@"pid"];
    if (pid) {
        [params setObject:pid forKey:@"itemid"];
    }
    [params setObject:@"11" forKey:@"type"];
    
    
    __block BOOL hasZan = NO;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableArray *list = [NSMutableArray arrayWithArray:[user objectForKey:@"zan"]];
    [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSData *data = obj;
        NSDictionary *info1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if ([[info1 objectForKey:@"id"] isEqualToString:pid]) {
            hasZan = YES;
        }
    }];
    if (hasZan) {
        [params setObject:@"0" forKey:@"class"];
    }else{
        [params setObject:@"1" forKey:@"class"];
    }
    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD show];
    [CYWebClient Post:@"do_suport" parametes:params success:^(id responObject) {
        if ([[responObject objectForKey:@"do"] integerValue] ==0) {
//            _zanimg.highlighted = NO;
//            _zanLbl.textColor = CONTENTCOLOR;
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSData *data = obj;
                NSDictionary *info = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                if ([[info objectForKey:@"id"] isEqualToString:pid]) {
                    [list removeObjectAtIndex:idx];
                }
            }];
            
        }else{
            NSMutableDictionary *info = [NSMutableDictionary dictionary];
            [info setObject:pid forKey:@"id"];
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:info];
            [list addObject:data];
        }
        
        
        NSArray *resList = [NSArray arrayWithArray:list];
        [user setObject:resList forKey:@"zan"];
        
        [self loadComments];
     } failure:^(id error) {
     }];
    
    
//    [CYWebClient Post:@"bbs_post_praise" parametes:params success:^(id responObject) {
//        NSNumber *praise = [responObject objectForKey:@"praises"];
//        NSMutableDictionary *pi = [NSMutableDictionary dictionaryWithDictionary:postInfo];
//        [pi setObject:praise forKey:@"praises"];
//        NSUInteger idx = [self.comments indexOfObject:postInfo];
//        if (idx <= [self.comments count]) {
//               [self.comments replaceObjectAtIndex:idx withObject:pi];
//        }
//     
//        [self.ctntView reloadData];
//    } failure:^(id error) {
//        
//    }];
}

- (void)replyPost:(NSDictionary *)postInfo
{
    
    CYCmmtTopicController *destVC =viewControllerInStoryBoard(@"CYCmmtTopicController", @"BBS");
    destVC.tid = self.tid;
    destVC.rpid = [postInfo objectForKey:@"pid"];
    void (^callback)(NSInteger) = ^(NSInteger count){
        [self loadComments];
    };
    destVC.callback = callback;
    [self.navigationController pushViewController:destVC animated:YES];
//    [self performSegueWithIdentifier:@"showAddPostCmmtSegue" sender:nil];
}

#pragma mark - UITableViewDataSource method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYTopicReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYTopicReplyCell"];
    cell.praiseCallback = ^(NSDictionary *postInfo) {
        [self approvePost:postInfo];
    };
    cell.replyCallback = ^(NSDictionary *postInfo) {
        [self replyPost:postInfo];
    };
    return cell;
}

#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.cellHeights.count) {
        return [self.cellHeights[indexPath.row] floatValue];
    } else {
        NSDictionary *itemInfo = [self.comments objectAtIndex:indexPath.row];
        CGFloat height = [CYTopicReplyCell cellHeightWithInfo:itemInfo];
        [self.cellHeights addObject:@(height)];
        return height;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYTopicReplyCell *replyCell = (CYTopicReplyCell *)cell;
    replyCell.itemInfo = [self.comments objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
#define SHOW_BTN_OFFSET 1000
#define SHOW_BTN_OFFSET_ABS 100
    CGFloat yOffset = scrollView.contentOffset.y;
    self.scrollTopBtn.hidden = yOffset < SHOW_BTN_OFFSET - SHOW_BTN_OFFSET_ABS;
    if (!self.scrollTopBtn.hidden) {
        self.scrollTopBtn.alpha = MIN(1., yOffset - SHOW_BTN_OFFSET_ABS + 100) / 100 * 1.;
    }
}

#pragma mark - self defined method
- (IBAction)onShowScrollTopAction:(id)sender
{
    [self.ctntView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                         atScrollPosition:UITableViewScrollPositionTop
                                 animated:YES];
}

- (IBAction)huifu_click:(id)sender {
    CYCmmtTopicController *destVC =viewControllerInStoryBoard(@"CYCmmtTopicController", @"BBS");
    destVC.tid = self.tid;
    void (^callback)(NSInteger) = ^(NSInteger count){
         [self loadComments];
    };
    destVC.callback = callback;
    [self.navigationController pushViewController:destVC animated:YES];
}
@end
