//
//  CYBuyerRightsApplyVC.m
//  茶语
//
//  Created by Leen on 16/7/5.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerRightsApplyVC.h"
#import "PlaceholderTextView.h"
#import "BaseButton.h"
#import <ZYQAssetPickerController.h>
#import "CYBuyerProductCollectionViewCell.h"
#import "UICommon.h"


static const int ADD_IMG_COUNT = 5;

@interface CYBuyerRightsApplyVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate, UIActionSheetDelegate, ZYQAssetPickerControllerDelegate, UIScrollViewDelegate, UITextFieldDelegate, UITextViewDelegate>
{
    NSMutableArray * _productImgArr;
    UITextField * _currentField;
    NSString * _currentFileName;

}
@property (weak, nonatomic) IBOutlet UIButton *orderSelectBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTxt;
@property (weak, nonatomic) IBOutlet UITextField *weixinTxt;

@property (weak, nonatomic) IBOutlet PlaceholderTextView *desTextView;

@property (weak, nonatomic) IBOutlet UICollectionView *imgCollectView;
@property (weak, nonatomic) IBOutlet BaseButton *okBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *okBtnBottomCons;


@end

@implementation CYBuyerRightsApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _productImgArr = [NSMutableArray array];

    _desTextView.placeholder = @"请描述您所遇到的问题（300字以内）";
    _desTextView.placeholderFont = FONT(14);
    _desTextView.placeholderColor = placeHolderCOLOR;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchUpInsideOn:(id)sender {
    
    UIButton * btn = (UIButton * )sender;
    
    if(btn == _orderSelectBtn)
    {
        
    }
    else if (btn == _okBtn)
    {
        
    }
    
}

- (void) addImageClicked
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"我的相册", nil];
    [sheet showInView:self.view];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        //        [Itost showMsg:@"图片上传中..." inView:self.view];
        
        [picker dismissViewControllerAnimated:YES completion:^() {
            
//            UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
            
            //            image = [UICommon changeImageOrientation:image];
            
            NSString * dateTime = [[info[@"UIImagePickerControllerMediaMetadata"] objectForKey:@"{TIFF}"] objectForKey:@"DateTime"];
            
            _currentFileName = [NSString stringWithFormat:@"%@.png", dateTime];
            
            [_productImgArr addObject:_currentFileName];
            
            [self refreshCollectionView];
        }];
        
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - ZYQAssetPickerController Delegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    NSLog(@"%@",assets);
    
    if (assets.count > 0) {
        
        //        [Itost showMsg:@"图片上传中..." inView:self.view];
        
        for(int i = 0; i < assets.count; i ++)
        {
            ALAsset * ass = assets[i];
            
            ALAssetRepresentation* representation = [ass defaultRepresentation];
            UIImage* portraitImg = [UIImage imageWithCGImage:[representation fullResolutionImage]];
            portraitImg = [UIImage
                           imageWithCGImage:[representation fullScreenImage]
                           scale:[representation scale]
                           orientation:UIImageOrientationUp];
            
            _currentFileName = [representation filename];
            
            [_productImgArr addObject:[representation filename]];
            
            if(i == assets.count - 1)
            {
                [self refreshCollectionView];
            }
        }
        
    }
}

#pragma mark -
#pragma mark UIActionSheetDelegate method
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [UICommon showTakePhoto:self view:self allowsEditing:NO];
    }else if (buttonIndex == 1){
        
        NSInteger count = ADD_IMG_COUNT - _productImgArr.count;
        
        [UICommon showAlbumMore:self view:self number: count];
    }
}

- (void)refreshCollectionView
{
    NSInteger rowCount = 5;
    
    if(SCREEN_WIDTH == 320)
    {
        rowCount = 4;
    }
    
    NSInteger count = _productImgArr.count + 1;
    NSInteger row = (count % rowCount) ? (count / rowCount + 1) : count / rowCount;
    
    _collectionHeightCons.constant = 73 * row;
    
    [_imgCollectView reloadData];
}


- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    _currentField = textField;
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_desTextView resignFirstResponder];
    
    [_currentField resignFirstResponder];
}

#pragma mark -
#pragma mark UICollectionViewDataSource method


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _productImgArr.count == ADD_IMG_COUNT ? ADD_IMG_COUNT: _productImgArr.count + 1 ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *merchIdentify = @"CYBuyerProductCollectionViewCell";
    
    CYBuyerProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:merchIdentify forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageClicked)];
    [cell.imgView addGestureRecognizer:singleTap];
    
    if (indexPath.row == _productImgArr.count)
    {
        cell.deleteBtn.hidden = YES;
    }
    else
    {
        cell.deleteBtn.hidden = NO;
        
    }
    
    return cell;
}

#pragma mark -
#pragma mark 按钮点击事件 method
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
