//
//  UICommon.h
//  茶语
//
//  Created by Leen on 16/6/22.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "CSBImagePickerController.h"
#import "CYActionSheet.h"
#import "CYShareModel.h"
#import "SDWebImageManager.h"


@interface UICommon : NSObject

+ (void) showAlbum:(id)delegate view:(UIViewController*)controller;

+ (void) showTakePhoto:(id)delegate view:(UIViewController*) controller allowsEditing:(BOOL)allow;

+ (BOOL)isBlankString:(NSString *)string;

+ (void) showAlbumMore:(id)delegate view:(UIViewController *)controller number:(NSInteger)count;

+ (void) startTime:(id)sender;

+ (UIImage *)stretchImage:(UIImage *)image;

+ (void)shareGoods:(CYShareModel *)shareModel;

+ (void) navBarClicked:(UINavigationController *)nav tag:(NSInteger) tag shareModel:(CYShareModel *)shareModel;

/**
 *  设置uilabel行间距和label内容
 */
+ (void)setLabelPadding:(UILabel *)label text:(NSString *)text padding:(CGFloat)lineSpacing;

/**
 *  圆角带边框
 *
 *  @param cornerRadius <#cornerRadius description#>
 *  @param borderColor  <#borderColor description#>
 */
+ (void)setViewCornerRadius:(UIView *)view cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor;

+ (CGFloat)lableHeightWithString:(NSString *)string Size:(CGSize )size fontSize:(CGFloat)fontSize;

+ (void)downloadWithURL:(NSURL *)url;

+ (void)seeFullScreenImage:(UINavigationController *)nav imageUrlArr:(NSArray *)imgArr currentPage:(NSInteger)index;

@end
