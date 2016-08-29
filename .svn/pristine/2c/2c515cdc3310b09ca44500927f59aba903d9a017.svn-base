//
//  CYLingQuChengGongViewController.m
//  茶语
//
//  Created by Chayu on 16/6/2.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYLingQuChengGongViewController.h"
#import "CYTuiJianViewController.h"
@interface CYLingQuChengGongViewController ()

- (IBAction)jixuyaoqing_click:(id)sender;



@end

@implementation CYLingQuChengGongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)creatRightItems
{
 
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)jixuyaoqing_click:(id)sender {
    NSArray *vcArr = self.navigationController.viewControllers;
    UIViewController *aimVC = nil;
    for (NSInteger i=vcArr.count-1; i>=0; i--) {
        if ([vcArr[i] isKindOfClass:[CYTuiJianViewController class]]) {
            aimVC = vcArr[i];
            break;
        }
    }
    if (aimVC) {
        [self.navigationController popToViewController:aimVC animated:YES];
    }
}
@end
