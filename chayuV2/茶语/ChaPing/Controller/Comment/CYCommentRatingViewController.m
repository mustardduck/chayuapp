//
//  CYCommentRatingViewController.m
//  茶语
//
//  Created by 李峥 on 16/2/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYCommentRatingViewController.h"
#import "CYRatingCell.h"

@interface CYCommentRatingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *mTable;

@property (nonatomic, strong) NSArray *mRatingList;
@property (nonatomic, strong) NSArray *mCellList;

@property (nonatomic, strong) CYRatingCell *mGCCell;
@property (nonatomic, strong) CYRatingCell *mTSCell;
@property (nonatomic, strong) CYRatingCell *mXQCell;
@property (nonatomic, strong) CYRatingCell *mZWCell;
@property (nonatomic, strong) CYRatingCell *mYDCell;

@end

@implementation CYCommentRatingViewController

- (NSArray *)mRatingList
{
    if (_mRatingList == nil) {
        _mRatingList = @[@"干茶：",@"汤色：",@"香气：",@"滋味：",@"叶底："];
    }
    
    return _mRatingList;
}

- (NSArray *)mCellList
{
    if (_mCellList == nil) {
        _mCellList = @[self.mGCCell,self.mTSCell,self.mXQCell,self.mZWCell,self.mYDCell];
    }
    
    return _mCellList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"评分";
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    footerView.backgroundColor = CLEARCOLOR;
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(12, 10, [UIScreen mainScreen].bounds.size.width - 24, 40)];
    [sendBtn setTitle:@"提交" forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendBtn.backgroundColor = MAIN_COLOR;
    sendBtn.layer.borderColor = RGB(137, 62, 32).CGColor;
    sendBtn.layer.borderWidth = 1.5;
    sendBtn.layer.masksToBounds = YES;
    sendBtn.layer.cornerRadius = 4;
    [sendBtn addTarget:self action:@selector(clickSend:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:sendBtn];
    
    self.mTable.tableFooterView = footerView;
    

    
}

- (void)clickSend:(id)sender
{
    CGFloat drytea = self.mGCCell.mRatingView.rating;
    if (drytea < 0) {
        drytea = 0;
    }
    CGFloat soupcolor = self.mTSCell.mRatingView.rating;
    if (soupcolor < 0) {
        soupcolor = 0;
    }
    CGFloat smell = self.mXQCell.mRatingView.rating;
    if (smell < 0) {
        smell = 0;
    }
    
    CGFloat flavour  = self.mZWCell.mRatingView.rating;
    if (flavour < 0) {
        flavour = 0;
    }
    
    CGFloat leaves  = self.mYDCell.mRatingView.rating;
    if (leaves < 0) {
        leaves = 0;
    }
    CYRatingInfo *rating = [[CYRatingInfo alloc] init];
    rating.drytea = drytea;
    rating.soupcolor = soupcolor;
    rating.smell = smell;
    rating.flavour = flavour;
    rating.leaves = leaves;
    
    if (_delegate && [_delegate respondsToSelector:@selector(commentRatingData:)]) {
        [_delegate commentRatingData:rating];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setRetInfo:(CYRatingInfo *)retInfo
{
    _retInfo = retInfo;
    [self.mGCCell.mRatingView displayRating:_retInfo.drytea];
    [self.mTSCell.mRatingView displayRating:_retInfo.soupcolor];
    [self.mXQCell.mRatingView displayRating:_retInfo.smell];
    [self.mZWCell.mRatingView displayRating:_retInfo.flavour];
    [self.mYDCell.mRatingView displayRating:_retInfo.leaves];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mCellList.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.mCellList objectAtIndex:indexPath.row];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CYRatingCell *)mYDCell
{
    if (_mYDCell == nil) {
        _mYDCell = [[[NSBundle mainBundle] loadNibNamed:@"CYRatingCell" owner:nil options:nil] objectAtIndex:0];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15,_mYDCell.height-1, SCREEN_WIDTH-30, 0.5)];
        line.backgroundColor = [UIColor getColorWithHexString:@"cccccc"];
        [_mYDCell.contentView addSubview:line];
        _mYDCell.mTypeLabel.text = [self.mRatingList objectAtIndex:4];
    }
    
    return _mYDCell;
}
- (CYRatingCell *)mZWCell
{
    if (_mZWCell == nil) {
        _mZWCell = [[[NSBundle mainBundle] loadNibNamed:@"CYRatingCell" owner:nil options:nil] objectAtIndex:0];
        
        _mZWCell.mTypeLabel.text = [self.mRatingList objectAtIndex:3];
    }
    
    return _mZWCell;
}
- (CYRatingCell *)mXQCell
{
    if (_mXQCell == nil) {
        _mXQCell = [[[NSBundle mainBundle] loadNibNamed:@"CYRatingCell" owner:nil options:nil] objectAtIndex:0];
        
        _mXQCell.mTypeLabel.text = [self.mRatingList objectAtIndex:2];
    }
    
    return _mXQCell;
}
- (CYRatingCell *)mTSCell
{
    if (_mTSCell == nil) {
        _mTSCell = [[[NSBundle mainBundle] loadNibNamed:@"CYRatingCell" owner:nil options:nil] objectAtIndex:0];
        
        _mTSCell.mTypeLabel.text = [self.mRatingList objectAtIndex:1];
    }
    
    return _mTSCell;
}

- (CYRatingCell *)mGCCell
{
    if (_mGCCell == nil) {
        _mGCCell = [[[NSBundle mainBundle] loadNibNamed:@"CYRatingCell" owner:nil options:nil] objectAtIndex:0];
        
        _mGCCell.mTypeLabel.text = [self.mRatingList objectAtIndex:0];
    }
    
    return _mGCCell;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:@"评分"];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:@"评分"];
}


@end
