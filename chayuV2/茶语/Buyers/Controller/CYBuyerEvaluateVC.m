//
//  CYBuyerEvaluateVC.m
//  茶语
//
//  Created by Leen on 16/7/5.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerEvaluateVC.h"
#import "CYBuyerEvaCell.h"
#import "UILabel+Utilities.h"
#import "UIColor+Additions.h"
#import "CYBuyerEvaView.h"

@interface CYBuyerEvaluateVC ()<UITableViewDelegate, UITableViewDataSource, CYBuyerEvaViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property (weak, nonatomic) IBOutlet UIButton *allEvaBtn;
@property (weak, nonatomic) IBOutlet UIButton *goodEvaBtn;
@property (weak, nonatomic) IBOutlet UIButton *okEvaBtn;
@property (weak, nonatomic) IBOutlet UIButton *badEvaBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineLeadingCons;

@property (nonatomic, strong) CYBuyerEvaView * evaView;

@end

@implementation CYBuyerEvaluateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.evaView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchUpInsideOn:(id)sender
{
    UIButton * btn = (UIButton * )sender;
    
    if(btn == _allEvaBtn)
    {
        _lineLeadingCons.constant = 0;
        
        _allEvaBtn.selected = YES;
        _goodEvaBtn.selected = !_allEvaBtn.selected;
        _okEvaBtn.selected = !_allEvaBtn.selected;
        _badEvaBtn.selected = !_allEvaBtn.selected;

    }
    else if (btn == _goodEvaBtn)
    {
        _lineLeadingCons.constant = SCREEN_WIDTH / 4;
        
        _goodEvaBtn.selected = YES;
        _allEvaBtn.selected = !_goodEvaBtn.selected;
        _okEvaBtn.selected = !_goodEvaBtn.selected;
        _badEvaBtn.selected = !_goodEvaBtn.selected;
    }
    else if (btn == _okEvaBtn)
    {
        _lineLeadingCons.constant = SCREEN_WIDTH / 2;
        
        _okEvaBtn.selected = YES;
        _allEvaBtn.selected = !_okEvaBtn.selected;
        _goodEvaBtn.selected = !_okEvaBtn.selected;
        _badEvaBtn.selected = !_okEvaBtn.selected;
    }
    else if (btn == _badEvaBtn)
    {
        _lineLeadingCons.constant = SCREEN_WIDTH / 4 * 3;
        
        _badEvaBtn.selected = YES;
        _allEvaBtn.selected = !_badEvaBtn.selected;
        _goodEvaBtn.selected = !_badEvaBtn.selected;
        _okEvaBtn.selected = !_badEvaBtn.selected;
    }
}

