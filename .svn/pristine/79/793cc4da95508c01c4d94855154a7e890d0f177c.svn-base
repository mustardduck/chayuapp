//
//  CYGengDuoLiShiViewController.m
//  茶语
//
//  Created by Chayu on 16/7/25.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYGengDuoLiShiViewController.h"
#import "CYSouSuoLiShiHeader.h"
@interface CYGengDuoLiShiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *sousuoLishiArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CYGengDuoLiShiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    sousuoLishiArr = [NSMutableArray array];
    ChaYuer *manager =  MANAGER;
    [sousuoLishiArr addObjectsFromArray:manager.searchArr];
    [_tableView reloadData];
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
    return [sousuoLishiArr count];
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sousuolishiIdextify = @"sousuolishiIdextify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sousuolishiIdextify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sousuolishiIdextify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.textColor = [UIColor getColorWithHexString:@"333333"];
    cell.textLabel.font = FONT(14.0);
    cell.textLabel.text = sousuoLishiArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0;

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    CYSouSuoLiShiHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"CYSouSuoLiShiHeader" owner:nil options:nil] firstObject];
    header.shanchulishi = ^(){
        [sousuoLishiArr removeAllObjects];
        [sousuoLishiArr removeAllObjects];
        ChaYuer *user = [ChaYuManager getCurrentUser];
        user.searchArr = sousuoLishiArr;
        [ChaYuManager archiveCurrentUser:user];
        [_tableView reloadData];
    };
    return header;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *keyWord = sousuoLishiArr[indexPath.row];
    if (self.keywordBlock) {
        self.keywordBlock(keyWord);
    }
}



@end
