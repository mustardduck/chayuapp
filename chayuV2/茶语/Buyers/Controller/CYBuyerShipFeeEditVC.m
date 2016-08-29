//
//  CYBuyerShipFeeEditVC.m
//  茶语
//
//  Created by Leen on 16/7/1.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerShipFeeEditVC.h"
#import "CYBuyerShipAreaEditVC.h"

@interface CYBuyerShipFeeEditVC ()

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UITextField *PDCountTxt;
@property (weak, nonatomic) IBOutlet UITextField *priceTxt;
@property (weak, nonatomic) IBOutlet UITextField *morePDCountTxt;
@property (weak, nonatomic) IBOutlet UITextField *morePriceTxt;
@property (weak, nonatomic) IBOutlet UIButton *selectAreaBtn;


@end

@implementation CYBuyerShipFeeEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUIBorder];
    
}

- (void) setUIBorder
{
    _mainView.layer.borderColor = [UIColor redColor].CGColor;
    _mainView.layer.borderWidth = 0.5;
    _mainView.layer.cornerRadius = 2.0f;
    
    _PDCountTxt.layer.borderColor = [UIColor redColor].CGColor;
    _PDCountTxt.layer.borderWidth = 0.5;
    
    _priceTxt.layer.borderColor = [UIColor redColor].CGColor;
    _priceTxt.layer.borderWidth = 0.5;
    
    _morePDCountTxt.layer.borderColor = [UIColor redColor].CGColor;
    _morePDCountTxt.layer.borderWidth = 0.5;
    
    _morePriceTxt.layer.borderColor = [UIColor redColor].CGColor;
    _morePriceTxt.layer.borderWidth = 0.5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectAreaClicked:(id)sender
{
    CYBuyerShipAreaEditVC * vc = viewControllerInStoryBoard(@"CYBuyerShipAreaEditVC", @"Buyer");
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
