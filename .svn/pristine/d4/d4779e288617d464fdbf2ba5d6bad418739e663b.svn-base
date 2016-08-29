//
//  CYBuyerPDImageDescVC.m
//  茶语
//
//  Created by Leen on 16/8/26.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerPDImageDescVC.h"
#import "CYBannerView.h"
#import "CYHomeInfo.h"
#import "UIColor+Additions.h"
#import "PlaceholderTextView.h"
#import "UICommon.h"

@interface CYBuyerPDImageDescVC ()
{
    PlaceholderTextView * _textView;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@end

@implementation CYBuyerPDImageDescVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    CYBannerView *bannerView = [[CYBannerView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 250*SCREENBILI) pageType:CYPageTypeHidden bannerArr:_bannerArr useTimer:NO currentIndex:_currentIndex];
    
    self.titleLbl.text = [NSString stringWithFormat:@"%ld/%ld", _currentIndex + 1, _bannerArr.count - 1];

    [bannerView changePageBlock:^(NSInteger index){
        self.titleLbl.text = [NSString stringWithFormat:@"%ld/%ld", index + 1, _bannerArr.count - 1];
    }];
    
    [self.view addSubview:bannerView];
    
    [self addContentView];
}

- (void)addContentView
{
    UILabel * titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(20,   NAV_HEIGHT + 250*SCREENBILI + 15, 100, 20)];
    titleLbl.backgroundColor = CLEARCOLOR;
    titleLbl.font = FONT(16);
    titleLbl.text = @"图片描述";
    titleLbl.textColor = [UIColor blackTitleColor];
    
    [self.view addSubview:titleLbl];
    
    _textView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(20, titleLbl.y + titleLbl.height + 8, SCREEN_WIDTH - 40, SCREEN_HEIGHT - (titleLbl.y + titleLbl.height + 8) - 50)];
    _textView.backgroundColor = CLEARCOLOR;
    _textView.textColor = [UIColor blackTitleColor];
    _textView.font = FONT(17);
    _textView.placeholder = @"请输入文字描述（输入字数 10-100个字）";
    [self.view addSubview:_textView];
    
    UIButton * okBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    okBtn.backgroundColor = [UIColor brownTitleColor];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    okBtn.titleLabel.font = FONT(18);
    [okBtn addTarget:self action:@selector(okBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:okBtn];
    
}

- (void)okBtnClicked:(id)sender
{
    if([UICommon isBlankString:_textView.text])
    {
        [Itost showMsg:@"图片描述不能为空" inView:self.view];
        
        [_textView becomeFirstResponder];
        
        return;
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [APP_DELEGATE setTabbarHidden:YES animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
