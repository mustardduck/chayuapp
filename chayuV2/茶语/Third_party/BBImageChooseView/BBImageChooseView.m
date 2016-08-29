//
//  BBImageChooseView.m
//  FireCtrl
//
//  Created by box on 14-5-15.
//  Copyright (c) 2014年 Chongqing Blue Box Technology Co., Ltd. All rights reserved.
//

/*!实例代码
 
 imageChooseView = [BBImageChooseView imageChooseViewWithFrame:_imgchooseContentView.bounds andShowViewController:self];
 imageChooseView.imageSize = CGSizeMake(120., 120.);
 [imageChooseView setAddImageBtnImage:[UIImage imageNamed:@"action_addico.png"]];
 //    imageChooseView.delegateForMe = self;
 imageChooseView.gap = 5.;
 imageChooseView.maxWidthLimit = screenSize.width - 20;
 imageChooseView.imageCountLimit = 6;
 imageChooseView.removeMode = BBImageChooseViewRemoveModeLongpress;
 imageChooseView.onlyForShow = NO;
 imageChooseView.autoAdjustFrameToContentSize = YES;
 imageChooseView.sourceType = BBImageChooseViewSourceTypeAll;
 [_imgchooseContentView addSubview:imageChooseView];
 
 */

#import "BBImageChooseView.h"
//#import "UIImage+fixOrientation.h"
#import "UIImage+expanded.h"
#import "UIColor+RGBColor.h"
#import "JKImagePickerController.h"
#define IMAGE_CHOOSE_TAG_BAE 5470

@interface BBImageChooseView()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,JKImagePickerControllerDelegate>{
    BOOL waitRemove;//图片正在晃动，等待删除
    UIWindow *window;
//    NSMutableArray *imageOperationArr;
    NSMutableDictionary *bigImageUrlDic;//缩略图对应的大图url存放在这里

}

- (IBAction)onAddImage:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIButton *addImageBtn;
@property (retain,nonatomic)  UIViewController *contro;
@end

@implementation BBImageChooseView

@synthesize removeing = waitRemove;

- (void)dealloc
{
    [self removeAllImages];
    [_addImageBtn release];
    [_imageArr release];
    [_selectArr release];
    [bigImageUrlDic release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initSettingsWithFrame:frame];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initSettingsWithFrame:self.frame];
    }
    return self;
}

- (void)initSettingsWithFrame:(CGRect)frame
{
    self.addImageBtn = [[UIButton alloc]initWithFrame:CGRectZero];
//    self.addImageBtn.backgroundColor = [UIColor clearColor];
    [self.addImageBtn addTarget:self action:@selector(onAddImage:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addImageBtn];
    
    self.imageArr = [NSMutableArray array];
    self.selectArr =[NSMutableArray array];
    self.gap = 5.;
    self.frame = frame;
    self.imageSize = CGSizeMake(frame.size.height, frame.size.height);
    self.backgroundColor = [UIColor clearColor];
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.clipsToBounds = YES;
    
    waitRemove = NO;
    self.autoAdjustFrameToContentSize = YES;
    self.maxWidthLimit = FLT_MAX;
    self.tapToShowLargeImage = YES;
    window = [[[UIApplication sharedApplication]delegate]window];
//    imageOperationArr = [[NSMutableArray alloc]init];
    bigImageUrlDic = [[NSMutableDictionary alloc]init];
//    
//    UILongPressGestureRecognizer *lp = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(onPrepareForRemoveImage:)];
//    [self addGestureRecognizer:lp];
//    [lp release];
}

+ (BBImageChooseView *)imageChooseViewWithFrame:(CGRect)frame andShowViewController:(UIViewController *)controller
{
    BBImageChooseView *view = [[BBImageChooseView alloc]initWithFrame:frame];
    view.contro =controller;
    return view;
}

- (void)setImageSize:(CGSize)imageSize
{
    if (_imageArr.count) {
        return;
    }
    _imageSize = imageSize;
    
    CGFloat y = (self.frame.size.height - _imageSize.height)/2.;
    self.addImageBtn.frame = CGRectMake(0
                                        , y
                                        , _imageSize.width
                                        , _imageSize.height);
}

- (CAAnimation *)shakeAnimation
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    CGFloat angle = M_PI/96.;
    anim.keyTimes = @[@0,@0.25,@0.5,@0.75,@1];
    anim.values = @[@0
                    ,[NSNumber numberWithFloat:angle]
                    ,@0
                    ,[NSNumber numberWithFloat:-angle]
                    ,@0];
    anim.duration = 0.25;
    anim.repeatCount = 10000;
    
    return anim;
}



