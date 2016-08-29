//
//  CYWenZhangCommentView.m
//  茶语
//
//  Created by Leen on 16/7/30.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYWenZhangCommentView.h"
#import "UIColor+Additions.h"
#import "UICommon.h"
#import "PYMultiLabel.h"

static const CGFloat LINE_PADDING = 7.0;
static const CGFloat LABLE_FONTSIZE = 14.0;

@interface CYWenZhangCommentView()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray * _dataArr;
    NSInteger page;
    NSInteger _commentCount;
}

@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property (weak, nonatomic) IBOutlet UILabel *commentLbl;

@property (nonatomic,strong)UIView *footerView;

@property (nonatomic,strong)UIView *emptyFooterView;

@end

@implementation CYWenZhangCommentView


- (void)setItemid:(NSString *)itemid
{
    _itemid = itemid;
    
    if(![_dataArr count] && _itemid)
    {
        [self loadTableViewData:NO];
    }
}

-(void)awakeFromNib
{
    [super awakeFromNib];
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
    
//    _itemid = @"127602";
    _type = @"1";
//    _pageSize = 10;
    
    [CYWebClient Post:@"wenzhang_comment" parametes:@{@"type":_type, @"itemid": _itemid, @"pageNo":@(page),@"pageSize":@(_pageSize)} success:^(id responObj) {
        
        _commentCount = [[responObj objectForJSONKey:@"count"] integerValue];
        
        if(_commentCount)
        {
            _commentLbl.text = [NSString stringWithFormat:@"评论(%ld)", _commentCount];
        }
        
        _endHeight = 0.0f;
        
        [_dataArr addObjectsFromArray:[CYWenZhangCommentModel objectArrayWithKeyValuesArray:[responObj objectForKey:@"list"]]];
        
        for (int i=0; i<[_dataArr count]; i++) {
            
            NSIndexPath * indexP = [NSIndexPath indexPathForRow:i inSection:0];
            
            UITableViewCell * cell = (UITableViewCell *)[self tableView:_mainTable cellForRowAtIndexPath:indexP];
            
            CGFloat cellhegigt = cell.height;
            
            _endHeight +=cellhegigt;
        }
        
        if ([_dataArr count] == _pageSize) {
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WZcommentCell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WZcommentCell"];
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
    
    _endDropHeight += cell.height;
    
    return cell;
    
}

- (void) setTableCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    CYWenZhangCommentModel * model = _dataArr[indexPath.row];
    
    UIImageView * photo = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 40, 40)];
    [photo sd_setImageWithURL:[NSURL URLWithString:model.user.avatar] placeholderImage:SQUARE];
    photo.layer.cornerRadius = photo.width / 2;
    photo.clipsToBounds = YES;
    
    [cell.contentView addSubview:photo];
    
    UILabel * userName = [[UILabel alloc] initWithFrame:CGRectMake(photo.x + photo.width + 12, -2, SCREEN_WIDTH - 92, 48)];
    userName.backgroundColor = [UIColor clearColor];
    userName.font = FONT(LABLE_FONTSIZE);
    userName.textColor = [UIColor brownTitleColor];
    userName.text = model.user.nickname;
    
    [cell.contentView addSubview: userName];
    
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
    timeLbl.text = model.created;
    
    [cell.contentView addSubview:timeLbl];
    
    
    UIImageView * commentIcon = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 62, timeLbl.y, 42, 14)];
    commentIcon.image = [UIImage imageNamed:@"pinglun_huidu_ico"];
    
    [cell.contentView addSubview:commentIcon];
    
    UIButton * zanCountBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 140, timeLbl.y - 17 , 75, 46)];
    if(SCREEN_WIDTH == 320)
    {
        zanCountBtn.x = SCREEN_WIDTH - 130;
    }
    zanCountBtn.backgroundColor = CLEARCOLOR;
    [zanCountBtn setTitle:model.suports forState:UIControlStateNormal];
    [zanCountBtn setTitleColor:[UIColor grayDarkTitleColor] forState:UIControlStateNormal];
    [zanCountBtn setImage:[UIImage imageNamed:@"home_zan_d"] forState:UIControlStateNormal];
    [zanCountBtn setImage:[UIImage imageNamed:@"home_zan_s"] forState:UIControlStateSelected];
    [zanCountBtn setSelected:model.is_suport];
    
    zanCountBtn.titleLabel.font = FONT(12);
    [zanCountBtn addTarget:self action:@selector(zanBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    zanCountBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    zanCountBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    
    [cell.contentView addSubview:zanCountBtn];
    
    
    
    UIButton * commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(commentIcon.x, timeLbl.y - 15, 50, 46)];
    commentBtn.backgroundColor = CLEARCOLOR;
    [commentBtn addTarget:self action:@selector(commentBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.contentView addSubview:commentBtn];
    
    //回复
    if(model.reply.count)
    {
        if(model.reply.count <= 2)
        {
            UIView * replayView = [[UIView alloc] initWithFrame:CGRectMake(timeLbl.x, commentBtn.y + commentBtn.height, SCREEN_WIDTH - timeLbl.x - 20, 0)];
            replayView.backgroundColor = [UIColor grayBackgroundColor];
            replayView.layer.cornerRadius = 2.0f;
            replayView.layer.borderColor = [UIColor grayTitleOrLineColor].CGColor;
            replayView.layer.borderWidth = 0.5f;
            
            for(int i = 0 ; i < model.reply.count; i ++)
            {
                CYWenZhangCommentModel * replyModel = model.reply[i];
                
                UIView * subReplyView = [[UIView alloc] initWithFrame:CGRectMake(0, replayView.height, replayView.width, 1)];
                subReplyView.backgroundColor = CLEARCOLOR;
                [replayView addSubview:subReplyView];
                
                PYMultiLabel * replayTitleLbl = [[PYMultiLabel alloc] initWithFrame:CGRectMake(12, 0, subReplyView.width - 24, 40)];
                replayTitleLbl.textColor = [UIColor grayDarkerTitleColor];
                replayTitleLbl.font = FONT(14);
                replayTitleLbl.text = [NSString stringWithFormat:@"%@回复%@", replyModel.user.nickname, replyModel.touser.nickname];
                [replayTitleLbl setFontColor:[UIColor brownTitleColor] range:NSMakeRange(0, replyModel.user.nickname.length)];
                [replayTitleLbl setFontColor:[UIColor brownTitleColor] range:NSMakeRange(replyModel.user.nickname.length + 2, replyModel.touser.nickname.length)];
                
                [subReplyView addSubview:replayTitleLbl];
                
                //
                UILabel * replyContLbl = [[UILabel alloc] initWithFrame:CGRectMake(replayTitleLbl.x, replayTitleLbl.y + replayTitleLbl.height, replayTitleLbl.width, 20)];
                replyContLbl.numberOfLines = 0;
                replyContLbl.textColor = [UIColor grayDarkerTitleColor];
                replyContLbl.font = FONT(LABLE_FONTSIZE);
                replyContLbl.backgroundColor = CLEARCOLOR;
                
                CGFloat labHeight = [UICommon lableHeightWithString:replyModel.content Size:CGSizeMake(replyContLbl.width, MAXFLOAT) fontSize:LABLE_FONTSIZE];
                
                [UICommon setLabelPadding:replyContLbl text:replyModel.content padding:LINE_PADDING];
                
                NSInteger numberOfLines = labHeight / LABLE_FONTSIZE;
                replyContLbl.height = labHeight + LINE_PADDING * (numberOfLines - 1);
                
                [subReplyView addSubview:replyContLbl];
                
                UILabel * timeLbl = [[UILabel alloc] initWithFrame:CGRectMake(replyContLbl.x, replyContLbl.y + replyContLbl.height + 15, 115, 16)];
                timeLbl.backgroundColor = CLEARCOLOR;
                timeLbl.textColor = [UIColor grayDarkTitleColor];
                timeLbl.font = FONT(12);
                timeLbl.text = replyModel.created;
                
                [subReplyView addSubview:timeLbl];
                
                //回复
                UIImageView * commentIcon = [[UIImageView alloc] initWithFrame:CGRectMake(subReplyView.width - 55, timeLbl.y, 42, 14)];
                commentIcon.image = [UIImage imageNamed:@"pinglun_huidu_ico"];
                
                [subReplyView addSubview:commentIcon];
                
                //赞
                UIButton * zanCountBtn = [[UIButton alloc] initWithFrame:CGRectMake(subReplyView.width - 130, timeLbl.y - 17 , 65, 46)];
                if(SCREEN_WIDTH == 320)
                {
                    zanCountBtn.x = subReplyView.width - 100;
                }
                zanCountBtn.backgroundColor = CLEARCOLOR;
                [zanCountBtn setTitle:replyModel.suports forState:UIControlStateNormal];
                [zanCountBtn setTitleColor:[UIColor grayDarkTitleColor] forState:UIControlStateNormal];
                [zanCountBtn setImage:[UIImage imageNamed:@"home_zan_d"] forState:UIControlStateNormal];
                [zanCountBtn setImage:[UIImage imageNamed:@"home_zan_s"] forState:UIControlStateSelected];
                [zanCountBtn setSelected:replyModel.is_suport];
                
                zanCountBtn.titleLabel.font = FONT(12);
                [zanCountBtn addTarget:self action:@selector(zanBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                zanCountBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                zanCountBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
                
                zanCountBtn.tag = 10000 * indexPath.row + i;
                
                [subReplyView addSubview:zanCountBtn];
                
                
                
                UIButton * commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(commentIcon.x, timeLbl.y - 15, 50, 46)];
                commentBtn.backgroundColor = CLEARCOLOR;
                [commentBtn addTarget:self action:@selector(commentBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                
                commentBtn.tag = 10000 * indexPath.row + i;
                
                [subReplyView addSubview:commentBtn];
                
                subReplyView.height = commentBtn.y + commentBtn.height;
                
                replayView.height = subReplyView.y + subReplyView.height;
                
                UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, subReplyView.height - 0.5, subReplyView.width, 0.5)];
                line.backgroundColor = [UIColor grayTitleOrLineColor];
                
                if(i != model.reply.count - 1)
                {
                    [subReplyView addSubview:line];
                }
            }
            
            [cell.contentView addSubview:replayView];
            
            cell.height = replayView.y + replayView.height + 15;
            
            UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, cell.height - 0.5, SCREEN_WIDTH, 0.5)];
            line.backgroundColor = [UIColor grayTitleOrLineColor];
            [cell.contentView addSubview:line];
        }
        else//展开回复
        {
            UIView * replayView = [[UIView alloc] initWithFrame:CGRectMake(timeLbl.x, commentBtn.y + commentBtn.height, SCREEN_WIDTH - timeLbl.x - 20, 0)];
            replayView.backgroundColor = [UIColor grayBackgroundColor];
            replayView.layer.cornerRadius = 2.0f;
            replayView.layer.borderColor = [UIColor grayTitleOrLineColor].CGColor;
            replayView.layer.borderWidth = 0.5f;
            
            for(int i = 0 ; i < model.reply.count; i ++)
            {
                CYWenZhangCommentModel * replyModel = model.reply[i];
                
                UIView * subReplyView = [[UIView alloc] initWithFrame:CGRectMake(0, replayView.height, replayView.width, 1)];
                subReplyView.backgroundColor = CLEARCOLOR;
                [replayView addSubview:subReplyView];
                
                PYMultiLabel * replayTitleLbl = [[PYMultiLabel alloc] initWithFrame:CGRectMake(12, 0, subReplyView.width - 24, 40)];
                replayTitleLbl.textColor = [UIColor grayDarkerTitleColor];
                replayTitleLbl.font = FONT(14);
                replayTitleLbl.text = [NSString stringWithFormat:@"%@回复%@", replyModel.user.nickname, replyModel.touser.nickname];
                [replayTitleLbl setFontColor:[UIColor brownTitleColor] range:NSMakeRange(0, replyModel.user.nickname.length)];
                [replayTitleLbl setFontColor:[UIColor brownTitleColor] range:NSMakeRange(replyModel.user.nickname.length + 2, replyModel.touser.nickname.length)];
                
                [subReplyView addSubview:replayTitleLbl];
                
                //
                UILabel * replyContLbl = [[UILabel alloc] initWithFrame:CGRectMake(replayTitleLbl.x, replayTitleLbl.y + replayTitleLbl.height, replayTitleLbl.width, 20)];
                replyContLbl.numberOfLines = 0;
                replyContLbl.textColor = [UIColor grayDarkerTitleColor];
                replyContLbl.font = FONT(LABLE_FONTSIZE);
                replyContLbl.backgroundColor = CLEARCOLOR;
                
                CGFloat labHeight = [UICommon lableHeightWithString:replyModel.content Size:CGSizeMake(replyContLbl.width, MAXFLOAT) fontSize:LABLE_FONTSIZE];
                
                [UICommon setLabelPadding:replyContLbl text:replyModel.content padding:LINE_PADDING];
                
                NSInteger numberOfLines = labHeight / LABLE_FONTSIZE;
                replyContLbl.height = labHeight + LINE_PADDING * (numberOfLines - 1);
                
                [subReplyView addSubview:replyContLbl];
                
                UILabel * timeLbl = [[UILabel alloc] initWithFrame:CGRectMake(replyContLbl.x, replyContLbl.y + replyContLbl.height + 15, 115, 16)];
                timeLbl.backgroundColor = CLEARCOLOR;
                timeLbl.textColor = [UIColor grayDarkTitleColor];
                timeLbl.font = FONT(12);
                timeLbl.text = replyModel.created;
                
                [subReplyView addSubview:timeLbl];
                
                //回复
                UIImageView * commentIcon = [[UIImageView alloc] initWithFrame:CGRectMake(subReplyView.width - 62, timeLbl.y, 42, 14)];
                commentIcon.image = [UIImage imageNamed:@"pinglun_huidu_ico"];
                
                [subReplyView addSubview:commentIcon];
                
                //赞
                UIButton * zanCountBtn = [[UIButton alloc] initWithFrame:CGRectMake(subReplyView.width - 130, timeLbl.y - 17 , 65, 46)];
                if(SCREEN_WIDTH == 320)
                {
                    zanCountBtn.x = subReplyView.width - 100;
                }
                zanCountBtn.backgroundColor = CLEARCOLOR;
                [zanCountBtn setTitle:replyModel.suports forState:UIControlStateNormal];
                [zanCountBtn setTitleColor:[UIColor grayDarkTitleColor] forState:UIControlStateNormal];
                [zanCountBtn setImage:[UIImage imageNamed:@"home_zan_d"] forState:UIControlStateNormal];
                [zanCountBtn setImage:[UIImage imageNamed:@"home_zan_s"] forState:UIControlStateSelected];
                [zanCountBtn setSelected:replyModel.is_suport];
                
                zanCountBtn.titleLabel.font = FONT(12);
                [zanCountBtn addTarget:self action:@selector(zanBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                zanCountBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                zanCountBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
                
                zanCountBtn.tag = 10000 * indexPath.row + i;
                
                [subReplyView addSubview:zanCountBtn];
                
                
                
                UIButton * commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(commentIcon.x, timeLbl.y - 15, 50, 46)];
                commentBtn.backgroundColor = CLEARCOLOR;
                [commentBtn addTarget:self action:@selector(commentBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                
                commentBtn.tag = 10000 * indexPath.row + i;
                
                [subReplyView addSubview:commentBtn];
                
                subReplyView.height = commentBtn.y + commentBtn.height;
                replayView.height = subReplyView.y + subReplyView.height;
                
                UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, subReplyView.height - 0.5, subReplyView.width, 0.5)];
                line.backgroundColor = [UIColor grayTitleOrLineColor];
                [subReplyView addSubview:line];
                
                UIButton * dropBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, subReplyView.width, 40)];
                dropBtn.backgroundColor = CLEARCOLOR;
                dropBtn.titleLabel.font = FONT(14);
                [dropBtn setTitle:@"展开回复" forState:UIControlStateNormal];
                [dropBtn setTitle:@"收起回复" forState:UIControlStateSelected];
                [dropBtn setTitleColor:[UIColor grayDarkTitleColor] forState:UIControlStateNormal];
                [dropBtn setTitleColor:[UIColor brownTitleColor] forState:UIControlStateSelected];
                [dropBtn setImage:[UIImage imageNamed:@"downBlackArrowIcon"] forState:UIControlStateNormal];
                [dropBtn setImage:[UIImage imageNamed:@"downBlackArrowIconSelected"] forState:UIControlStateSelected];
                [dropBtn addTarget:self action:@selector(dropBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [dropBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 140, 0, 0)];
                [dropBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
                
                if(i == 1 && !model.isZhanKai)//显示“展开回复”
                {
                    dropBtn.y = subReplyView.y + subReplyView.height;
                    dropBtn.selected = NO;
                    
                    [replayView addSubview:dropBtn];
                    replayView.height = dropBtn.y + dropBtn.height;
                    
                    [cell.contentView addSubview:replayView];
                    
                    cell.height = replayView.y + replayView.height + 15;
                    
                    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, cell.height - 0.5, SCREEN_WIDTH, 0.5)];
                    line.backgroundColor = [UIColor grayTitleOrLineColor];
                    [cell.contentView addSubview:line];
                    
                    return;
                }
                else if (i == model.reply.count - 1 && model.isZhanKai)//显示“收起回复”
                {
                    dropBtn.y = subReplyView.y + subReplyView.height;
                    dropBtn.selected = YES;
                    
                    [replayView addSubview:dropBtn];
                    replayView.height = dropBtn.y + dropBtn.height;
                    
                    [cell.contentView addSubview:replayView];
                    
                    cell.height = replayView.y + replayView.height + 15;
                    
                    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, cell.height - 0.5, SCREEN_WIDTH, 0.5)];
                    line.backgroundColor = [UIColor grayTitleOrLineColor];
                    [cell.contentView addSubview:line];
                    
                }
            }
        }
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
    
    BOOL isSubRow = NO;
    
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    
    
    if(![cell isKindOfClass:[UITableViewCell class]])
    {
        cell = (UITableViewCell *)[[[[sender superview] superview] superview] superview];
        
        isSubRow = YES;
    }
    NSIndexPath * indexP = [_mainTable indexPathForCell:cell];
    
    __block CYWenZhangCommentModel * model = _dataArr[indexP.row];
    
    NSString * itemIdStr = model.commentId;
    
    CYWenZhangCommentModel * replyModel;
    
    if(isSubRow)
    {
        NSInteger index = btn.tag % 10000 ;
        
        replyModel = model.reply[index];
        
        itemIdStr = replyModel.commentId;
    }
    
    NSString *class = btn.selected?@"0":@"1";
    
    /**
     *  类型1文章 2茶评评鉴 4话题 10文章评论&回复 11帖子回复12茶评品鉴回复
     */
    
    [SVProgressHUD setBackgroundColor:CLEARCOLOR];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD show];
    [CYWebClient Post:@"do_suport" parametes:@{@"itemid":itemIdStr,@"type":@"10",@"class":class} success:^(id responObject) {
        if ([[responObject objectForKey:@"do"] integerValue] ==0) {
            btn.selected = NO;
        }else{
            btn.selected = YES;
        }
        
        if(isSubRow)
        {
            replyModel.is_suport = btn.selected;
            
            NSInteger suports = [replyModel.suports integerValue];
            
            replyModel.suports = btn.selected ? [NSString stringWithFormat:@"%ld", suports + 1] : [NSString stringWithFormat:@"%ld", suports - 1];
            
            [btn setTitle:replyModel.suports forState:UIControlStateNormal];
        }
        else
        {
            model.is_suport = btn.selected;
            
            NSInteger suports = [model.suports integerValue];
            
            model.suports = btn.selected ? [NSString stringWithFormat:@"%ld", suports + 1] : [NSString stringWithFormat:@"%ld", suports - 1];
            
            [btn setTitle:model.suports forState:UIControlStateNormal];
            
        }
        
    } failure:^(id error) {
        
    }];
    
}

