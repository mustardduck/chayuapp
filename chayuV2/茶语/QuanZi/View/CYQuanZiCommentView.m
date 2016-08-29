//
//  CYQuznZiCommentView.m
//  茶语
//暂无评价
//  Created by Leen on 16/7/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYQuanZiCommentView.h"
#import "UIColor+Additions.h"
#import "UICommon.h"
#import "PYMultiLabel.h"

static const CGFloat LINE_PADDING = 7.0;
static const CGFloat LABLE_FONTSIZE = 14.0;

@interface CYQuanZiCommentView()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray * _dataArr;
    NSInteger page;
}

@property (weak, nonatomic) IBOutlet UITableView *mainTable;

@property (nonatomic,strong)UIView *footerView;

@property (nonatomic,strong)UIView *emptyFooterView;

@end

@implementation CYQuanZiCommentView

- (void)setTopicId:(NSString *)topicId
{
    _topicId = topicId;
    
    if(![_dataArr count] && _topicId)
    {
        [self loadTableViewData:NO];
    }
    
}

-(void)awakeFromNib
{
    [self addObserver:self
           forKeyPath:@"height"
              options:NSKeyValueObservingOptionNew
              context:nil];
    
    page = 1;
    _dataArr = [NSMutableArray array];
    hiddenSepretor(_mainTable);
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (![keyPath isEqualToString:@"height"]) {
        return ;
    }
    if ([self.delegate respondsToSelector:@selector(evaluationViewendHeight:)]) {
        [self.delegate evaluationViewendHeight:[[change objectForKey:@"new"] floatValue]];
    }
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"height"];
}

