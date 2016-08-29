//
//  CYChaPingBangDanCell.m
//  茶语
//
//  Created by taotao on 16/7/2.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYChaPingBangDanCell.h"
#import "CYHomeBrandCell.h"
#import "CYBrandCellHeader.h"
#import "CYBrandCellFooter.h"
@interface CYChaPingBangDanCell ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CYChaPingBangDanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    [_tableView reloadData];
}


-(void)setInfo:(NSDictionary *)info{
    _info = info;
}

#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr count];
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60.0;
}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.0f;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CYBrandCellFooter *footer = [[[NSBundle mainBundle] loadNibNamed:@"CYBrandCellFooter" owner:nil options:nil] firstObject];
    footer.tag = 5700 +section;
    [footer.moreBtn addTarget:self action:@selector(gengduo_click:) forControlEvents:UIControlEventTouchUpInside];
    return footer;
}

-(void)gengduo_click:(UIButton *)sender
{
    if (self.gengduoBlcok) {
        self.gengduoBlcok(_info);
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CYBrandCellHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"CYBrandCellHeader" owner:nil options:nil] firstObject];
    header.brandnameLbl.text = [_info objectForKey:@"title"];
    header.yearLbl.text = [NSString stringWithFormat:@"（%@）",[_info objectForKey:@"year"]];
    return header;
}


-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *bandidentify = @"CYHomeBrandCell";
    CYHomeBrandCell *cell = [tableView dequeueReusableCellWithIdentifier:bandidentify];
    if (!cell) {
        cell  =[[[NSBundle mainBundle] loadNibNamed:@"CYHomeBrandCell" owner:nil options:nil]firstObject];
    }
    NSDictionary *info = _dataArr[indexPath.row];
    cell.mNumberLabel.text = [NSString stringWithFormat:@"%d",(int)indexPath.row+1];
    cell.mTitleLabel.text = [NSString stringWithFormat:@"[%@]%@",[info objectForKey:@"brand"],[info objectForKey:@"title"]];
    cell.mScodeLabel.text = [info objectForKey:@"review_score"];
    cell.info = info;

    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   NSDictionary *info = _dataArr[indexPath.row];
    if (self.itemBlcok) {
        self.itemBlcok(info);
    }
}



@end