#pragma mark -
#pragma mark UITableViewDataSource method
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYBuyerEvaCell *cell = (CYBuyerEvaCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = [UIColor grayBackgroundColor];
    
    return view;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = 0;
    
    if(indexPath.section == 0)
    {
        index = 0;
    }
    else if (indexPath.section == 1)
    {
        index = 1;
    }
    else if (indexPath.section == 2)
    {
        index = 2;
    }
    else if (indexPath.section == 3)
    {
        index = 3;
    }
    else if (indexPath.section == 4)
    {
        index = 4;
    }
    
    CYBuyerEvaCell *cell = [CYBuyerEvaCell cellWidthTableView:tableView index:index];
    
    if(index == 0)
    {
        cell.nameLbl1.text = @"李健健";
        cell.starFirstIcon1.image = [UIImage imageNamed:@"fullStar"];
        cell.starSecondIcon1.image = [UIImage imageNamed:@"fullStar"];
        cell.starThirdIcon1.image = [UIImage imageNamed:@"fullStar"];
        cell.starFourthIcon1.image = [UIImage imageNamed:@"halfStar"];
        cell.starFifthIcon1.image = [UIImage imageNamed:@"emptyStar"];
        cell.customerEvaLbl1.text = @"不错的一款红茶，非常好喝，推荐购买";
        
        [cell.sellerEvaBtn1 addTarget:self action:@selector(sellerEvaBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        cell.height = 117 + cell.customerEvaLbl1.boundingRectWithHeight - 16;

    }
    else if (index == 1)
    {
        cell.nameLbl2.text = @"小鱼摆摆";
        cell.starFirstIcon2.image = [UIImage imageNamed:@"fullStar"];
        cell.starSecondIcon2.image = [UIImage imageNamed:@"fullStar"];
        cell.starThirdIcon2.image = [UIImage imageNamed:@"fullStar"];
        cell.starFourthIcon2.image = [UIImage imageNamed:@"halfStar"];
        cell.starFifthIcon2.image = [UIImage imageNamed:@"emptyStar"];
        cell.customerEvaLbl2.text = @"还没泡来喝，不过想来不错，因为送的老水仙也挺好的。包装很仔细。";
        [cell.sellerEvaBtn2 addTarget:self action:@selector(sellerEvaBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.customerEvaAgainLbl2.text = @"买家追评：真心的不错，以后还会再来买";
        
        [cell.sellerEvaAgainBtn2 addTarget:self action:@selector(sellerEvaBtnAgainClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.height = 191 + cell.customerEvaLbl2.boundingRectWithHeight + cell.customerEvaAgainLbl2.boundingRectWithHeight - 16 * 2;

    }
    else if (index == 2)
    {
        cell.nameLbl3.text = @"李健健";
        cell.starFirstIcon3.image = [UIImage imageNamed:@"fullStar"];
        cell.starSecondIcon3.image = [UIImage imageNamed:@"fullStar"];
        cell.starThirdIcon3.image = [UIImage imageNamed:@"fullStar"];
        cell.starFourthIcon3.image = [UIImage imageNamed:@"halfStar"];
        cell.starFifthIcon3.image = [UIImage imageNamed:@"emptyStar"];
        cell.customerEvaLbl3.text = @"不错的一款红茶，非常好喝，推荐购买";
        cell.sellerEvaLbl3.text = @"卖家回复：谢谢";
        
        cell.height = 104 + cell.customerEvaLbl3.boundingRectWithHeight + cell.sellerEvaLbl3.boundingRectWithHeight - 16 * 2;
    }
    else if (index == 3)
    {
        cell.nameLbl4.text = @"李健健";
        cell.starFirstIcon4.image = [UIImage imageNamed:@"fullStar"];
        cell.starSecondIcon4.image = [UIImage imageNamed:@"fullStar"];
        cell.starThirdIcon4.image = [UIImage imageNamed:@"fullStar"];
        cell.starFourthIcon4.image = [UIImage imageNamed:@"halfStar"];
        cell.starFifthIcon4.image = [UIImage imageNamed:@"emptyStar"];
        cell.customerEvaLbl4.text = @"不错的一款红茶，非常好喝，推荐购买";
        cell.sellerEvaLbl4.text = @"卖家回复：谢谢";
        cell.customerEvaAgainLbl4.text = @"买家追评：真心的不错，以后还会再来买";

        [cell.sellerEvaBtn4 addTarget:self action:@selector(sellerEvaBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

        cell.height = 169 + cell.customerEvaLbl4.boundingRectWithHeight + cell.sellerEvaLbl4.boundingRectWithHeight + cell.customerEvaAgainLbl4.boundingRectWithHeight - 16 * 3;
    }
    else if (index == 4)
    {
        cell.nameLbl5.text = @"李健健";
        cell.starFirstIcon5.image = [UIImage imageNamed:@"fullStar"];
        cell.starSecondIcon5.image = [UIImage imageNamed:@"fullStar"];
        cell.starThirdIcon5.image = [UIImage imageNamed:@"fullStar"];
        cell.starFourthIcon5.image = [UIImage imageNamed:@"halfStar"];
        cell.starFifthIcon5.image = [UIImage imageNamed:@"emptyStar"];
        cell.customerEvaLbl5.text = @"不错的一款红茶，非常好喝，推荐购买";
        cell.sellerEvaLbl5.text = @"卖家回复：谢谢";
        cell.customerEvaAgainLbl5.text = @"买家追评：真心的不错，以后还会再来买";
        cell.sellerEvaAgainLbl5.text = @"追评回复：真心的不错，以后还会再来买真心的不错，以后还会再来买";

        
        cell.height = 156 + cell.customerEvaLbl5.boundingRectWithHeight + cell.sellerEvaLbl5.boundingRectWithHeight + cell.customerEvaAgainLbl5.boundingRectWithHeight + cell.sellerEvaAgainLbl5.boundingRectWithHeight - 16 * 4;
    }
    
    return cell;
}

- (void)sellerEvaBtnClicked:(id)sender
{
    CYBuyerEvaCell * cell = (CYBuyerEvaCell *)[[sender superview] superview];
    
    NSIndexPath * indP = [_mainTable indexPathForCell:cell];
    
    NSLog(@"indexpath.section=%ld", indP.section);
    
    _evaView.textView.text = nil;
    
    _evaView.hidden = NO;
}

- (void)sellerEvaBtnAgainClicked:(id)sender
{
    CYBuyerEvaCell * cell = (CYBuyerEvaCell *)[[sender superview] superview];
    
    NSIndexPath * indP = [_mainTable indexPathForCell:cell];
    
    NSLog(@"indexpath.section=%ld", indP.section);
    
    _evaView.textView.text = nil;

    _evaView.hidden = NO;
}

- (void)evaViewCommentClicked
{
    _evaView.hidden = YES;
    
//    [_mainTable reloadData];
}

- (void) evaViewCancelClicked
{
    _evaView.hidden = YES;
    
}

- (CYBuyerEvaView *)evaView
{
    if (!_evaView) {
        _evaView = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerEvaView" owner:nil options:nil] firstObject];
        _evaView.frame = WINDOW.bounds;
        _evaView.delegate = self;
        _evaView.hidden = YES;
    }
    return _evaView;
}

- (IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
