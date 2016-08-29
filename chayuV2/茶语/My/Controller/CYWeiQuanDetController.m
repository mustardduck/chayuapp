//
//  CYWeiQuanDetController.m
//  茶语
//
//  Created by Chayu on 16/7/21.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYWeiQuanDetController.h"
#import "CYWeiQuanDetTopCell.h"
#import "CYWeiQuanDetRepCell.h"
@interface CYWeiQuanDetController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary *weiquanInfo;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)goback:(id)sender;

@end

@implementation CYWeiQuanDetController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.hidden = YES;
    [self loadViewData];
}

-(void)loadViewData
{
    __weak __typeof(self) weakSelf = self;
    [CYWebClient Post:@"2.0_user.rights.detail" parametes:@{@"id":_weiquanId} success:^(id responObj) {
        _tableView.hidden = NO;
        weiquanInfo = responObj;
        [weakSelf.tableView reloadData];
    } failure:^(id err) {
        _tableView.hidden = NO;
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
    return 1;
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CGFloat height = 92.0;
        NSString *content = [weiquanInfo objectForKey:@"rights_content"];
//        content = @"上课的经费和可使肌肤会尽快送发货款是否开始疯狂手机话费开始放假跨世纪的开发";
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14.]};
        CGSize lableSize = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-110,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        height -=17;
        height +=lableSize.height+1;
        return height;
    }else{
        CGFloat height = 70.0;
        NSString *content = [weiquanInfo objectForKey:@"reply_content"];
//        content = @"上课的经费和可使肌肤会尽快送发货款是否开始疯狂手机话费开始放假跨世纪的开发";
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14.]};
        CGSize lableSize = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-124,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        height -=17;
        height +=lableSize.height+2;
        return height;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CYWeiQuanDetTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYWeiQuanDetTopCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.bianhaoLbl.text = [NSString stringWithFormat:@"维权编号：%@",[weiquanInfo objectForJSONKey:@"rights_sn"]];
//        NSString *content = @"上课的经费和可使肌肤会尽快送发货款是否开始疯狂手机话费开始放假跨世纪的开发";
        cell.contentLbl.text =   [NSString stringWithFormat:@"%@",[weiquanInfo objectForKey:@"rights_content"]];
        cell.timeLbl.text =[NSString stringWithFormat:@"发起时间：%@",[weiquanInfo objectForJSONKey:@"created_time"]];
        cell.statusLbl.text = [weiquanInfo objectForJSONKey:@"status"];
        return cell;
    }else{
        CYWeiQuanDetRepCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYWeiQuanDetRepCell"];
        cell.timeLbl.text = [weiquanInfo objectForJSONKey:@"reply_time"];
//        NSString *content = @"上课的经费和可使肌肤会尽快送发货款是否开始疯狂手机话费开始放假跨世纪的开发";
        cell.contentLbl.text = [weiquanInfo objectForJSONKey:@"reply_content"];;
//
//        cell.nameTf.text =
        return cell;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return 0.000001;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        
        view.backgroundColor = [UIColor getColorWithHexString:@"f9f9f9"];
        return view;
    }
    return nil;
  
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