- (void)dropBtnClicked:(id)sender
{
    UITableViewCell * cell = (UITableViewCell *)[[[sender superview] superview] superview];
    NSIndexPath * indexP = [_mainTable indexPathForCell:cell];
    
    CYWenZhangCommentModel * model = _dataArr[indexP.row];
    UIButton * btn = (UIButton *)sender;
    [btn setSelected:!btn.selected];
    model.isZhanKai = btn.selected;
    
    _endDropHeight = 0.0;
    
    [_mainTable reloadData];
    
    if(_commentCount > _pageSize)
    {
        self.height = _endDropHeight + self.footerView.height + 60;
    }
    else
    {
        self.height = _endDropHeight + 60;
    }
}

- (IBAction)huifu_click
{
    if ([self.delegate respondsToSelector:@selector(huifu_click)]) {
        [self.delegate huifu_click];
    }
}

- (void)commentBtnClicked:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    
    BOOL isSubRow = NO;
    
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    
    
    if(![cell isKindOfClass:[UITableViewCell class]])
    {
        cell = (UITableViewCell *)[[[[sender superview] superview] superview] superview];
        
        isSubRow = YES;
    }
    NSIndexPath * indexP = [_mainTable indexPathForCell:cell];
    
    __block CYWenZhangCommentModel * model = _dataArr[indexP.row];
    
    CYWenZhangCommentModel * replyModel;
    
    NSString * commentId = model.commentId;
    
    if(isSubRow)
    {
        NSInteger index = btn.tag % 10000 ;
        
        replyModel = model.reply[index];
        
        commentId = replyModel.pid;
    }
    
    if ([self.delegate respondsToSelector:@selector(commentBtnClicked:)]) {
        
        CYWenZhangCommentModel * commentModel = [[CYWenZhangCommentModel alloc] init];
        commentModel.commentId = commentId;
        commentModel.itemid = model.itemid;
        commentModel.uid = model.uid;
        
        [self.delegate commentBtnClicked:commentModel];
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
        lable.text = @"暂无评价";
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

@end


