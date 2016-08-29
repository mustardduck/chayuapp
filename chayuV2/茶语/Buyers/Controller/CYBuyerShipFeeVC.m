//
//  CYBuyerShipFeeVC.m
//  茶语
//
//  Created by Leen on 16/6/30.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerShipFeeVC.h"
#import "CYBuyerShipFeeEditVC.h"

@interface CYBuyerShipFeeVC ()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL _isSetShipFee;
}

@property (weak, nonatomic) IBOutlet UIButton *freeShipBtn;

@property (weak, nonatomic) IBOutlet UIButton *setShipFeeBtn;
@property (weak, nonatomic) IBOutlet UIView *notSetShipFeeView;

@property (weak, nonatomic) IBOutlet UIButton *addShipFeeBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addShipFeeBottomCons;
@property (weak, nonatomic) IBOutlet UITableView *mainTable;

@end

@implementation CYBuyerShipFeeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _isSetShipFee = NO;
    
    [self touchUpInsideOn:_freeShipBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)touchUpInsideOn:(id)sender {
    
    UIButton * btn = (UIButton *)sender;
    
    if(btn == _freeShipBtn)
    {
        _freeShipBtn.selected = YES;
        _setShipFeeBtn.selected = !_freeShipBtn.selected;
    }
    else if (btn == _setShipFeeBtn)
    {
        _setShipFeeBtn.selected = YES;
        _freeShipBtn.selected = !_setShipFeeBtn.selected;
    }
    else if (btn == _addShipFeeBtn)
    {
        CYBuyerShipFeeEditVC * vc = viewControllerInStoryBoard(@"CYBuyerShipFeeEditVC", @"Buyer");
        [self.navigationController pushViewController:vc animated:YES];
        
        return;
    }
    
    if(_setShipFeeBtn.selected && !_isSetShipFee)
    {
        _mainTable.hidden = YES;
        
        _notSetShipFeeView.hidden = !_mainTable.hidden;
        
        _addShipFeeBottomCons.constant = SCREEN_HEIGHT -  _notSetShipFeeView.y - _notSetShipFeeView.height - _addShipFeeBtn.height;
        
    }
    else if(_setShipFeeBtn.selected && _isSetShipFee )
    {
        _mainTable.hidden = NO;
        
        _notSetShipFeeView.hidden = !_mainTable.hidden;
        
          _addShipFeeBottomCons.constant = 15;
    }
    else
    {
        _mainTable.hidden = YES;
        _notSetShipFeeView.hidden = YES;
    }
    
    _addShipFeeBtn.hidden = _freeShipBtn.selected;
}

#pragma mark -
#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark -
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