- (void)setHiddenAddImageButton:(BOOL)hiddenAddImageButton
{
    if (_onlyForShow && !hiddenAddImageButton) {
        return;
    }
    if (_hiddenAddImageButton == hiddenAddImageButton) {
        return;
    }
    
    _hiddenAddImageButton = hiddenAddImageButton;
    
    _addImageBtn.hidden = _hiddenAddImageButton;
    [self updateContentSizeAndFrame];
    
}

- (void)setOnlyForShow:(BOOL)onlyForShow
{
    if (onlyForShow == _onlyForShow) {
        return;
    }
    
    _onlyForShow = onlyForShow;
    
    if (_onlyForShow) {
        self.hiddenAddImageButton = YES;
    }
}

//开始选择图片
- (void)startChooseImage
{
    if (_imageCountLimit == _imageArr.count || _hiddenAddImageButton) {
        return;
    }
    [self onAddImage:_addImageBtn];
}

//根据图片数量计算自身的contentSize
- (CGSize)contentSizeFromImageCount:(NSInteger)aCount
{
    CGFloat x = (_imageSize.width+_gap) * aCount;
    CGSize contentSize = CGSizeMake(x+(_hiddenAddImageButton?0:_addImageBtn.frame.size.width)
                                  ,self.frame.size.height);
    return contentSize;
}

- (void)updateContentSizeAndFrame
{
    CGSize contentSize = [self contentSizeFromImageCount:_imageArr.count];
    self.contentSize = contentSize;
    
    if (_autoAdjustFrameToContentSize) {
        
        CGFloat w = contentSize.width;
        if (contentSize.width > _maxWidthLimit) {
            w = _maxWidthLimit;
        }
        CGRect frame = self.frame;
        frame.size.width = w;
        self.frame = frame;
        
        if (_widthConstraint) {
            _widthConstraint.constant = w;
        }
    }
}

