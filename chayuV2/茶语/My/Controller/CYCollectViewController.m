//
//  CYCollectViewController.m
//  茶语
//
//  Created by Chayu on 16/5/23.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYCollectViewController.h"
#import "CYCollectTableViewCell.h"
#import "CYCollectListController.h"

@interface CYCollectViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataArr;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)goback:(id)sender;


@end

@implementation CYCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray array];
   
    hiddenSepretor(_tableView);
    [_dataArr addObject:@{@"img":@"shoucang_chaping",@"title":@"茶评",@"bragenum":@"0"}];
    [_dataArr addObject:@{@"img":@"shoucang_chayang",@"title":@"茶样",@"bragenum":@"0"}];
    [_dataArr addObject:@{@"img":@"shoucang_wenzhang",@"title":@"文章",@"bragenum":@"0"}];
    [_dataArr addObject:@{@"img":@"shoucang_shangping",@"title":@"商品",@"bragenum":@"0"}];
    [_dataArr addObject:@{@"img":@"shoucang_huati",@"title":@"话题",@"bragenum":@"0"}];
}

- (void)viewDidAppear:(BOOL)animated
{
     [self loadData];
}

- (void)loadData
{
    [CYWebClient Post:@"myCollect_count" parametes:nil success:^(id responObject)
     {
//         [_dataArr removeAllObjects];
         
         NSString * article = [responObject objectForJSONKey:@"article"];
         NSString * goods = [responObject objectForJSONKey:@"goods"];
         NSString * tea_comment = [responObject objectForJSONKey:@"tea_comment"];
         NSString * tea_sample = [responObject objectForJSONKey:@"tea_sample"];
         NSString * topic = [responObject objectForJSONKey:@"topic"];
         [_dataArr replaceObjectAtIndex:0 withObject:@{@"img":@"shoucang_chaping",@"title":@"茶评",@"bragenum":tea_comment}];
         [_dataArr replaceObjectAtIndex:1 withObject:@{@"img":@"shoucang_chayang",@"title":@"茶样",@"bragenum":tea_sample}];
          [_dataArr replaceObjectAtIndex:2 withObject:@{@"img":@"shoucang_wenzhang",@"title":@"文章",@"bragenum":article}];
          [_dataArr replaceObjectAtIndex:3 withObject:@{@"img":@"shoucang_shangping",@"title":@"商品",@"bragenum":goods}];
          [_dataArr replaceObjectAtIndex:4 withObject:@{@"img":@"shoucang_huati",@"title":@"话题",@"bragenum":topic}];
         
         [_tableView reloadData];
         
     }failure:^(id error) {
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
    return [_dataArr count];
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *collectionIdentify = @"CYCollectTableViewCell";
    CYCollectTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:collectionIdentify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYCollectTableViewCell" owner:self options:nil] firstObject];
    }
    
    cell.cellInfo = _dataArr[indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYCollectListController *vc = viewControllerInStoryBoard(@"CYCollectListController", @"My");
    vc.collectType = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
