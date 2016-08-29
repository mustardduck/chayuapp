//
//  CYBuyerProfileVC.m
//  茶语
//
//  Created by Leen on 16/7/2.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerProfileVC.h"
#import "CYBuyerProfileHeaderView.h"
#import "CYBuyerProfileFooterView.h"
#import "UICommon.h"
#import "UILabel+Utilities.h"
#import "UIColor+Additions.h"
#import "CYBuyerProfileContentVC.h"
#import "UICommon.h"

@interface CYBuyerProfileVC ()<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>
{
    BOOL _isUploadTouImage;
}

@property (nonatomic, strong) CYBuyerProfileHeaderView * headerView;
@property (nonatomic, strong) CYBuyerProfileFooterView * footerView;
@property (weak, nonatomic) IBOutlet UITableView *mainTable;

@property (nonatomic, strong) NSMutableArray * dataArr;

@end

@implementation CYBuyerProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = [NSMutableArray array];
    _mainTable.tableHeaderView = self.headerView;
    _mainTable.tableFooterView = self.footerView;
    
    __weak typeof(self) weakself = self;
    
    _headerView.addTouImageBlock = ^()
    {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"人物介绍图" delegate:weakself cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照",nil];
        _isUploadTouImage = YES;
        [sheet showInView:weakself.view];
        
    };
    
    _footerView.addContentBlock = ^()
    {
        CYBuyerProfileContentVC * profileVC = viewControllerInStoryBoard(@"CYBuyerProfileContentVC", @"Buyer");
        profileVC.saveContentBlock = ^(NSString * contentText)
        {
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            
            [dic setObject:contentText forKey:@"content"];
            [dic setObject:@"1" forKey:@"type"];
            
            [weakself.dataArr addObject:dic];
            
            [weakself.mainTable reloadData];
        };
        
        [weakself.navigationController pushViewController:profileVC animated:YES];
    };
    
    _footerView.addImageBlock = ^()//上传图片
    {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:weakself cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照",nil];

        [sheet showInView:weakself.view];
    };
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [UICommon showAlbum:self view:self];
        
    }else if (buttonIndex == 1){
        [UICommon showTakePhoto:self view:self allowsEditing:YES];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if(_isUploadTouImage)
    {
        _headerView.touImageView.image = image;
        
        _mainTable.tableHeaderView = self.headerView;
        
        _isUploadTouImage = NO;
    }
    else
    {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:image forKey:@"image"];
        [dic setObject:@"2" forKey:@"type"];
        [_dataArr addObject:dic];
        
        [self.mainTable reloadData];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = (UITableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"profileCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    else
    {
        for(UIView * view in [cell.contentView subviews])
        {
            [view removeFromSuperview];
        }
    }
    
    NSDictionary * dic = _dataArr[indexPath.row];
    
    NSInteger type = [[dic objectForJSONKey:@"type"] integerValue];//type 1 介绍 2 图片
    
    if(type == 1)
    {
        NSString * content = [dic objectForJSONKey:@"content"];
        
        UILabel * contentLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 55 - 20, 0)];
        contentLbl.textColor = [UIColor grayTextColor];
        contentLbl.font = FONT(16);
        contentLbl.backgroundColor = [UIColor clearColor];
        contentLbl.numberOfLines = 0;
        
        
        CGFloat labHeight = [UICommon lableHeightWithString:content Size:CGSizeMake(contentLbl.width,MAXFLOAT) fontSize:16];
        
        [UICommon setLabelPadding:contentLbl text:content padding:6];
        NSInteger numberOfLines = labHeight / 16;
        contentLbl.height = labHeight + 6 * (numberOfLines - 1) + 15 * 2;
        
        [cell.contentView addSubview:contentLbl];
        
        UIButton *contDelBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 55, 0, 55, contentLbl.height)];
        contDelBtn.backgroundColor = [UIColor clearColor];
        [contDelBtn setImage:[UIImage imageNamed:@"profileCloseBtnIcon"] forState:UIControlStateNormal];
        [contDelBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [contDelBtn setContentEdgeInsets:UIEdgeInsetsMake(15, 0, 0, 0)];
        [contDelBtn addTarget:self action:@selector(deleteClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:contDelBtn];
        
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, contentLbl.y + contentLbl.height - 0.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor grayTitleOrLineColor];
        
        if(indexPath.row < _dataArr.count - 1)
        {
            [cell.contentView addSubview:line];
        }
        
        cell.height = contentLbl.y + contentLbl.height;

    }
    else
    {
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 150) / 2, 15, 150, 100)];
        NSString * imgUrl = [dic objectForJSONKey:@"imgUrl"];
        [cell.contentView addSubview:imgView];
        
        if(imgUrl.length)
        {        [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"750×500"]];
        }
        else
        {
            UIImage * img = [dic objectForJSONKey:@"image"];
            
            if(img)
            {
                imgView.image = img;
            }
        }
        
        UIButton *contDelBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 55, 0, 55, imgView.height)];
        contDelBtn.backgroundColor = [UIColor clearColor];
        [contDelBtn setImage:[UIImage imageNamed:@"profileCloseBtnIcon"] forState:UIControlStateNormal];
        [contDelBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [contDelBtn setContentEdgeInsets:UIEdgeInsetsMake(15, 0, 0, 0)];
        [contDelBtn addTarget:self action:@selector(deleteClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:contDelBtn];
        
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, imgView.y + imgView.height + 15 - 0.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = RGB(229, 229, 229);
        
        if(indexPath.row < _dataArr.count - 1)
        {
            [cell.contentView addSubview:line];
        }
        
        cell.height = imgView.y + imgView.height + 15;
    }
    
    return cell;
}

- (void)deleteClicked:(id)sender
{
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    
    NSIndexPath * indexp = [_mainTable indexPathForCell:cell];
    
    [_dataArr removeObjectAtIndex:indexp.row];
    
    [_mainTable reloadData];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (CYBuyerProfileHeaderView *)headerView
{
    if(!_headerView)
    {
        CGFloat he = 212 *(SCREEN_WIDTH / 375.) + 45;
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerProfileHeaderView" owner:nil options:nil] firstObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, he);
    }
    
    return _headerView;
}

- (CYBuyerProfileFooterView *)footerView
{
    if(!_footerView)
    {
        _footerView = [[[NSBundle mainBundle] loadNibNamed:@"CYBuyerProfileFooterView" owner:nil options:nil] firstObject];
        _footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 235);
    }
    return _footerView;
}

- (IBAction)goback:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