-(void)loadTableViewData:(BOOL)loadMore
{
    [_dataArr removeAllObjects];
    
    __weak __typeof(self) weakSelf = self;
    
//    _topicId = @"463195";
//    _pageSize = 10;
    
    [CYWebClient Post:@"quanzi_comment_lists" parametes:@{@"tid": _topicId, @"p":@(page),@"pageSize":@(_pageSize)} success:^(id responObj) {
        
        _endHeight = 0.0f;

        [_dataArr addObjectsFromArray:[CYQuanZiCommentModel objectArrayWithKeyValuesArray:responObj]];
        
        for (int i=0; i<[_dataArr count]; i++) {
            
            NSIndexPath * indexP = [NSIndexPath indexPathForRow:i inSection:0];
            
            UITableViewCell * cell = (UITableViewCell *)[self tableView:_mainTable cellForRowAtIndexPath:indexP];
            
            CGFloat cellhegigt = cell.height;
            
            _endHeight +=cellhegigt;
        }
        
        if ([responObj count] == _pageSize) {
            weakSelf.mainTable.tableFooterView = weakSelf.footerView;
            weakSelf.height = _endHeight+ weakSelf.footerView.height + 60;
        }else{
            weakSelf.height = _endHeight + 60;
        }
        
        weakSelf.width = SCREEN_WIDTH;
        if ([_dataArr count]==0) {
            weakSelf.mainTable.tableFooterView = weakSelf.emptyFooterView;
            weakSelf.height = weakSelf.emptyFooterView.height + 60;
        }
        
        [weakSelf.mainTable reloadData];
        
    } failure:^(id err) {
        NSLog(@"%@",err);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = (UITableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QZcommentCell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QZcommentCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    else
    {
        for(UIView * view in [cell.contentView subviews])
        {
            [view removeFromSuperview];
        }
    }
    
    [self setTableCell:cell indexPath:indexPath];
    
    return cell;
    
}

- (void)imgBtnClicked:(id)sender
{
    UIButton * imgBtn = (UIButton *)sender;
    UITableViewCell * cell = (UITableViewCell *)[[[imgBtn superview] superview] superview];
    
    NSIndexPath * indexP = [_mainTable indexPathForCell:cell];
    
    CYQuanZiCommentModel * model = _dataArr[indexP.row];
    
    if ([self.delegate respondsToSelector:@selector(seeFullScreenClicked:currentPage:)]) {
        [self.delegate seeFullScreenClicked:model currentPage:imgBtn.tag];
    }
}

- (void) setTableCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    CYQuanZiCommentModel * model = _dataArr[indexPath.row];
    
    UIImageView * photo = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 40, 40)];
    [photo sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:SQUARE];
    photo.layer.cornerRadius = photo.width / 2;
    photo.clipsToBounds = YES;
    
    [cell.contentView addSubview:photo];
    
    UILabel * userName = [[UILabel alloc] initWithFrame:CGRectMake(photo.x + photo.width + 12, -2, SCREEN_WIDTH - 92, 48)];
    userName.backgroundColor = [UIColor clearColor];
    userName.font = FONT(LABLE_FONTSIZE);
    userName.textColor = [UIColor brownTitleColor];
    userName.text = model.nickname;
    
    [cell.contentView addSubview: userName];
    
    //楼层
//    UILabel * floorLbl = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100, - 2, 80, 48)];
//    floorLbl.backgroundColor = CLEARCOLOR;
//    floorLbl.textAlignment = NSTextAlignmentRight;
//    floorLbl.font = FONT(14);
//    floorLbl.textColor = [UIColor grayDarkerTitleColor];
//    floorLbl.text = [NSString stringWithFormat:@"%ld楼", indexPath.row + 1 ];
//    
//    [cell.contentView addSubview:floorLbl];
    
    UILabel * contentLbl = [[UILabel alloc] initWithFrame:CGRectMake(userName.x, userName.y + userName.height, userName.width, 20)];
    contentLbl.numberOfLines = 0;
    contentLbl.textColor = [UIColor blackTitleColor];
    contentLbl.font = FONT(LABLE_FONTSIZE);
    contentLbl.backgroundColor = CLEARCOLOR;
    
    CGFloat labHeight = [UICommon lableHeightWithString:model.content Size:CGSizeMake(contentLbl.width, MAXFLOAT) fontSize:LABLE_FONTSIZE];
    
    [UICommon setLabelPadding:contentLbl text:model.content padding:LINE_PADDING];
    
    NSInteger numberOfLines = labHeight / LABLE_FONTSIZE;
    contentLbl.height = labHeight + LINE_PADDING * (numberOfLines - 1);
    
    [cell.contentView addSubview:contentLbl];
    
    //回复带图片（最多 9 张）
    CGFloat imgWidth = (SCREEN_WIDTH - 92 - 5 * 2) / 3;
    UIView * imgView = [[UIView alloc] initWithFrame:CGRectMake(72, contentLbl.y + contentLbl.height + 10, SCREEN_WIDTH - 92, imgWidth)];
    
    if(model.attach.count)
    {
        NSInteger row = model.attach.count % 3 ? model.attach.count / 3 + 1 : model.attach.count / 3;
        
        for(int i = 0 ; i < model.attach.count; i ++ )
        {
            NSString * url = model.attach[i];
            
            NSInteger y = i / 3;
            NSInteger x = i % 3;
            
            UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake((imgWidth + 5) * x, (imgWidth + 5) * y, imgWidth, imgWidth)];
            
            [img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:SQUARE];

            
            UIButton *imgBtn = [[UIButton alloc] initWithFrame:img.frame];
            imgBtn.backgroundColor = [UIColor clearColor];
            imgBtn.tag = i;
            [imgBtn addTarget:self action:@selector(imgBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            [imgView addSubview:imgBtn];
            
            [imgView addSubview:img];
            
        }
        
        imgView.height = (imgWidth + 5) * row - 5;
        
        [cell.contentView addSubview:imgView];
    }
    
    

    UILabel * timeLbl = [[UILabel alloc] initWithFrame:CGRectMake(contentLbl.x, contentLbl.y + contentLbl.height + 15, 115, 16)];
    if(model.attach.count)
    {
        timeLbl.y = imgView.y + imgView.height + 15;
    }

    timeLbl.backgroundColor = CLEARCOLOR;
    timeLbl.textColor = [UIColor grayDarkTitleColor];
    timeLbl.font = FONT(12);
    timeLbl.text = model.created_time;
    
    [cell.contentView addSubview:timeLbl];
    
    
    UIImageView * commentIcon = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 62, timeLbl.y, 42, 14)];
    commentIcon.image = [UIImage imageNamed:@"pinglun_huidu_ico"];
    
    [cell.contentView addSubview:commentIcon];
    
    UIButton * zanCountBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 140, timeLbl.y - 17 , 75, 46)];
    zanCountBtn.backgroundColor = CLEARCOLOR;
    [zanCountBtn setTitle:model.praises forState:UIControlStateNormal];
    [zanCountBtn setTitleColor:[UIColor grayDarkTitleColor] forState:UIControlStateNormal];
    [zanCountBtn setImage:[UIImage imageNamed:@"home_zan_d"] forState:UIControlStateNormal];
    [zanCountBtn setImage:[UIImage imageNamed:@"home_zan_s"] forState:UIControlStateSelected];
    [zanCountBtn setSelected:model.isSuported];
    
    zanCountBtn.titleLabel.font = FONT(12);
    [zanCountBtn addTarget:self action:@selector(zanBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    zanCountBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    zanCountBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    
    [cell.contentView addSubview:zanCountBtn];
    
    
    
    UIButton * commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(commentIcon.x, timeLbl.y - 15, 50, 46)];
    commentBtn.backgroundColor = CLEARCOLOR;
    [commentBtn addTarget:self action:@selector(commentBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.contentView addSubview:commentBtn];
    
    //有引用
    if(model.rpostContent.length)
    {
        UIView * replayView = [[UIView alloc] initWithFrame:CGRectMake(userName.x, userName.y + userName.height, SCREEN_WIDTH - userName.x - 20, 0)];
        replayView.backgroundColor = [UIColor grayBackgroundColor];
        replayView.layer.cornerRadius = 2.0f;
        replayView.layer.borderColor = [UIColor grayTitleOrLineColor].CGColor;
        replayView.layer.borderWidth = 0.5f;
        
        [cell.contentView addSubview:replayView];
        
        
        PYMultiLabel * yinyongLbl = [[PYMultiLabel alloc] initWithFrame:CGRectMake(12, 0, replayView.width - 24, 20)];
        yinyongLbl.numberOfLines = 0;
        yinyongLbl.textColor = [UIColor grayDarkerTitleColor];
        yinyongLbl.font = FONT(LABLE_FONTSIZE);
        yinyongLbl.backgroundColor = CLEARCOLOR;
        
        NSString * rpostText = [NSString stringWithFormat:@"引用%@的话：%@", model.rpostCreatedNickname, model.rpostContent];
        
        CGFloat labHeight = [UICommon lableHeightWithString:rpostText Size:CGSizeMake(yinyongLbl.width, MAXFLOAT) fontSize:LABLE_FONTSIZE];
        
        [UICommon setLabelPadding:yinyongLbl text:rpostText padding:LINE_PADDING];
        [yinyongLbl setFontColor:[UIColor brownTitleColor] range:NSMakeRange(2, model.rpostCreatedNickname.length)];
        
        NSInteger numberOfLines = labHeight / LABLE_FONTSIZE;
        yinyongLbl.height = labHeight + LINE_PADDING * (numberOfLines - 1) + 12 * 2;
        
        replayView.height = yinyongLbl.height;
        
        [replayView addSubview:yinyongLbl];
        
        contentLbl.y = replayView.y + replayView.height + 15;
        timeLbl.y = contentLbl.y + contentLbl.height + 15;
        if(model.attach.count)
        {
            imgView.y = contentLbl.y + contentLbl.height + 10;
            timeLbl.y = imgView.y + imgView.height + 15;
        }
        commentIcon.y = timeLbl.y;
        zanCountBtn.y = timeLbl.y - 17;
        commentBtn.y = timeLbl.y - 15;
        
        cell.height = commentBtn.y + commentBtn.height;
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, cell.height - 0.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor grayTitleOrLineColor];
        [cell.contentView addSubview:line];
    }
    else
    {
        cell.height = commentBtn.y + commentBtn.height;
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, cell.height - 0.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor grayTitleOrLineColor];
        [cell.contentView addSubview:line];
    }
    
}

