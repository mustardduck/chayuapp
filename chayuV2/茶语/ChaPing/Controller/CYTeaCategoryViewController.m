//
//  CYTeaCategoryViewController.m
//  茶语
//
//  Created by 李峥 on 16/2/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYTeaCategoryViewController.h"
#import "CYTeaCateCell.h"

@interface CYTeaCategoryViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mTable;

@property (nonatomic, strong) CYTeaCategoryInfo *mCateInfo;
@property (nonatomic, strong) NSArray *mCateList;

@end

@implementation CYTeaCategoryViewController

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
    self.title = @"全部茶类";
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"TeaCategory1" ofType:@"txt"];
    
    NSArray *list = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:kNilOptions error:nil];
    NSArray *cateList = [CYTeaCategoryInfo objectArrayWithKeyValuesArray:list];
    hiddenSepretor(self.mTable);
    if (self.mCateID != nil) {
        
        for (CYTeaCategoryInfo *info in cateList) {
            if ([info.bid isEqualToString:self.mCateID]) {
                self.mCateInfo = info;
                CYTeaChildCategoryInfo *cc = [CYTeaChildCategoryInfo new];
                cc.sid = nil;
                cc.name = @"全部";
                NSMutableArray *allChild = [NSMutableArray new];
                [allChild addObject:cc];
                [allChild addObjectsFromArray:info.children];
                self.mCateList = allChild;
            }
        }
    }else
    {
        CYTeaCategoryInfo *all =[[CYTeaCategoryInfo alloc] init];
        all.bid = @"0";
        all.name = @"全部";
        
        NSMutableArray *tempList = [NSMutableArray array];
        [tempList addObject:all];
        [tempList addObjectsFromArray:cateList];
        self.mCateList = [tempList copy];
    }
    
    if (self.mCateList.count > 0) {
        [self.mTable reloadData];
    }
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mCateList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id data = [self.mCateList objectAtIndex:indexPath.row];
    
    if ([data isKindOfClass:[CYTeaCategoryInfo class]]) {
        CYTeaCateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CYTeaCateCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CYTeaCateCell" owner:nil options:nil] objectAtIndex:0];
            UIView *selBg = [[UIView alloc] init];
            selBg.backgroundColor = UIColorFromRGB(0xfafafa);
            cell.selectedBackgroundView = selBg;
        }
        
        CYTeaCategoryInfo *info = data;
        cell.mNameLabel.text = info.name;
        if ([info.bid isEqualToString:@"0"]) {
            cell.mImageView.image = [UIImage imageNamed:@"all"];
        }
        else{
            
            cell.mImageView.image = [UIImage imageNamed:info.name];
        }
        
        return cell;
    }else if ([data isKindOfClass:[CYTeaChildCategoryInfo class]])
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChildCateCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChildCateCell"];
            
            cell.textLabel.textColor = RGB(51, 51, 51);
            cell.textLabel.highlightedTextColor = RGB(137, 62, 32);
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            
            UIView *selBg = [[UIView alloc] init];
            selBg.backgroundColor = UIColorFromRGB(0xfafafa);
            cell.selectedBackgroundView = selBg;
        }
        
        CYTeaChildCategoryInfo *info = data;
        cell.textLabel.text = info.name;
        
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id data = [self.mCateList objectAtIndex:indexPath.row];
    if ([data isKindOfClass:[CYTeaCategoryInfo class]]) {
        CYTeaCategoryInfo *info = data;
        if ([info.bid isEqualToString:@"0"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            if (_delegate && [_delegate respondsToSelector:@selector(teaCategorySelectData:)]) {
                
                [_delegate teaCategorySelectData:info];
            }
            return;
        }
        CYTeaCategoryViewController *tea = [[CYTeaCategoryViewController alloc] initWithNibName:@"CYTeaCategoryViewController" bundle:nil];
        tea.mCateID = info.bid;
        tea.delegate = _delegate;
        [self.navigationController pushViewController:tea animated:YES];
    }else if ([data isKindOfClass:[CYTeaChildCategoryInfo class]])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
//        [[NSNotificationCenter defaultCenter] postNotificationName:tabBarIndex object:@{@"selectIndex":@"1"}];
        CYTeaChildCategoryInfo *info = data;

        if (_delegate && [_delegate respondsToSelector:@selector(teaCategorySelectData:)]) {
            if (info.sid == nil) {
                [_delegate teaCategorySelectData:self.mCateInfo];
            }else
            {
                [_delegate teaCategorySelectData:data];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
