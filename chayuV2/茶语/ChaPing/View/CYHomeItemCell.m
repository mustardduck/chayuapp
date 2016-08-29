////
////  CYHomeItemCell.m
////  茶语
////
////  Created by iXcoder on 16/2/21.
////  Copyright © 2016年 Chayu. All rights reserved.
////
//
//
//
//#import "CYHomeItemCell.h"
//
//@implementation CYHomeItemCell
//
//- (void)awakeFromNib {
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
//
//- (void)setItemInfo:(id)itemInfo
//{
//    if ([_itemInfo isEqual:itemInfo]) {
//        return ;
//    }
//    _itemInfo = itemInfo;
//}
//
//+ (CGFloat)cellHeightWithInfo:(id)info
//{
//    return 44.f;
//}
//
//@end
//
//#pragma mark - Home Banner Cell
//@interface CYHomeBannerCell ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
//
//@property (nonatomic, strong) NSMutableArray *banners;
//@property (nonatomic, weak) IBOutlet UICollectionView *bannerView;
//@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
//
//@property (nonatomic, strong) NSTimer *timer;
//
//@end
//
//@implementation CYHomeBannerCell
//
//- (void)awakeFromNib
//{
//    [super awakeFromNib];
//    self.banners = [NSMutableArray array];
//    
//}
//
//- (void)setItemInfo:(id)itemInfo
//{
//    [super setItemInfo:itemInfo];
//    if (self.banners.count > 0) {
//        [self.banners removeAllObjects];
//    }
//    [self.banners addObjectsFromArray:itemInfo];
//    self.pageControl.numberOfPages = self.banners.count;
//    if (self.pageControl.numberOfPages > 0) {
//        self.pageControl.currentPage = 0;
//    }
//    self.bannerView.dataSource = self;
//    self.bannerView.delegate = self;
//    [self.bannerView reloadData];
//    [self startTimer];
//}
//
//+ (CGFloat)cellHeightWithInfo:(id)info
//{
//    return 240.f;
//}
//
//#pragma mark - UICollectionViewDataSource methods
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return self.banners.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"chayuHomeBannerCell" forIndexPath:indexPath];
//    
//    UIImageView *imgView = (UIImageView *)[cell viewWithTag:700];
//    NSDictionary *info = [self.banners objectAtIndex:indexPath.item];
//    NSString *thumb = [info objectForKey:@"thumb"];
//    NSLog(@"thumb:%@", thumb);
//    [imgView sd_setImageWithURL:[NSURL URLWithString:thumb]];
//    
//    return cell;
//}
//
//#pragma mark - UICollectionViewDelegate methods
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (!self.bannerClick) {
//        return ;
//    }
//    NSDictionary *info = [self.banners objectAtIndex:indexPath.item];
//    self.bannerClick(info);
//}
//
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    [self stopTimer];
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    CGFloat xoffset = scrollView.contentOffset.x;
//    CGFloat width = [UIScreen mainScreen].applicationFrame.size.width;
//    self.pageControl.currentPage = xoffset / width;
//    [self startTimer];
//}
//
//#pragma mark - UICollectionViewDelegateFlowLayout
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGFloat width = [UIScreen mainScreen].applicationFrame.size.width;
//    return CGSizeMake(width, 169);
//}
//
//#pragma mark - self defined method
//- (void)startTimer
//{
//    [self stopTimer];
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:5. target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
//}
//
//- (void)stopTimer
//{
//    if (self.timer) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
//}
//
//- (void)timerFired:(NSTimer *)timer
//{
//    if (self.pageControl.currentPage == self.banners.count - 1) {
//        self.pageControl.currentPage = 0;
//    } else {
//        self.pageControl.currentPage ++;
//    }
//    CGFloat width = [UIScreen mainScreen].applicationFrame.size.width;
//    CGPoint offset = CGPointMake(width * self.pageControl.currentPage, 0);
//    [self.bannerView setContentOffset:offset animated:YES];
//}
//
//- (IBAction)onPageControlChangedAction:(id)sender
//{
//    CGFloat appWidth = [UIScreen mainScreen].applicationFrame.size.width;
//    CGPoint offset = CGPointMake(self.pageControl.currentPage * appWidth, 0);
//    [self.bannerView setContentOffset:offset animated:YES];
//}
//
//- (IBAction)onShortCutClick:(id)sender
//{
//    if (!self.shortCutClick) {
//        return ;
//    }
//    UIButton *btn = (UIButton *)sender;
//    NSUInteger idx = btn.tag - 700;
//    self.shortCutClick(idx);
//}
//
//@end
//
//#pragma mark - Home Section Cell
//@interface CYHomeSectionCell ()
//{
//    
//}
//@property (nonatomic, weak) IBOutlet UILabel *titleLbl;
//@property (nonatomic, weak) IBOutlet UIButton *moreBtn;
//
//- (IBAction)onMoreBtnClick:(id)sender;
//
//@end
//
//@implementation CYHomeSectionCell
//
//- (void)setHomeSectionMoreClick:(void (^)())homeSectionMoreClick
//{
//    if (!homeSectionMoreClick) {
//        self.moreBtn.hidden = YES;
//    } else {
//        _homeSectionMoreClick = homeSectionMoreClick;
//        self.moreBtn.hidden = NO;
//    }
//}
//
//- (void)setDiscardMoreBtn:(BOOL)discardMoreBtn
//{
//    _discardMoreBtn = discardMoreBtn;
//    self.moreBtn.hidden = _discardMoreBtn;
//}
//
//- (IBAction)onMoreBtnClick:(id)sender
//{
//    if (self.homeSectionMoreClick) {
//        self.homeSectionMoreClick();
//    }
//}
//
//+ (CGFloat)cellHeightWithInfo:(id)info
//{
//    return 50.f;
//}
//
//#pragma mark - getter & setter
//- (void)setSecTitle:(NSString *)secTitle
//{
//    _secTitle = secTitle;
//    self.titleLbl.text = secTitle;
//}
//
//@end
//
//#pragma mark - Home Tea Kind Cell 茶评茶类
//@interface CYHomeTeaKindCell ()<UICollectionViewDataSource, UICollectionViewDelegate>
//{
//    
//}
//@property (nonatomic, strong) NSArray *teaKinds;
//@property (nonatomic, weak) IBOutlet UICollectionView *ctntView;
//
//- (IBAction)onSwapTeaKindsAction:(id)sender;
//
//@end
//@implementation CYHomeTeaKindCell
//
//- (void)awakeFromNib
//{
//    [super awakeFromNib];
//    self.teaKinds = @[@{@"name":@"绿茶", @"icon":@"ico_tea01", @"id":@"1"}
//                      , @{@"name":@"乌龙", @"icon":@"ico_tea02", @"id":@"2"}
//                      , @{@"name":@"红茶", @"icon":@"ico_tea03", @"id":@"3"}
//                      , @{@"name":@"普洱", @"icon":@"ico_tea04", @"id":@"4"}
//                      , @{@"name":@"黑茶", @"icon":@"ico_tea05", @"id":@"5"}
//                      , @{@"name":@"白茶", @"icon":@"ico_tea06", @"id":@"6"}
//                      , @{@"name":@"黄茶", @"icon":@"ico_tea07", @"id":@"7"}
//                      , @{@"name":@"花茶", @"icon":@"ico_tea08", @"id":@"8"}];
//}
//
//+ (CGFloat)cellHeightWithInfo:(id)info
//{
//    return 97.f;
//}
//
//- (IBAction)onSwapTeaKindsAction:(id)sender
//{
//    BOOL right = [sender tag] - 3000;
//    if ((!right && self.ctntView.contentOffset.x == 0) || (right && self.ctntView.contentOffset.x == 8 * 60.f)) {
//        return ;
//    }
//    CGPoint point = self.ctntView.contentOffset;
//    if (!right) {
//        point = CGPointMake(MAX(0, point.x - CGRectGetWidth(self.ctntView.frame)), point.y);
//    } else {
//        point = CGPointMake(MIN(self.ctntView.contentSize.width - CGRectGetWidth(self.ctntView.frame), point.x + CGRectGetWidth(self.ctntView.frame)), point.y);
//    }
//    [self.ctntView setContentOffset:point animated:YES];
//}
//
//#pragma mark - UICollectionViewDataSource methods
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return self.teaKinds.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeTeaKind" forIndexPath:indexPath];
//    UIImageView *imgView = (UIImageView *)[cell viewWithTag:400];
//    NSDictionary *item = [self.teaKinds objectAtIndex:indexPath.item];
//    imgView.image = [UIImage imageNamed:item[@"icon"]];
//    
//    UILabel *nameLbl = (UILabel *)[cell viewWithTag:500];
//    nameLbl.text = item[@"name"];
//    
//    return cell;
//}
//
//#pragma mark - UICollectionViewDelegate methods
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (!self.teaKindItemClick) {
//        return ;
//    }
//    NSDictionary *kindInfo = [self.teaKinds objectAtIndex:indexPath.item];
//    self.teaKindItemClick(kindInfo);
//}
//
//@end
//
//#pragma mark - Home Top Cell 今日头条&精选文章
//@interface CYHomeTopCell ()
//
//@property (nonatomic, weak) IBOutlet UIImageView *imgView;
//@property (nonatomic, weak) IBOutlet UILabel *titleLbl;
//@property (nonatomic, weak) IBOutlet UILabel *supportLbl;
//@property (nonatomic, weak) IBOutlet UILabel *commentLbl;
//@property (nonatomic, weak) IBOutlet UILabel *timeLbl;
//
//@end
//@implementation CYHomeTopCell
//
//+ (CGFloat)cellHeightWithInfo:(id)info
//{
//    return 95.f;
//}
//
//- (void)setItemInfo:(id)itemInfo
//{
//    [super setItemInfo:itemInfo];
//    NSString *imgPath = [itemInfo objectForKey:@"thumb"];
//    if (imgPath.length > 0) {
//        [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgPath]];
//    } else {
//        self.imgView.image = nil;
//    }
//    
//    NSString *title = [itemInfo objectForKey:@"title"];
//    self.titleLbl.text = title;
//    
//    NSString *suports = [itemInfo objectForKey:@"suports"];
//    self.supportLbl.text = suports;
//    
//    NSString *comments = [itemInfo objectForKey:@"comments"];
//    self.commentLbl.text = comments;
//    
//    NSString *created = [itemInfo objectForKey:@"created"];
//    if (created.length > 0) {
//        created = [NSString stringWithFormat:@"发布于%@", created];
//    }
//    self.timeLbl.text = created;
//}
//
//@end
//
//#pragma mark - Home Tea Recommend Cell 市集好茶
//@interface CYHomeTeaRecommmendCell ()
//
//@property (nonatomic, weak) IBOutlet UIView *item0View;
//@property (nonatomic, weak) IBOutlet UIImageView *item0Img;
//@property (nonatomic, weak) IBOutlet UILabel *price0Lbl;
//@property (nonatomic, weak) IBOutlet UILabel *name0Lbl;
//@property (nonatomic, weak) IBOutlet UILabel *cmmt0Lbl;
//@property (nonatomic, weak) IBOutlet UILabel *sale0Lbl;
//
//@property (nonatomic, weak) IBOutlet UIView *item1View;
//@property (nonatomic, weak) IBOutlet UIImageView *item1Img;
//@property (nonatomic, weak) IBOutlet UILabel *price1Lbl;
//@property (nonatomic, weak) IBOutlet UILabel *name1Lbl;
//@property (nonatomic, weak) IBOutlet UILabel *cmmt1Lbl;
//@property (nonatomic, weak) IBOutlet UILabel *sale1Lbl;
//
//@end
//@implementation CYHomeTeaRecommmendCell
//
//- (void)awakeFromNib
//{
//    [super awakeFromNib];
//    self.item0View.layer.cornerRadius = 5.f;
//    self.item0View.clipsToBounds = YES;
//    
//    self.item1View.layer.cornerRadius = 5.f;
//    self.item1View.clipsToBounds = YES;
//}
//
//- (void)setItemInfo:(id)itemInfo
//{
//    [super setItemInfo:itemInfo];
//    NSArray *teaSet = (NSArray *)itemInfo;
//    teaSet = [teaSet subarrayWithRange:NSMakeRange(1, teaSet.count - 1)];
//    NSDictionary *left = [teaSet firstObject];
//    [self.item0Img sd_cancelCurrentImageLoad];
//    [self.item0Img sd_setImageWithURL:[NSURL URLWithString:left[@"thumb"]]];
//    self.price0Lbl.text = [NSString stringWithFormat:@"￥%@", left[@"price_sell"]];
//    self.name0Lbl.text = left[@"title"];
//    self.cmmt0Lbl.text = [NSString stringWithFormat:@"评论 %@", left[@"commentCount"]];
//    self.sale0Lbl.text = [NSString stringWithFormat:@"已售 %@", left[@"saleCount"]];
//    
//    BOOL hasRight = teaSet.count == 2;
//    self.item1View.hidden = !hasRight;
//    if (!hasRight) {
//        return ;
//    }
//    
//    NSDictionary *right = [teaSet lastObject];
//    [self.item1Img sd_cancelCurrentImageLoad];
//    [self.item1Img sd_setImageWithURL:[NSURL URLWithString:right[@"thumb"]]];
//    self.price1Lbl.text = [NSString stringWithFormat:@"￥%@", right[@"price_sell"]];
//    self.name1Lbl.text = right[@"title"];
//    self.cmmt1Lbl.text = [NSString stringWithFormat:@"评论 %@", right[@"commentCount"]];
//    self.sale1Lbl.text = [NSString stringWithFormat:@"已售 %@", right[@"saleCount"]];
//}
//
//+ (CGFloat)cellHeightWithInfo:(id)info
//{
//    CGFloat height = 250.f;
//    CGFloat appWidth = [UIScreen mainScreen].applicationFrame.size.width;
//    
//    height += (appWidth - 320 - (14 * 3)) / 2;
//    
//    NSDictionary *first = [[info objectForKey:@"itemInfo"] firstObject];
//    if ([[first objectForKey:@"isLastLine"] boolValue]) {
//        height += 14.f;
//    }
//    return height;
//}
//
//- (IBAction)onShowTeaDetail:(id)sender
//{
//    if (!self.teaDetailClick) {
//        return ;
//    }
//    UIButton *button = (UIButton *)sender;
//    NSUInteger tag = button.tag - 402;
//    NSArray *teaSet = (NSArray *)self.itemInfo;
//    teaSet = [teaSet subarrayWithRange:NSMakeRange(1, teaSet.count - 1)];
//    NSDictionary *teaInfo = [teaSet objectAtIndex:tag];
//    self.teaDetailClick(teaInfo);
//}
//
//
//@end
//
//#pragma mark - Home Topic Cell 圈子话题
//@interface CYHomeTopicCell ()
//
//@property (nonatomic, weak) IBOutlet UIImageView *avatar;
//@property (nonatomic, weak) IBOutlet UILabel *nameLbl;
//@property (nonatomic, weak) IBOutlet UILabel *timeLbl;
//@property (nonatomic, weak) IBOutlet UILabel *titleLbl;
//@property (nonatomic, weak) IBOutlet UILabel *ctntLbl;
//
//@property (nonatomic, weak) IBOutlet UIImageView *img0View;
//@property (nonatomic, weak) IBOutlet UIImageView *img1View;
//@property (nonatomic, weak) IBOutlet UIImageView *img2View;
//
//@property (nonatomic, weak) IBOutlet NSLayoutConstraint *bottomCons;
//
//@end
//@implementation CYHomeTopicCell
//
//- (void)awakeFromNib
//{
//    [super awakeFromNib];
//    self.avatar.layer.cornerRadius = 15.f;
//    self.avatar.clipsToBounds = YES;
//}
//
//- (void)setItemInfo:(id)itemInfo
//{
//    [super setItemInfo:itemInfo];
//    
//    NSString *avatar = [itemInfo objectForKey:@"avatar"];
//    [self.avatar sd_cancelCurrentImageLoad];
//    [self.avatar sd_setImageWithURL:[NSURL URLWithString:avatar]];
//    
//    self.nameLbl.text = [itemInfo objectForKey:@"nickname"];
//    self.timeLbl.text = [itemInfo objectForKey:@"created_time"];
//    
//    NSString *title = [itemInfo objectForKey:@"subject"];
//    self.titleLbl.text = title;
//    
//    self.ctntLbl.text = [itemInfo objectForKey:@"content"];
//    
//    NSArray *attaches = [itemInfo objectForKey:@"attach"];
//    for (int i = 0; i < 3; i++) {
//        NSString *imgKey = [NSString stringWithFormat:@"img%dView", i];
//        UIImageView *imgView = [self valueForKeyPath:imgKey];
//        BOOL hidden = i >= attaches.count;
//        imgView.hidden = hidden;
//        if (hidden) {
//            continue;
//        }
//        [imgView sd_cancelCurrentImageLoad];
//        NSString *path = [attaches objectAtIndex:i];
//        [imgView sd_setImageWithURL:[NSURL URLWithString:path]];
//    }
//}
//
//- (void)setIsLast:(BOOL)isLast
//{
//    _isLast = isLast;
//    self.bottomCons.constant = isLast ? -10.f : 0.f;
//}
//
//+ (CGFloat)cellHeightWithInfo:(id)info
//{
//    CGFloat height = 0.f;
//    height += 14.f;
//    height += 30.f;
//    height += 14.f;
//    height += 19.f;
//    
//    NSDictionary *itemInfo = [info objectForKey:@"itemInfo"];
//    
//    NSString *ctnt = [itemInfo objectForKey:@"content"];
//    CGFloat ctntHeight = [ctnt boundingRectWithSize:CGSizeMake(APP_FRAME_WIDTH - 14 * 2, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
//    height += ctntHeight;
//    height += 14.f;
//    NSArray *attaches = [itemInfo objectForKey:@"attach"];
//    if (attaches.count > 0) {
//        height += (APP_FRAME_WIDTH - 14. * 2 - 5. * 2) / 3.;
//        height += 14.f;
//    }
//    
//    
//    
//    BOOL isLast = [[info objectForKey:@"isLast"] boolValue];
//    height += isLast ? 0.f : 10.f;
//    
//    return height + 3;
//}
//
//@end
//
//#pragma mark - Home Topic Cell 圈子话题 顶部三个圈子
//@interface CYHomeTopicTopCell ()
//
//
//@property (weak, nonatomic) IBOutlet UIImageView *img0;
//
//@property (weak, nonatomic) IBOutlet UIImageView *img1;
//
//@property (weak, nonatomic) IBOutlet UIImageView *img2;
//
//@property (weak, nonatomic) IBOutlet UILabel *title0;
//
//
//@property (weak, nonatomic) IBOutlet UILabel *title1;
//
//@property (weak, nonatomic) IBOutlet UILabel *title2;
//
//
//- (IBAction)selectTopic_cate_click:(UIButton *)sender;
//
//
//@end
//
//@implementation CYHomeTopicTopCell
//
//-(void)awakeFromNib
//{
//    
//}
//
//- (void)setItemInfo:(id)itemInfo
//{
//   [super setItemInfo:itemInfo];
//    for (int i = 0; i < [itemInfo count]; i++) {
//        NSDictionary *attaches = itemInfo[i];
//        NSString *imgKey = [NSString stringWithFormat:@"img%d", i];
//        NSString *titleKey = [NSString stringWithFormat:@"title%d",i];
//        UIImageView *imgView = [self valueForKeyPath:imgKey];
//        UILabel *lable = [self valueForKey:titleKey];
//        [imgView sd_cancelCurrentImageLoad];
//        NSString *path = [attaches objectForKey:@"logo"];;
//        [imgView sd_setImageWithURL:[NSURL URLWithString:path] placeholderImage:SQUARE];
//        lable.text = [attaches objectForKey:@"name"];
//    }
//    
//}
//
//
//+ (CGFloat)cellHeightWithInfo:(id)info
//{
//    CGFloat cellHeight = 175.f*(SCREEN_WIDTH/375.);
//    return cellHeight;
//}
//
//
//- (IBAction)selectTopic_cate_click:(UIButton *)sender {
//    NSInteger tag = sender.tag - 6500;
//    if (self.topicClassClick) {
//        self.topicClassClick(self.itemInfo[tag]);
//    }
//}
//@end
//
//
//#pragma mark - Home Tea Evaluate Cell茶评榜&综合评分榜
//@interface CYHomeTeaEvaluateCell ()
//
//@property (nonatomic, weak) IBOutlet UILabel *seqLbl;
//@property (nonatomic, weak) IBOutlet UILabel *titleLbl;
//@property (nonatomic, weak) IBOutlet UILabel *scoreLbl;
//
//@end
//@implementation CYHomeTeaEvaluateCell
//
//- (void)awakeFromNib
//{
//    [super awakeFromNib];
//    self.seqLbl.layer.cornerRadius = 9;
//    self.seqLbl.layer.masksToBounds = YES;
//}
//
//- (void)setItemInfo:(id)itemInfo
//{
//    [super setItemInfo:itemInfo];
//    NSNumber *seq = [itemInfo objectForKey:@"sequence"];
//    self.seqLbl.text = [NSString stringWithFormat:@"%@", seq];
//    
//    NSString *brandName = [itemInfo objectForKey:@"brand"];
//    NSString *title = [itemInfo objectForKey:@"title"];
//    self.titleLbl.text = [NSString stringWithFormat:@"[%@]%@", brandName, title];
//    
//    NSString *score = [itemInfo objectForKey:@"review_score"];
//    if (!score) {
//        score = [itemInfo objectForKey:@"score"];
//    }
//    self.scoreLbl.text = score;
//    
//    UIColor *bgColor = seq.intValue < 4 ? MAIN_COLOR : LIGHTCOLOR;
//    self.seqLbl.backgroundColor = bgColor;
//    self.scoreLbl.textColor = bgColor;
//}
//
//+ (CGFloat)cellHeightWithInfo:(id)info
//{
//    return 40.f;
//}
//
//@end