//设置添加图片按钮的图片
- (void)setAddImageBtnImage:(UIImage *)aImage
{
    [_addImageBtn setImage:aImage forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark 添加图片
- (IBAction)onAddImage:(UIButton *)sender {
    //从相册选择图片
    if (waitRemove) {
        return;
    }
    [window endEditing:YES];
    
    if (_delegateForMe && [_delegateForMe respondsToSelector:@selector(imageChooseViewShouldBeginAddImage:)]) {
        BOOL shoulBegin = [_delegateForMe imageChooseViewShouldBeginAddImage:self];
        if (!shoulBegin) {
            return;
        }
    }
    
    if (_imageArr.count >= _imageCountLimit) {
        NSString *msg = [NSString stringWithFormat:@"最多允许上传%ld张图片",(long)_imageCountLimit];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好", nil];
        [alert show];
        [alert release];
        return;
    }
    
    if (_sourceType == BBImageChooseViewSourceTypeAll) {
        UIActionSheet *ac = [[UIActionSheet alloc]initWithTitle:@"选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍一张", nil];
        [ac showInView:window];
        [ac release];
        
    }else{
        
        if (_sourceType == BBImageChooseViewSourceTypePhotoAlbum) {
            [self showChooseImagePage];
        }else{
            [self showCameraPage];
        }
    }
    
}

- (UIImageView *)addImage:(UIImage *)image
{
    if (waitRemove) {
        [self cancelRemoveImage];
    }
    [_imageArr addObject:image];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:_addImageBtn.frame];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.image = image;
    imgView.tag = IMAGE_CHOOSE_TAG_BAE + _imageArr.count - 1;
    imgView.userInteractionEnabled = YES;
//    imgView.layer.cornerRadius = imgView.frame.size.width/2;
    imgView.clipsToBounds = YES;
    
    _addImageBtn.center = CGPointMake(_addImageBtn.center.x+_imageSize.width+_gap, _addImageBtn.center.y);
    
    //删除按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat btnSize = 15.;
    btn.frame = CGRectMake(0, imgView.frame.size.height-btnSize, imgView.frame.size.width, btnSize);
    btn.backgroundColor = [UIColor colorWithRed:0. green:0. blue:0. alpha:0.5f];
    [btn addTarget:self action:@selector(onRemoveImage:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"×" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17.];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    btn.tag = imgView.tag+100;
//    btn.hidden = YES;
    [imgView addSubview:btn];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapImage:)];
    singleTap.numberOfTapsRequired = 1;
    [imgView addGestureRecognizer:singleTap];
    [singleTap release];
    [self addSubview:imgView];
    [self updateContentSizeAndFrame];
    if (_imageCountLimit == _imageArr.count) {
        self.hiddenAddImageButton = YES;
    }
    
    if (!_hiddenAddImageButton) {
        [self scrollRectToVisible:_addImageBtn.frame animated:NO];
    }
    
    if (_delegateForMe && [_delegateForMe respondsToSelector:@selector(imageChooseView:didAddedImage:)]) {
        [_delegateForMe imageChooseView:self didAddedImage:image];
    }
    
    return [imgView autorelease];
}



- (void)addImageWithUrl:(NSURL *)url{

    
    [self addImageWithUrl:url placeholder:nil];
}

- (void)addImageWithUrl:(NSURL *)url placeholder:(UIImage *)placeholder{
    [self addImageWithSmallUrl:url addBigUrl:nil placeholder:placeholder];
}

- (void)addImageWithSmallUrl:(NSURL *)smallUrl addBigUrl:(NSURL *)bigUrl
{
    
    [self addImageWithSmallUrl:smallUrl addBigUrl:bigUrl placeholder:nil];
}

- (void)addImageWithSmallUrl:(NSURL *)smallUrl addBigUrl:(NSURL *)bigUrl placeholder:(UIImage *)placeholder
{
    if (!placeholder) {
        placeholder = [[[UIImage alloc]init] autorelease];
    }
    UIImageView *imgView = [self addImage:placeholder];
    imgView.backgroundColor = [UIColor getColorWithHexString:@"#f5f5f9"];
    NSString *key = [NSString stringWithFormat:@"%d",(int)imgView.tag%IMAGE_CHOOSE_TAG_BAE];
    if (bigUrl) {
        [bigImageUrlDic setObject:bigUrl forKey:key];
    }
    
    __unsafe_unretained BBImageChooseView *imgChoose = self;
    [imgView sd_setImageWithURL:smallUrl placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            [imgChoose imageView:imgView didSetWithImage:image];
        }
    }];
    
}

#pragma mark -
#pragma mark 从网络获取图片成功
- (void)imageView:(UIImageView *)imageView didSetWithImage:(UIImage *)image
{
    NSInteger index = imageView.tag - IMAGE_CHOOSE_TAG_BAE;
    if ([_imageArr count]>index) {
          [_imageArr replaceObjectAtIndex:index withObject:image];
    }
  
}

