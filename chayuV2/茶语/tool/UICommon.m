//
//  UICommon.m
//  茶语
//
//  Created by Leen on 16/6/22.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "UICommon.h"
#import <ZYQAssetPickerController.h>
#import "CYShareModel.h"
#import "CYMyViewController.h"
#import "CYSouSuoHomeViewController.h"
#import "PreviewViewController.h"

@implementation UICommon

+ (void) showAlbum:(id)delegate view:(UIViewController*)controller
{
//    UIImagePickerController *picker = [CSBImagePickerController controllerFrom:delegate csbStyle:UIStatusBarStyleLightContent];
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    [controller presentViewController:picker animated:YES completion:nil];
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = delegate;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    imagePicker.allowsEditing = YES;
    
    [controller presentViewController:imagePicker animated:YES completion:nil];

}

+ (void)shareGoods:(CYShareModel *)shareModel
{
    
    if(shareModel.shareDesc.length + shareModel.shareUrl.length >= 140)
    {
        NSString * desc = [shareModel.shareDesc substringToIndex:(139 - shareModel.shareUrl.length)];
        
        shareModel.shareDesc = desc;
    }
    
    UIImage *img = [UIImage imageNamed:@"AppIcon60x60@2x.png"];
    UIImageView *imgView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    NSMutableString *imgUrl = [NSMutableString stringWithString:shareModel.shareImg];
    
    if ([imgUrl hasSuffix:@"800800"]) {
        imgUrl = [NSMutableString stringWithString:[imgUrl substringToIndex:imgUrl.length -6]];
        [imgUrl appendString:@"160160"];
    }
    [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:img completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.at = kAuthorizeTypeOpenShare;
        OSMessage *message = [[OSMessage alloc] init];
        message.title = shareModel.shareTitle;
        if (!shareModel.shareDesc) {
            message.desc = @"m.chayu.com";
        }else{
            message.desc = shareModel.shareDesc;
        }
        message.link = shareModel.shareUrl;
        
        
        if (!error) {
            message.image = UIImageJPEGRepresentation(image, 0.1);
            NSData *data  =UIImageJPEGRepresentation(image, 0.1);
            if (data.length/1024>32) {
                message.image = UIImageJPEGRepresentation(img, 0.1);
            }
            
        }else{
            message.image = UIImageJPEGRepresentation(img, 0.1);;
        }
        CYActionSheet *sheet = [[CYActionSheet alloc] initWithTitles:nil iconNames:nil];
        sheet.shareMessage = message;
        [sheet showActionSheetWithClickBlock:^(int btnIndex) {
            
        } cancelBlock:^{
            
        }];
    }];
    
    
}

+ (CGFloat)lableHeightWithString:(NSString *)string Size:(CGSize )size fontSize:(CGFloat)fontSize
{
    NSDictionary *attribute = @{NSFontAttributeName: FONT(fontSize)};
    CGSize lableSize = [string boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return lableSize.height;
}

+ (void)setLabelPadding:(UILabel *)label text:(NSString *)text padding:(CGFloat)lineSpacing
{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    label.attributedText = [[NSAttributedString alloc] initWithString: text
                                                               attributes:@{NSFontAttributeName:
                                                                                label.font,
                                                                            NSParagraphStyleAttributeName:paragraphStyle}];
}

+ (void)setViewCornerRadius:(UIView *)view cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor
{
    view.layer.borderWidth = 0.5f;
    view.layer.borderColor = borderColor.CGColor;
    view.layer.cornerRadius = cornerRadius;

}

+ (void)seeFullScreenImage:(UINavigationController *)nav imageUrlArr:(NSArray *)imgArr currentPage:(NSInteger)index
{
    UIViewController* vc = viewControllerInStoryBoard(@"PreviewViewController", @"Main");
    ((PreviewViewController*)vc).dataArray = imgArr;

    ((PreviewViewController*)vc).currentPage = index;
    
    [nav presentViewController:vc animated:YES completion:nil];
}

+ (void) navBarClicked:(UINavigationController *)nav tag:(NSInteger) tag shareModel:(CYShareModel *)shareModel
{
    if(tag == 2)//分享
    {
        if(shareModel.shareTitle)
        {
            [UICommon shareGoods:shareModel];
        }
    }
    else if (tag == 3)//搜索
    {
        CYSouSuoHomeViewController *vc = viewControllerInStoryBoard(@"CYSouSuoHomeViewController", @"SouSuo");
        [nav pushViewController:vc animated:YES];
    }
    else if (tag == 4)//个人中心
    {
        if (!MANAGER.isLoged) {
            [APP_DELEGATE showLogView];
            return;
        }
        CYMyViewController *vc = viewControllerInStoryBoard(@"CYMyViewController", @"My");
        [nav pushViewController:vc animated:YES];
    }
}

+ (void) showTakePhoto:(id)delegate view:(UIViewController*) controller allowsEditing:(BOOL)allow
{
    
//    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
//    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
//        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        
//    }
//    UIImagePickerController *picker = [CSBImagePickerController controllerFrom:delegate csbStyle:UIStatusBarStyleLightContent];
//    picker.allowsEditing = allow;
//    picker.sourceType = sourceType;
//    
//    [controller presentViewController:picker animated:YES completion:nil];
    

    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = delegate;
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    imagePicker.sourceType = sourceType;
    
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    imagePicker.allowsEditing = YES;
    [imagePicker topViewController].view.frame = CGRectMake(0, 0, 320, 300);
    [controller presentViewController:imagePicker animated:YES completion:nil];
}

+ (void) showAlbumMore:(id)delegate view:(UIViewController *)controller number:(NSInteger)count
{
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = count;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups=NO;
    picker.delegate = delegate;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 5;
        } else {
            return YES;
        }
    }];
    
    [controller presentViewController:picker animated:YES completion:NULL];
}


+ (BOOL)isBlankString:(NSString *)string{
    
    if (string == nil) {
        return YES;
    }
    
    if (string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (void) startTime:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
                btn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [btn setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                btn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

+ (UIImage *)stretchImage:(UIImage *)image
{
    UIEdgeInsets insets = UIEdgeInsetsMake(20, 15, 10, 10);
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    return image;
}

+ (void)downloadWithURL:(NSURL *)url
{
    // cmp不能为空
    [[SDWebImageManager sharedManager] downloadImageWithURL:url options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
    }];
}

@end
