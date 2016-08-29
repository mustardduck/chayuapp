//
//  CYBuyerPDEditVC.m
//  茶语
//
//  Created by Leen on 16/6/16.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerPDEditVC.h"
#import "CYBuyerProductCollectionViewCell.h"
#import "UICommon.h"
#import <ZYQAssetPickerController.h>
#import "PlaceholderTextView.h"
#import "BaseButton.h"
#import "CYBuyerPDTagVC.h"
#import "CYBuyerPDCategorySubVC.h"
#import "CYBuyerPDImageDescVC.h"
#import "CYHomeInfo.h"

static const int ADD_IMG_COUNT = 9;

@interface CYBuyerPDEditVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UIActionSheetDelegate, ZYQAssetPickerControllerDelegate, UIScrollViewDelegate, UITextFieldDelegate, UITextViewDelegate>
{
    NSMutableArray * _productImgArr;
    
    NSString * _currentFileName;
    
    UITextField * _currentField;
}


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHeightCons;

@property (weak, nonatomic) IBOutlet UICollectionView *pdCollectView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *okBtnBottomCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pdCollectTopCons;

- (IBAction)okBtnClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *categoryBtn;
@property (weak, nonatomic) IBOutlet UITextField *titleTXT;
@property (weak, nonatomic) IBOutlet UITextField *priceTXT;
@property (weak, nonatomic) IBOutlet UITextField *totalCountTXT;
@property (weak, nonatomic) IBOutlet PlaceholderTextView *desTextView;
@property (weak, nonatomic) IBOutlet UIButton *tagBtn;
@property (weak, nonatomic) IBOutlet BaseButton *okBtn;


@end

@implementation CYBuyerPDEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _productImgArr = [NSMutableArray array];
    
    _desTextView.placeholder = @"请输入详细的商品介绍（最多输入 500 个字）";
    _desTextView.placeholderFont = FONT(14);
    _desTextView.placeholderColor = placeHolderCOLOR;
    
    [_pdCollectView registerNib:[UINib nibWithNibName:@"CYBuyerProductCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CYBuyerProductCollectionViewCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)touchUpInsideOn:(id)sender {
    
    UIButton * btn = (UIButton * )sender;
    
    if(btn == _tagBtn)
    {
        CYBuyerPDTagVC *tdc = viewControllerInStoryBoard(@"CYBuyerPDTagVC", @"Buyer");
        [self.navigationController pushViewController:tdc animated:YES];
    }
    else if (btn == _categoryBtn)
    {
        CYBuyerPDCategorySubVC *tdc = viewControllerInStoryBoard(@"CYBuyerPDCategorySubVC", @"Buyer");
        [self.navigationController pushViewController:tdc animated:YES];
    }
}


- (IBAction)okBtnClicked:(id)sender {
    
    
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
            
//            NSString * userImgPath = @"";
//            
//            BOOL isOk = [LoginUser uploadImageWithScale:image fileName:_currentFileName userImgPath:&userImgPath];
//            
//            if(isOk)
//            {
//                [SVProgressHUD dismiss];
//                
//                NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
//                [dic setObject:userImgPath forKey:@"url"];
//                
//                if (_currentItem == -1) {
//                    Accessory * acc = [Accessory new];
//                    acc.address = userImgPath;
//                    acc.name = _currentFileName;
//                    
//                    [self.cAccessoryArray addObject:acc];
//                    
//                }
//                
//                [self refreshCollectionView];
//            }
        }];
        
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

- (void)refreshCollectionView
{
    NSInteger rowCount = 4;
    
//    if(SCREEN_WIDTH == 320)
//    {
//        rowCount = 4;
//    }
    
    NSInteger count = _productImgArr.count + 1;
    NSInteger row = (count % rowCount) ? (count / rowCount + 1) : count / rowCount;
    
    _collectionHeightCons.constant = 89 * row;
    
    if(SCREEN_WIDTH > 320)
    {
        _pdCollectTopCons.constant = count > 1 ? 31 : 4;
    }
    else
    {
        _pdCollectTopCons.constant = count > 1 ? 51 : 4;
    }
    
    [_pdCollectView reloadData];
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
            
//            [_productImgArr addObject:[representation filename]];
            [_productImgArr addObject:portraitImg];
            
            if(i == assets.count - 1)
            {
                [self refreshCollectionView];
            }
            
//            NSString * userImgPath = @"";
//            
//            BOOL isOk = [LoginUser uploadImageWithScale:portraitImg fileName:_currentFileName userImgPath:&userImgPath];
//            
//            if(isOk)
//            {
//                NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
//                [dic setObject:userImgPath forKey:@"url"];
//                
//                Accessory * acc = [Accessory new];
//                acc.address = userImgPath;
//                acc.name = _currentFileName;
//                
//                [self.cAccessoryArray addObject:acc];
//            }
//            
//            if(i == assets.count - 1)
//            {
//                if(isOk)
//                {
//                    [SVProgressHUD dismiss];
//                    
//                    [self refreshCollectionView];
//                }
//            }
        }
        
    }
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

#pragma mark -
#pragma mark UICollectionViewDataSource method

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    CYBuyerPDImageDescVC * vc = viewControllerInStoryBoard(@"CYBuyerPDImageDescVC", @"Buyer");
//    vc.currentIndex = indexPath.row;
//    
//    NSMutableArray * bannerArr = [NSMutableArray array];
//    for(int i = 0; i < _productImgArr.count; i ++)
//    {
//        CYHomeSlideInfo *info = [[CYHomeSlideInfo alloc] init];
////        info.thumb = _productImgArr[i];
//        [bannerArr addObject:info];
//    }
//    vc.bannerArr = bannerArr;
//    [self.navigationController pushViewController:vc animated:YES];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _productImgArr.count == ADD_IMG_COUNT ? ADD_IMG_COUNT: _productImgArr.count + 1 ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *merchIdentify = @"CYBuyerProductCollectionViewCell";

    CYBuyerProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:merchIdentify forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if (indexPath.row == _productImgArr.count)
    {
        cell.deleteBtn.hidden = YES;
        cell.imgView.image = [UIImage imageNamed:@"addImgBtn"];
    }
    else
    {
        cell.deleteBtn.hidden = NO;
        cell.imgView.image = _productImgArr[indexPath.row];
        
//        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:_productImgArr[indexPath.row]] placeholderImage:[UIImage imageNamed:@""]];

    }
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(cell) weakCell = cell;

    cell.deleteBtnBlock = ^()
    {
        [_productImgArr removeObjectAtIndex:indexPath.row];
        
        [weakSelf refreshCollectionView];
    };
    
    cell.addImageBtnBlock = ^()
    {
        if(weakCell.deleteBtn.hidden)
        {
            [self addImageClicked];
        }
        else
        {
            CYBuyerPDImageDescVC * vc = viewControllerInStoryBoard(@"CYBuyerPDImageDescVC", @"Buyer");
            vc.currentIndex = indexPath.row;
            
            NSMutableArray * bannerArr = [NSMutableArray array];
            for(int i = 0; i < _productImgArr.count; i ++)
            {
                CYHomeSlideInfo *info = [[CYHomeSlideInfo alloc] init];
                //        info.thumb = _productImgArr[i];
                [bannerArr addObject:info];
            }
            vc.bannerArr = bannerArr;
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    
    return cell;
}

#pragma mark -
#pragma mark 按钮点击事件 method
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