#pragma mark -
#pragma mark 删除图片
//删除所有图片（无动画）
- (void)removeAllImages
{
    for (UIImageView *imgView in self.subviews) {
        if ([imgView isKindOfClass:[UIImageView class]]) {
            [imgView sd_cancelCurrentImageLoad];
            [imgView removeFromSuperview];
        }
    }
    [bigImageUrlDic removeAllObjects];
    
    CGRect frame = _addImageBtn.frame;
    frame.origin.x = 0;
    _addImageBtn.frame = frame;
    
    self.hiddenAddImageButton = NO;
    [_imageArr removeAllObjects];
    [_selectArr removeAllObjects];
    [self updateContentSizeAndFrame];
    waitRemove = NO;
    
}


//删除指定位置的图片
- (void)removeImageAtIndex:(NSInteger)index
{
    if (index >= _imageArr.count) {
        return;
    }
    
    NSInteger imgTag = IMAGE_CHOOSE_TAG_BAE + index;
    UIView *imgView = [self viewWithTag:imgTag];
    UIButton *btn = (UIButton *)[imgView viewWithTag:imgTag+100];
    [self onRemoveImage:btn];
}

///取消删除
- (void)cancelRemoveImage
{
    if (waitRemove) {
        waitRemove = NO;
        for (UIImageView *imgView in self.subviews) {
            if (imgView.tag >= IMAGE_CHOOSE_TAG_BAE && [imgView isKindOfClass:[UIImageView class]]) {
                [imgView.layer removeAnimationForKey:@"shakeAnimation"];
            }
            UIView *btn = [imgView viewWithTag:imgView.tag+100];
            [UIView animateWithDuration:1.25f animations:^{
                btn.alpha = 0.;
            }completion:^(BOOL finished) {
                btn.hidden = YES;
                btn.alpha = 1.;
            }];
        }
    }
}



///长按准备删除图片
- (void)onPrepareForRemoveImage:(UILongPressGestureRecognizer *)sender
{
    if (BBImageChooseViewRemoveModeLongpress != _removeMode) {
        return;
    }
    
    if (waitRemove) {
        return;
    }
    waitRemove = YES;
    for (UIImageView *imgView in self.subviews) {
        if (imgView.tag >= IMAGE_CHOOSE_TAG_BAE && [imgView isKindOfClass:[UIImageView class]]) {
            [imgView.layer addAnimation:[self shakeAnimation] forKey:@"shakeAnimation"];
        }
        [imgView viewWithTag:imgView.tag+100].hidden = NO;
    }
}

///正式删除
- (void)onRemoveImage:(UIButton *)sender
{
    NSInteger imgTag = sender.tag-100;
    NSInteger index = imgTag%IMAGE_CHOOSE_TAG_BAE;
    if (_delegateForMe && [_delegateForMe respondsToSelector:@selector(imageChooseView:WillRemoveImageAtIndex:)]) {
        [_delegateForMe imageChooseView:self WillRemoveImageAtIndex:index];
    }
    
    //删除对应的大图URL
    NSString *key = [NSString stringWithFormat:@"%ld",(long)index];
    if ([bigImageUrlDic.allKeys containsObject:key]) {
        [bigImageUrlDic removeObjectForKey:key];
    }
    
    UIImageView *removeImgView = (UIImageView *)[self viewWithTag:imgTag];
    [UIView animateWithDuration:0.25 animations:^{
        
        removeImgView.frame = CGRectMake(removeImgView.center.x
                                         , removeImgView.center.y
                                         , 0
                                         , 0);
        sender.frame = CGRectMake(removeImgView.frame.size.width/2.
                                  , removeImgView.frame.size.height/2.
                                  , 0
                                  , 0);
        
    }completion:^(BOOL finished) {
        
        [removeImgView sd_cancelCurrentImageLoad];
        [removeImgView removeFromSuperview];
        
        [UIView animateWithDuration:0.25 animations:^{
            
            for (int i= (int)index + 1; i<_imageArr.count; i++) {
                UIImageView *imgView = (UIImageView *)[self viewWithTag:IMAGE_CHOOSE_TAG_BAE+i];
                imgView.center = CGPointMake(imgView.center.x-(_imageSize.width+_gap), imgView.center.y);
                [imgView viewWithTag:imgView.tag+100].tag--;//删除按钮
                imgView.tag--;
            }
            _addImageBtn.center = CGPointMake(_addImageBtn.center.x-(_imageSize.width+_gap), _addImageBtn.center.y);
        }completion:^(BOOL finished) {
            [_imageArr removeObjectAtIndex:index];
            [_selectArr removeObjectAtIndex:index];
            
            if (_imageArr.count < _imageCountLimit) {
                self.hiddenAddImageButton = NO;
            }
            
            [self updateContentSizeAndFrame];
            
            if (!_imageArr.count) {
                waitRemove = NO;
            }
            if (_delegateForMe && [_delegateForMe respondsToSelector:@selector(imageChooseView:didRemoveImageAtIndex:)]) {
                [_delegateForMe imageChooseView:self didRemoveImageAtIndex:index];
            }
        }];
        
    }];
}


