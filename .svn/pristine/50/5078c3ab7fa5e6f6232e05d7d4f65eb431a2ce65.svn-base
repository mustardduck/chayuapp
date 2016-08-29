//
//  CYBuyerProfileContentVC.m
//  茶语
//
//  Created by Leen on 16/8/18.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerProfileContentVC.h"
#import "UICommon.h"

@interface CYBuyerProfileContentVC ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation CYBuyerProfileContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)okClicked:(id)sender
{
    if([UICommon isBlankString:_textView.text])
    {
        [Itost showMsg:@"请输入内容" inView:self.view];
        
        [_textView becomeFirstResponder];
        
        return;
    }
    
    if(self.saveContentBlock)
    {
        self.saveContentBlock(_textView.text);
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
