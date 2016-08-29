//
//  CYBangDanView.m
//  茶语
//
//  Created by Chayu on 16/6/29.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBangDanView.h"
#import "CYChaPingBangDanCell.h"
#import "CYBrandTopItemView.h"
@interface CYBangDanView  ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIScrollView *topScro;

@end

@implementation CYBangDanView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    [super awakeFromNib];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}
- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    [_tableView reloadData];
}


-(void)setTopMenuArr:(NSArray *)topMenuArr
{
    _topMenuArr = topMenuArr;
    CGFloat itemWith = (SCREEN_WIDTH-40)/4.;
    for (int i =0; i<[topMenuArr count]; i++) {
        NSDictionary *info = _topMenuArr[i];
        CYBrandTopItemView *view = [[[NSBundle mainBundle] loadNibNamed:@"CYBrandTopItemView" owner:nil options:nil] firstObject];
        view.frame = CGRectMake(i*itemWith, 0, itemWith,117);
        view.titleLbl.text = [info objectForKey:@"title"];
        view.titleLbl1.text = [info objectForKey:@"titles"];
        NSString *thumb = [info objectForKey:@"thumb"];
        [view.icoImg sd_setImageWithURL:[NSURL URLWithString:thumb] placeholderImage:SQUARE];
        view.selectBtn.tag = 80000+i;
        [view.selectBtn addTarget: self action:@selector(selectTopMenu_click:) forControlEvents:UIControlEventTouchUpInside];
        [_topScro addSubview:view];
        
    }
}

-(void)selectTopMenu_click:(UIButton *)sender{
    
       NSDictionary *info = _topMenuArr[sender.tag - 80000];
    if (self.selectTopMenuBlock) {
        self.selectTopMenuBlock(info);
    }
}

#pragma mark -
#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info = [_dataArr objectAtIndex:indexPath.row];
    NSArray *list = [info objectForKey:@"list"];
    return 105 + 30*[list count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *bandidentifier_cell = @"CYChaPingBangDanCell";
    CYChaPingBangDanCell *cell = [tableView dequeueReusableCellWithIdentifier:bandidentifier_cell];
    if (!cell) {//当cell是Xib创建出来用此方法，如果cell在StoryBoard上不用次方法
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CYChaPingBangDanCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    __weak __typeof(self) weakSelf = self;
    cell.gengduoBlcok = ^(NSDictionary *info ){
        if (weakSelf.selectMoreBlock) {
            weakSelf.selectMoreBlock(info);
        }
    };
    
    cell.itemBlcok = ^(NSDictionary *info){
        if (weakSelf.selectitemBlock) {
            weakSelf.selectitemBlock(info);
        }
    };
    
    NSDictionary *info = [_dataArr objectAtIndex:indexPath.row];
    cell.info = info;
    cell.dataArr = [info objectForKey:@"list"];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