- (void)onTapImage:(UITapGestureRecognizer *)sender
{
    if (waitRemove) {
        [self cancelRemoveImage];
        return;
    }
    
    NSInteger index = sender.view.tag-IMAGE_CHOOSE_TAG_BAE;
    if (_delegateForMe && [_delegateForMe respondsToSelector:@selector(imageChooseView:didTapImageAtIndex:)]) {
        [_delegateForMe imageChooseView:self didTapImageAtIndex:index];
    }
    
    
    if (_tapToShowLargeImage) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.userInteractionEnabled = YES;
        });
        
        
        [self showChooseImagePage];

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
    [_contro presentViewController:navigationController animated:YES completion:^{
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    }];
       imagePickerController = nil;
    [imagePickerController release];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

//显示拍照页面
- (void)showCameraPage
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
#ifdef BB_SAFE_RELEASE
        imagePicker = nil;
        [imagePicker release];
#endif
#ifdef UtilAlert
        UtilAlert(@"提示", @"设备不支持摄像头");
#endif
        return;
    }
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [imagePicker setDelegate:self];
    [imagePicker setAllowsEditing:NO];
    [_contro presentViewController:imagePicker
                                            animated:YES completion:^{
                                            [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
                                            }];
    [imagePicker release];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

//消失页面
- (void)dissmiss
{
    [_contro  dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark -
#pragma mark UIActionSheetDelegate method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (2 != buttonIndex) {
        if (0 == buttonIndex) {
            [self showChooseImagePage];
        }else{
            [self showCameraPage];
        }
    }else{
        
        if (_delegateForMe && [_delegateForMe respondsToSelector:@selector(imageChooseViewDidCancelChooseImage:)]) {
            [_delegateForMe imageChooseViewDidCancelChooseImage:self];
        }
    }
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
        img = [img fixOrientation];
        
        [self addImage:img];
        [self dissmiss];
    });
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_delegateForMe && [_delegateForMe respondsToSelector:@selector(imageChooseViewDidCancelChooseImage:)]) {
            [_delegateForMe imageChooseViewDidCancelChooseImage:self];
        }
        [self dissmiss];
    });
}


#pragma mark - JKImagePickerControllerDelegate
- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAsset:(JKAssets *)asset isSource:(BOOL)source
{
   
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAssets:(NSArray *)assets isSource:(BOOL)source
{
    
    __unsafe_unretained BBImageChooseView *imgChoose = self;
    NSMutableArray *selectImgArr = [NSMutableArray arrayWithArray:assets];
       [self removeAllImages];
        [_selectArr removeAllObjects];
        [_selectArr addObjectsFromArray:selectImgArr];
    
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
        for (int i = 0; i<[selectImgArr count]; i++) {
            JKAssets *assetImg = [assets objectAtIndex:i];
            ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
            [lib assetForURL:assetImg.assetPropertyURL resultBlock:^(ALAsset *asset) {
                if (asset) {
                    UIImage * img = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
                    [imgChoose addImage:img];
                }
            } failureBlock:^(NSError *error) {
                
            }];
            
        }
   
      [self dissmiss];
}

@end
