//
//  CYCouponDetViewController.m
//  茶语
//
//  Created by Chayu on 16/5/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYCouponDetViewController.h"
#import "CYHongBaoModel.h"

@interface CYCouponDetViewController ()
{
    CYHongBaoModel *hongbaoModel;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) IBOutlet UIImageView *statusImg;
@property (weak, nonatomic) IBOutlet UIImageView *bottomimg;
@property (weak, nonatomic) IBOutlet UIImageView *topimg;

@property (weak, nonatomic) IBOutlet UILabel *qualLbl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cons_heiht_cons;

@property (weak, nonatomic) IBOutlet UIScrollView *contentView;
- (IBAction)lijishiyong_click:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *shiyongBTN;

@end

@implementation CYCouponDetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CYWebClient Post:@"MyHongBaoXiangQing" parametes:@{@"id":_couponId} success:^(id responObject) {
        hongbaoModel = [CYHongBaoModel objectWithKeyValues:responObject];
        _titleLbl.text = hongbaoModel.title;
        _priceLbl.text = [NSString stringWithFormat:@"￥%@",hongbaoModel.money];
        _timeLbl.text  = [NSString stringWithFormat:@"使用期限%@-%@",hongbaoModel.start,hongbaoModel.end];
        if ([hongbaoModel.status integerValue] >1) {
            _topimg.image = [UIImage imageNamed:@"dkq-top-jc2"];
            _statusView.backgroundColor = [UIColor getColorWithHexString:@"bbbbbb"];
            _statusImg.hidden = NO;
            if ([hongbaoModel.status integerValue] == 3) {
                _statusImg.image = [UIImage imageNamed:@"yishiyong"];
            }else{
                _statusImg.image = [UIImage imageNamed:@"yishixiao"];
            }
        }else{
            _shiyongBTN.hidden = NO;
        }
        _qualLbl.text = hongbaoModel.qual;
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14.]};
        CGSize lableSize = [hongbaoModel.qual boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-28,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        CGFloat labHeight = lableSize.height+1;
        
        
        _cons_heiht_cons.constant = labHeight;
        _contentView.contentSize = CGSizeMake(SCREEN_WIDTH,253 +_cons_heiht_cons.constant +20);
        
    } failure:^(id error) {
        
    }];
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)lijishiyong_click:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:tabBarIndex object:@{@"selectIndex":@"2"}];
    
}
@end