- (void)zanBtnClicked:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    
    NSIndexPath * indexP = [_mainTable indexPathForCell:cell];
    
    CYQuanZiCommentModel * model = _dataArr[indexP.row];
    
    NSString * itemIdStr = model.pid;
    
    NSString *class = btn.selected?@"0":@"1";
    
    /**
     *  类型1文章 2茶评评鉴 4话题 10文章评论&回复 11帖子回复12茶评品鉴回复
     */
    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD show];
    [CYWebClient Post:@"do_suport" parametes:@{@"itemid":itemIdStr,@"type":@"11",@"class":class} success:^(id responObject) {
        if ([[responObject objectForKey:@"do"] integerValue] ==0) {
            btn.selected = NO;
        }else{
            btn.selected = YES;
        }
        
        model.isSuported = btn.selected;
        
        NSInteger suports = [model.praises integerValue];
        
        model.praises = btn.selected ? [NSString stringWithFormat:@"%ld", suports + 1] : [NSString stringWithFormat:@"%ld", suports - 1];
        
        [btn setTitle:model.praises forState:UIControlStateNormal];
        
    } failure:^(id error) {
        
    }];
    
}

- (void)commentBtnClicked:(id)sender
{
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    
    NSIndexPath * indexP = [_mainTable indexPathForCell:cell];
    
    CYQuanZiCommentModel * model = _dataArr[indexP.row];
    
    if ([self.delegate respondsToSelector:@selector(commentBtnClicked:)]) {
        [self.delegate commentBtnClicked:model];
    }
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UIView *)footerView
{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
        _footerView.backgroundColor = [UIColor whiteColor];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"加载更多" forState:UIControlStateNormal];
        button.frame = CGRectMake(20, 15,SCREEN_WIDTH - 40, 40);
        button.backgroundColor = RGB(245, 245, 245);
        button.titleLabel.font = FONT(14.0f);
        [button setTitleColor:[UIColor grayDarkerTitleColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showAlleva) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:button];
    }
    return _footerView;
}

- (void)showAlleva
{
    if ([self.delegate respondsToSelector:@selector(showAllEvaluation)]) {
        [self.delegate showAllEvaluation];
    }
}

-(UIView *)emptyFooterView
{
    if (!_emptyFooterView) {
        _emptyFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        UILabel *lable =[[UILabel alloc] initWithFrame:CGRectMake(20, 10, _emptyFooterView.width-40, 30)];
        lable.textColor = CONTENTCOLOR;
        lable.text = @"暂无回复";
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = FONT(16.0f);
        UIView *view = lable;
        view.layer.borderColor = LINECOLOR.CGColor;
        view.layer.borderWidth = 1.0f;
        view.layer.cornerRadius = 3.0f;
        [_emptyFooterView addSubview:lable];
        
    }
    return _emptyFooterView;
}

- (IBAction)huitie_click:(id)sender {
    if ([self.delegate respondsToSelector:@selector(huitie_click)]) {
        [self.delegate huitie_click];
    }
}

@end

