//
//  CYBuyerEvaCell.h
//  茶语
//
//  Created by Leen on 16/7/5.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYBuyerEvaCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLbl1;
@property (weak, nonatomic) IBOutlet UIImageView *starFirstIcon1;
@property (weak, nonatomic) IBOutlet UIImageView *starSecondIcon1;
@property (weak, nonatomic) IBOutlet UIImageView *starThirdIcon1;
@property (weak, nonatomic) IBOutlet UIImageView *starFourthIcon1;
@property (weak, nonatomic) IBOutlet UIImageView *starFifthIcon1;
@property (weak, nonatomic) IBOutlet UILabel *customerEvaLbl1;
@property (weak, nonatomic) IBOutlet UIButton *sellerEvaBtn1;
@property (weak, nonatomic) IBOutlet UIImageView *imgView1;


@property (weak, nonatomic) IBOutlet UILabel *nameLbl2;
@property (weak, nonatomic) IBOutlet UIImageView *starFirstIcon2;
@property (weak, nonatomic) IBOutlet UIImageView *starSecondIcon2;
@property (weak, nonatomic) IBOutlet UIImageView *starThirdIcon2;
@property (weak, nonatomic) IBOutlet UIImageView *starFourthIcon2;
@property (weak, nonatomic) IBOutlet UIImageView *starFifthIcon2;
@property (weak, nonatomic) IBOutlet UILabel *customerEvaLbl2;
@property (weak, nonatomic) IBOutlet UIButton *sellerEvaBtn2;
@property (weak, nonatomic) IBOutlet UILabel *customerEvaAgainLbl2;
@property (weak, nonatomic) IBOutlet UIButton *sellerEvaAgainBtn2;
@property (weak, nonatomic) IBOutlet UIImageView *imgView2;

@property (weak, nonatomic) IBOutlet UILabel *nameLbl3;
@property (weak, nonatomic) IBOutlet UIImageView *starFirstIcon3;
@property (weak, nonatomic) IBOutlet UIImageView *starSecondIcon3;
@property (weak, nonatomic) IBOutlet UIImageView *starThirdIcon3;
@property (weak, nonatomic) IBOutlet UIImageView *starFourthIcon3;
@property (weak, nonatomic) IBOutlet UIImageView *starFifthIcon3;
@property (weak, nonatomic) IBOutlet UILabel *customerEvaLbl3;
@property (weak, nonatomic) IBOutlet UILabel *sellerEvaLbl3;
@property (weak, nonatomic) IBOutlet UIImageView *imgView3;

@property (weak, nonatomic) IBOutlet UILabel *nameLbl4;
@property (weak, nonatomic) IBOutlet UIImageView *starFirstIcon4;
@property (weak, nonatomic) IBOutlet UIImageView *starSecondIcon4;
@property (weak, nonatomic) IBOutlet UIImageView *starThirdIcon4;
@property (weak, nonatomic) IBOutlet UIImageView *starFourthIcon4;
@property (weak, nonatomic) IBOutlet UIImageView *starFifthIcon4;
@property (weak, nonatomic) IBOutlet UILabel *customerEvaLbl4;
@property (weak, nonatomic) IBOutlet UILabel *sellerEvaLbl4;
@property (weak, nonatomic) IBOutlet UILabel *customerEvaAgainLbl4;
@property (weak, nonatomic) IBOutlet UIButton *sellerEvaBtn4;
@property (weak, nonatomic) IBOutlet UIImageView *imgView4;

@property (weak, nonatomic) IBOutlet UILabel *nameLbl5;
@property (weak, nonatomic) IBOutlet UIImageView *starFirstIcon5;
@property (weak, nonatomic) IBOutlet UIImageView *starSecondIcon5;
@property (weak, nonatomic) IBOutlet UIImageView *starThirdIcon5;
@property (weak, nonatomic) IBOutlet UIImageView *starFourthIcon5;
@property (weak, nonatomic) IBOutlet UIImageView *starFifthIcon5;
@property (weak, nonatomic) IBOutlet UILabel *customerEvaLbl5;
@property (weak, nonatomic) IBOutlet UILabel *sellerEvaLbl5;
@property (weak, nonatomic) IBOutlet UILabel *customerEvaAgainLbl5;
@property (weak, nonatomic) IBOutlet UILabel *sellerEvaAgainLbl5;
@property (weak, nonatomic) IBOutlet UIImageView *imgView5;


+(instancetype)cellWidthTableView:(UITableView*)tableView index:(NSInteger)index;

@end
