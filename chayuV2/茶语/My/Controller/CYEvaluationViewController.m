//
//  CYEvaluationViewController.m
//  TeaMall
//  商品评价
//  Created by Chayu on 15/11/5.
//  Copyright © 2015年 Chayu. All rights reserved.
//

#import "CYEvaluationViewController.h"
//#import "MLInputDodger.h"
#import "CYcommentView.h"
#define COMMVIEWTAG  30000
@interface CYEvaluationViewController ()<UITextViewDelegate>{
    
    NSMutableArray *_dataArr;
    
}
- (IBAction)goback:(id)sender;
- (IBAction)leaveacomment_click:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *contentView;



@end

@implementation CYEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //     [_contentView registerAsDodgeViewForMLInputDodger];
    _dataArr = [[NSMutableArray alloc] init];
    //    self.barStyle = NavBarStyleNoneMore;
    [CYWebClient Post:@"Comment" parametes:@{@"orderSn":_model.orderSn} success:^(id responObject) {
        [_dataArr addObjectsFromArray:[CYShopTrolleyModel objectArrayWithKeyValuesArray:responObject]];
        [self loadEvaluationView:_dataArr];
        
    } failure:^(id error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)loadEvaluationView:(NSArray *)dataArr
{
    CGFloat allHeight= 0.0;
    NSMutableArray *arr = [NSMutableArray arrayWithObject:@"0"];
    for (int i = 0; i<[dataArr count]; i++) {
        CYCommentView *view = [[[NSBundle mainBundle] loadNibNamed:@"CYCommentView" owner:nil options:nil] firstObject];
        CYShopTrolleyModel *model = _dataArr[i];
        if (!_isAppend) {
            model.score = @"10";
        }
        
        view.model = model;
        CGFloat viewHeight = 195.0;
        if (model.addReview.length) {
            viewHeight +=([model.addReview heightWithFont:FONT(13.0) forWidth:SCREEN_WIDTH -20] +30);
        }
        
        if (model.adminReview.length) {
            viewHeight +=([model.adminReview heightWithFont:FONT(13.0) forWidth:SCREEN_WIDTH -20] +30);
        }
        allHeight +=viewHeight;
        view.frame = CGRectMake(0,[arr[i] floatValue],SCREEN_WIDTH,viewHeight);
        view.tag = i+COMMVIEWTAG;
        [_contentView addSubview:view];
        [arr addObject:@(allHeight)];
    }
    _contentView.contentSize = CGSizeMake(SCREEN_WIDTH,allHeight);
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return NO;
    }
    
    return YES;
}


- (IBAction)leaveacomment_click:(id)sender {
    
    NSMutableArray *specIdArr = [NSMutableArray array];
    NSMutableArray *goodsIdArr = [NSMutableArray array];
    NSMutableArray *contentArr = [NSMutableArray array];
    NSMutableArray *scoreArr = [NSMutableArray array];
    NSMutableArray *firstId = [NSMutableArray array];
    for (int i= 0; i<[_dataArr count]; i++) {
        CYCommentView *commentView = (CYCommentView *)[_contentView viewWithTag:i+COMMVIEWTAG];
        CYShopTrolleyModel *model = _dataArr[i];
        [specIdArr addObject:model.specdataId];
        [goodsIdArr addObject:model.goods_id];
        [contentArr addObject:commentView.evaTxt.text];
        if (_isAppend) {
            if (!model.commentId || !model.commentId.length) {
                [firstId addObject:@""];
            }else{
                [firstId addObject:model.commentId];
            }
            
        }
        if (commentView.starView.show_star == 10) {
            [scoreArr addObject:[NSNumber numberWithInteger:commentView.starView.show_star]];
        }else{
             [scoreArr addObject:[NSNumber numberWithInteger:commentView.starView.show_star*2]];
        }
     
    }
    NSMutableDictionary *param  =[NSMutableDictionary dictionary];
    [param setObject:_model.orderSn forKey:@"orderSn"];
    [param setObject:[specIdArr JSONString] forKey:@"specId"];
    [param setObject:[goodsIdArr JSONString] forKey:@"goodsId"];
    [param setObject:[contentArr JSONString] forKey:@"content"];
    if (!_isAppend) {
        [param setObject:[scoreArr JSONString] forKey:@"score"];
    }else{
        [param setObject:[firstId JSONString] forKey:@"pId"];
    }
    
    
    NSString *urlPath = @"CommentAgian";
    if (!_isAppend) {
        urlPath = @"GoodsComment";
    }
    [CYWebClient Post:urlPath parametes:param success:^(id responObject) {
        //        NSString *msg = [responObject objectForJSONKey:@"msg"];
        //        if ([[responObject objectForJSONKey:@"state"] integerValue] == 400) {
        if (self.blockBack) {
            self.blockBack();
        }
        
        //        if (responObject) {
        [self performSelector:@selector(goback:) withObject:nil afterDelay:1.0f];
        //        }
        
        //        }
        //        [SVProgressHUD showInfoWithStatus:msg];
    } failure:^(id error) {
        
    }];
    
    
}
@end
