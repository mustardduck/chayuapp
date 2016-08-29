//
//  CYGuangGaoView.m
//  茶语
//
//  Created by Chayu on 16/6/6.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYGuangGaoView.h"
#import "BXTabBarController.h"
#import "CYArticleDetailViewController.h"
#import "CYProductDetViewController.h"
#import "CYPublicAvtiveViewController.h"
#import "CYTopicDetailController.h"
#import "CYTeaReviewDetailViewController.h"
#import "CYTeaSampleDetailViewController.h"
#import "AppDelegate.h"
#import "CYTuiJianViewController.h"
#import "CYPublicHuoDongViewController.h"
#import "CYWenZhangDetailsController.h"
@interface CYGuangGaoView ()
{
    NSInteger   statusTime;     //倒计时时间
    NSTimer     *countTime;
}
@property (weak, nonatomic) IBOutlet UILabel *altLbl;

@property (nonatomic,strong)NSDictionary *guanggaoInfo;

@end


@implementation CYGuangGaoView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)awakeFromNib
{
    statusTime = 2;
    countTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"首次下载茶语网APP或成功邀请你的朋友下载，即可获得柑普一枚。邀请越多收获越多。"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor getColorWithHexString:@"e25103"] range:NSMakeRange(26,14)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor getColorWithHexString:@"666666"] range:NSMakeRange(30,1)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor getColorWithHexString:@"666666"] range:NSMakeRange(str.length-1,1)];
    _altLbl.attributedText = str;
    
}

#pragma mark 验证码倒计时
-(void)countDown:(NSTimer *)time {
    statusTime --;
    if (statusTime <= -1) {
        [time invalidate];
        countTime = nil;
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
            }
        }];
    }
}

+(void)show:(NSDictionary *)info
{
    CYGuangGaoView *view = [[[NSBundle mainBundle] loadNibNamed:@"CYGuangGaoView" owner:self options:nil] firstObject];
    view.frame = WINDOW.bounds;
    view.guanggaoInfo = info;
    [WINDOW addSubview:view];
}

- (void)setGuanggaoInfo:(NSDictionary *)guanggaoInfo
{
    _guanggaoInfo = guanggaoInfo;
}

- (IBAction)chakanxiangqing_click:(id)sender {
    
    AppDelegate *appledelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    id viewCon = appledelegate.tabBarController.selectedViewController;
    //推荐有礼
    
    NSInteger isYouli = [[_guanggaoInfo objectForKey:@"isYouli"] integerValue];
    if (isYouli == 1) {
        CYTuiJianViewController *vc = viewControllerInStoryBoard(@"CYTuiJianViewController", @"Huodong");
        //        //vc.hidesBottomBarWhenPushed = YES;
        [viewCon pushViewController:vc animated:YES];
        return;
    }
    
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
    
    NSInteger type = [[_guanggaoInfo objectForKey:@"type"] integerValue];
    //        self.mHomeInfo.shardBanner
    //        类型(type=1 跳转市集首页 2文章详情 3商品详情 4茶评详情 5茶样详情 100返回url地址 102//活动)
    //    NSInteger type = [self.mHomeInfo.shardBanner .type integerValue];
    
    switch (type) {
        case 1:
        {
            //            [self.navigationController popToRootViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:tabBarIndex object:@{@"selectIndex":@"2"}];
        }
            break;
        case 2:
        {
            CYArticleInfo *articleInfo = [CYArticleInfo new];
            articleInfo.itemid =[_guanggaoInfo objectForKey:@"data"];
            articleInfo.title = [_guanggaoInfo objectForKey:@"title"];
            CYWenZhangDetailsController *vc = viewControllerInStoryBoard(@"CYWenZhangDetailsController", @"WenZhang");
            vc.wenzhangId = [_guanggaoInfo objectForKey:@"data"];
            //            //vc.hidesBottomBarWhenPushed = YES;
            [viewCon pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            CYProductDetViewController *vc =viewControllerInStoryBoard(@"CYProductDetViewController", @"TeaMall");
            //            //vc.hidesBottomBarWhenPushed = YES;
            vc.goodId = [_guanggaoInfo objectForKey:@"data"];
            [viewCon pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            CYTeaReviewDetailViewController *vc = [[CYTeaReviewDetailViewController alloc] initWithNibName:@"CYTeaReviewDetailViewController" bundle:nil];
            //            //vc.hidesBottomBarWhenPushed = YES;
            vc.mTeaId = [_guanggaoInfo objectForKey:@"data"];;
            [viewCon pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            AppDelegate *applegate = APP_DELEGATE;
            applegate.searchType = CYSearchTypeSample;
            CYTeaSampleDetailViewController *vc = [[CYTeaSampleDetailViewController alloc] initWithNibName:@"CYTeaSampleDetailViewController" bundle:nil];
            //            //vc.hidesBottomBarWhenPushed = YES;
            vc.mSampleid = [_guanggaoInfo objectForKey:@"data"];;
            [viewCon pushViewController:vc animated:YES];
            break;
        }
        case 9:{
            //            CYTuiJianViewController *vc = viewControllerInStoryBoard(@"CYTuiJianViewController", @"Huodong");
            //            //vc.hidesBottomBarWhenPushed = YES;
            //            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 100:
        {
            if (!MANAGER.isLoged) {
                [APP_DELEGATE showLogView];
                return;
            }
            CYPublicAvtiveViewController *vc = viewControllerInStoryBoard(@"CYPublicAvtiveViewController", @"TeaMall");
            vc.requestUrl = [_guanggaoInfo objectForKey:@"data"];;
            vc.titleStr =  [_guanggaoInfo objectForKey:@"title"];
            vc.isRedPack = @"1";
            //            //vc.hidesBottomBarWhenPushed = YES;
            [viewCon pushViewController:vc animated:YES];
        }
            break;
        case 102:
        {
            
            CYPublicHuoDongViewController *vc = viewControllerInStoryBoard(@"CYPublicHuoDongViewController", @"Huodong");
            vc.titleStr = [_guanggaoInfo objectForKey:@"title"];
            vc.requstUrl = [_guanggaoInfo objectForKey:@"data"];
            //            //vc.hidesBottomBarWhenPushed = YES;
            [viewCon pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}



@end
