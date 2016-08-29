//
//  NTAlbum.m
//  NivagationBar
//
//  Created by Chayu on 16/7/8.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "NTAlbum.h"
#import "JKImagePickerController.h"
#import "NTAlbumCollectionViewCell.h"

#define SCREEN_W ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_H ([UIScreen mainScreen].bounds.size.height)
#define APPLEWINDOW  [[UIApplication sharedApplication].delegate window]
#define MAXIMGCOUNT 9

@interface NTAlbum ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIActionSheetDelegate,JKImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSMutableArray *selectimgArr;
    NSMutableArray *photoImgArr;//从相机拍摄;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong)UIImagePickerController *imagePicker;

@end

@implementation NTAlbum

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [super awakeFromNib];
    _selectArr = [[NSMutableArray alloc] init];
    _imageArr = [[NSMutableArray alloc] init];
    selectimgArr = [[NSMutableArray alloc] init];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"NTAlbumCollectionViewCell" bundle:nil ]forCellWithReuseIdentifier:@"NTAlbumCollectionViewCell"];
  
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
    }
    
    return self;
}



#pragma mark - UICollect config
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if ([selectimgArr count]<_imageCountLimit)
    {
        return [selectimgArr count]+1;
    }else{
        return [selectimgArr count];
    }

}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake((SCREEN_W-40)/4-6*2,(SCREEN_W-40)/4-6*2);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    NTAlbumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NTAlbumCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell =[[[NSBundle mainBundle] loadNibNamed:@"NTAlbumCollectionViewCell" owner:nil options:nil] firstObject];
    }
    if ([selectimgArr count]>0 && indexPath.row !=[selectimgArr count]) {
        cell.deleteBtn.hidden = NO;
    }else{
        cell.deleteBtn.hidden = YES;
    }
    
    
    if (indexPath.row<[selectimgArr count]) {
        cell.imgview.image = selectimgArr[indexPath.row];
        cell.selectimgBtn.hidden = YES;
    }else{
        cell.selectimgBtn.hidden = NO;
        cell.imgview.image = nil;
    }
//  
//    if (indexPath.row<[selectImgArr count] || [selectImgArr count] == _imageCountLimit) {
//        cell.selectimgBtn.hidden = YES;
//    }else{
//        cell.selectimgBtn.hidden = NO;
//    }
    
    cell.selectimgBtn.tag = 1300+indexPath.row;
    [cell.selectimgBtn addTarget:self action:@selector(addImageClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteBtn.tag = 9400 +indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteItem:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


-(void)addImageClicked:(UIButton *)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(addImageClicked)])
    {
        [self.delegate addImageClicked];
    }
    [WINDOW endEditing:YES];

    UIActionSheet *ac = [[UIActionSheet alloc]initWithTitle:@"选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    [ac showInView:APPLEWINDOW];
}


-(void)deleteItem:(UIButton *)sender
{
    NSInteger selectIndex = sender.tag-9400;
    [selectimgArr removeObjectAtIndex:selectIndex];
    [_selectArr removeObjectAtIndex:selectIndex];
    _imageArr = selectimgArr;
//    [_collectionView deselectItemAtIndexPath:[NSIndexPath indexPathWithIndex:selectIndex] animated:YES];
    [_collectionView reloadData];
    if (self.imgcuntChangeBlock) {
        self.imgcuntChangeBlock([_selectArr count]);
    }
}

#pragma mark -
#pragma mark UIActionSheetDelegate method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (2 != buttonIndex) {
        if (0 == buttonIndex) {
            [self showChooseImagePage];
        }else{
//            [self showCameraPage];
        }
    }
}

#pragma mark -
#pragma mark 弹起、消失选图页面
//显示选择图片页面
- (void)showChooseImagePage
{
    
    JKImagePickerController *imagePickerController = [[JKImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.filterType = JKImagePickerControllerFilterTypePhotos;
    imagePickerController.showsCancelButton = YES;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.minimumNumberOfSelection = 0;
    imagePickerController.maximumNumberOfSelection = _imageCountLimit;
    imagePickerController.selectedAssetArray = _selectArr;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
      BXTabBarController *tabVC = (BXTabBarController *)APP_DELEGATE.window.rootViewController;
    [tabVC presentViewController:navigationController animated:YES completion:^{
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    }];
    
//    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

//显示拍照页面
- (void)showCameraPage
{
    _imagePicker = [[UIImagePickerController alloc]init];
    if (iOS8) {
         _imagePicker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
  
    [_imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [_imagePicker setDelegate:(id)self];
    [_imagePicker setAllowsEditing:YES];
    _imagePicker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    BXTabBarController *tabVC = (BXTabBarController *)APP_DELEGATE.window.rootViewController;
    [tabVC presentViewController:_imagePicker animated:YES completion:nil];
}



#pragma mark -
#pragma mark UIActionSheetDelegate method


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *img = [info objectForKey:UIImagePickerControllerMediaMetadata];
        UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        [self addimg:img];
        [self dissmiss];
    });
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(!error){
        NSLog(@"save success");
    }else{
        NSLog(@"save failed");
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
//        if (_delegateForMe && [_delegateForMe respondsToSelector:@selector(imageChooseViewDidCancelChooseImage:)]) {
//            [_delegateForMe imageChooseViewDidCancelChooseImage:self];
//        }
        [self dissmiss];
    });
}


//消失页面
- (void)dissmiss
{
    BXTabBarController *tabVC = (BXTabBarController *)APP_DELEGATE.window.rootViewController;
    [tabVC  dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - JKImagePickerControllerDelegate
- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAsset:(JKAssets *)asset isSource:(BOOL)source
{
    
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)jkimagePickerControllerDidCancel:(JKImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAssets:(NSArray *)assets isSource:(BOOL)source
{

    
    if (selectimgArr) {
        [selectimgArr removeAllObjects];
    }
    NSMutableArray *selectimg = [NSMutableArray array];
    [selectimg addObjectsFromArray:assets];
    [_selectArr removeAllObjects];
    [_selectArr addObjectsFromArray:selectimg];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    for (int i = 0; i<[assets count]; i++) {
        JKAssets *assetImg = [assets objectAtIndex:i];
        ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
        [lib assetForURL:assetImg.assetPropertyURL resultBlock:^(ALAsset *asset) {
            if (asset) {
                UIImage * img = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
                [self addimg:img];
            }
        } failureBlock:^(NSError *error) {
            
        }];
        
    }
    
    [self dissmiss];
}


-(void)reloadImgData
{
    selectimgArr = [NSMutableArray arrayWithArray:_selectArr];
    _imageArr = [NSMutableArray arrayWithArray:_selectArr];
    [_collectionView reloadData];
}

-(void)addimg:(UIImage *)img
{
    [selectimgArr addObject:img];
    if ([selectimgArr count] == [_selectArr count]) {
        
        _imageArr = selectimgArr;
        if (self.imgcuntChangeBlock) {
            self.imgcuntChangeBlock([selectimgArr count]);
    
        }
        [_collectionView reloadData];
    }
}


@end
