//
//  CYBaseBannerView.m
//  茶语
//
//  Created by Chayu on 16/6/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBaseBannerView.h"
#import "CYHomeInfo.h"
@interface CYBaseBannerView ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIPageControl *pagecontrol;

@property (weak, nonatomic) IBOutlet UIScrollView *bannerScro;


@property (weak, nonatomic) IBOutlet UILabel *typeLbl;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (nonatomic, strong)NSTimer *time;

@end

@implementation CYBaseBannerView


-(void)awakeFromNib
{
    [super awakeFromNib];
    _bannerScro.delegate = self;
    self.time = [NSTimer timerWithTimeInterval:5. target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
}


- (void)setBannserArr:(NSArray *)bannserArr
{
    
    _bannserArr = bannserArr;
    for (UIView *view in _bannerScro.subviews) {
        [view removeFromSuperview];
    }
    [self changeIndex:0];
    [self setupScrollView];
    [self setupPageControl];
}

//添加pageControl
- (void)setupPageControl{
    
    _pagecontrol.numberOfPages = _bannserArr.count;
    [self.time fire];
    [[NSRunLoop currentRunLoop]addTimer:self.time forMode:NSRunLoopCommonModes];
    // 设置圆点的颜色
    [self changePageControlImage:self.pagecontrol];
    
}



//改变pagecontrol中圆点样式
- (void)changePageControlImage:(UIPageControl *)pageControl
{
    static UIImage *imgCurrent = nil;
    static UIImage *imgOther = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imgCurrent = [UIImage imageNamed:@"dot"];
        imgOther = [UIImage imageNamed:@"dotk"];
    });
    if (iOS7) {
//        [pageControl setValue:imgCurrent forKey:@"_currentPageImage"];
//        [pageControl setValue:imgOther forKey:@"_pageImage"];
    } else {
        for (int i = 0;i < _bannserArr.count; i++) {
            UIImageView *imageVieW = [pageControl.subviews objectAtIndex:i];
            imageVieW.frame = CGRectMake(imageVieW.frame.origin.x, imageVieW.frame.origin.y, 20, 20);
            imageVieW.image = pageControl.currentPage == i ? imgCurrent : imgOther;
        }
    }
}


//添加UISrollView
- (void)setupScrollView{
    
    // 添加图片
    for (int i = 0; i<_bannserArr.count; i++) {
        // 创建UIImageView
        CYHomeSlideInfo *info = _bannserArr[i];
        UIImageView *imageView = [[UIImageView alloc] init];
//        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
        imageView.tag = 100 + i;
        imageView.frame = CGRectMake(i * _bannerScro.width, 0, _bannerScro.width, 170*SCREENBILI);
        if (info.thumb.length >0) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:info.thumb] placeholderImage:[UIImage imageNamed:@"750×340"]];
        }
        NSLog(@"imageView.frame = %@",NSStringFromCGRect(imageView.frame));
        [_bannerScro addSubview:imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [imageView addGestureRecognizer:tap];
    }
    
    _bannerScro.contentSize = CGSizeMake(_bannserArr.count * _bannerScro.width, 0);
    _bannerScro.pagingEnabled = YES;
    _bannerScro.showsHorizontalScrollIndicator = NO;
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int halfX = scrollView.frame.size.width / 2;
    int page = (scrollView.contentOffset.x - halfX) / self.bannerScro.width + 1;
    self.pagecontrol.currentPage = page;
    [self changeIndex:page];
    [self changePageControlImage:_pagecontrol];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    int halfX = scrollView.frame.size.width / 2;
    int page = (scrollView.contentOffset.x - halfX) / self.bannerScro.width + 1;
    [self changeIndex:page];
}

-(void)changeIndex:(NSInteger)index
{
    if (_bannserArr.count) {
        CYHomeSlideInfo *info = _bannserArr[index];
        _titleLbl.text = info.title;
        _typeLbl.text = info.tags;
    }
    
}

- (void)timeAction{
    NSInteger page = self.pagecontrol.currentPage;
    [self changeIndex:page];
    page++;
    if (page == _bannserArr.count) {
        page = 0;
    }
    CGPoint point = CGPointMake(self.bannerScro.width * page, 0);
    [self.bannerScro setContentOffset:point animated:YES];
}



-(void)tapClick:(UITapGestureRecognizer *)recognizer{
    
    UIImageView *imaView = (UIImageView *)recognizer.view;
    
    NSLog(@"选中了第%ld个",imaView.tag - 100);
    CYHomeSlideInfo *info = _bannserArr[imaView.tag - 100];
    if (self.gotosomeViewBlock) {
        self.gotosomeViewBlock(info);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
