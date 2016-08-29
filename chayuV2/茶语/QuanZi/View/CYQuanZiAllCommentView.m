//
//  CYQuanZiAllCommentView.m
//  茶语
//
//  Created by Leen on 16/7/27.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYQuanZiAllCommentView.h"
#import "CYMyCommentModel.h"
#import "UIColor+Additions.h"
#import "UICommon.h"
#import "PYMultiLabel.h"

static const CGFloat LINE_PADDING = 7.0;
static const CGFloat LABLE_FONTSIZE = 14.0;

@interface CYQuanZiAllCommentView()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray * _dataArr;
    NSInteger page;
    NSInteger pageSize;
}

@property (weak, nonatomic) IBOutlet UITableView *mainTable;


@end

@implementation CYQuanZiAllCommentView

- (void)setTopicId:(NSString *)topicId
{
    _topicId = topicId;
    
    page = 1;
    _dataArr = [NSMutableArray array];
    hiddenSepretor(_mainTable);
    
    [self loadData];
}

- (void) loadData
{
    __weak __typeof(self) weakSelf = self;
    
    _mainTable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadTableViewData:NO];
    }];
    [_mainTable.header beginRefreshing];
    _mainTable.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadTableViewData:YES];
    }];
}

-(void)loadTableViewData:(BOOL)loadMore
{
    if (loadMore) {
        page ++;
    }else{
        page =1;
        [_dataArr removeAllObjects];
        [_mainTable reloadData];
    }
    __weak __typeof(self) weakSelf = self;
    
    _topicId = @"463195";
    pageSize = 10;
    
    [CYWebClient Post:@"quanzi_comment_lists" parametes:@{@"tid": _topicId, @"p":@(page),@"pageSize":@(pageSize)} success:^(id responObj) {
        
        [_dataArr addObjectsFromArray:[CYQuanZiCommentModel objectArrayWithKeyValuesArray:responObj]];
        
        if (loadMore) {
            [weakSelf.mainTable.footer endRefreshing];
        }else{
            [weakSelf.mainTable.header endRefreshing];
        }
        if ([_dataArr count] < pageSize) {
            [weakSelf.mainTable.footer endRefreshingWithNoMoreData];;
        }
        
        [weakSelf.mainTable reloadData];
        
        
    } failure:^(id err) {
        if (loadMore) {
            [weakSelf.mainTable.footer endRefreshing];
        }else{
            [weakSelf.mainTable.header endRefreshing];
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = (UITableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.height;
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
    
    UILabel * timeLbl = [[UILabel alloc] initWithFrame:CGRectMake(contentLbl.x, contentLbl.y + contentLbl.height + 15, 115, 16)];
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


@end
