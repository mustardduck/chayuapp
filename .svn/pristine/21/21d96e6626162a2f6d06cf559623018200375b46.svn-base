//
//  BBImageChooseView.h
//  FireCtrl
//
//  Created by box on 14-5-15.
//  Copyright (c) 2014年 Chongqing Blue Box Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBImageChooseViewDelegate;

//!图片来源
typedef NS_ENUM(NSInteger, BBImageChooseViewSourceType){
    BBImageChooseViewSourceTypeAll = 0,//来自以下所有（通过Actionsheet选择）
    BBImageChooseViewSourceTypeCamera,//来自摄像头拍照
    BBImageChooseViewSourceTypePhotoAlbum//来自相册
};

//!删除方式
typedef NS_ENUM(NSInteger, BBImageChooseViewRemoveMode){
    BBImageChooseViewRemoveWhenShowLargeImage = 0,//显示大图时删除
    BBImageChooseViewRemoveModeLongpress,//长按删除
    BBImageChooseViewRemoveModeNone//不能删除
};


@interface BBImageChooseView : UIScrollView

//!已选定的图片（UIImage）
@property (nonatomic,retain)NSMutableArray *imageArr;

@property (nonatomic,retain)NSMutableArray *selectArr;

//!两个图片间距  不传为默认值5.(仅在未添加图片之前设置有效)
@property (nonatomic,assign)CGFloat gap;

//!图片的大小，宽度高度都默认为BBImageChooseView的高度(仅在未添加图片之前设置有效)
@property (nonatomic,assign)CGSize imageSize;

//!图片来源
@property (nonatomic,assign)BBImageChooseViewSourceType sourceType;

//!删除方式
@property (nonatomic,assign)BBImageChooseViewRemoveMode removeMode;

//!点击看大图 默认YES
@property (nonatomic,assign)BOOL tapToShowLargeImage;

//设置添加图片按钮的图片
- (void)setAddImageBtnImage:(UIImage *)aImage;

//!图片数量限制（默认1000张）,超过这个数量就会设置hiddenAddImageButton为YES
@property (nonatomic,assign)NSInteger imageCountLimit;

//!隐藏添加图片按钮
@property (nonatomic,assign)BOOL hiddenAddImageButton;

//!仅用于展示，不能添加图片，为YES时对hiddenAddImageButton赋值无效，hiddenAddImageButton恒为YES
@property (nonatomic,assign)BOOL onlyForShow;

//正在删除，BBImageChooseViewRemoveModeLongpress模式下此属性才可能为YES
@property (nonatomic,assign,readonly)BOOL removeing;


//自动调整自身的frame为contentSize大小，默认YES
@property (nonatomic,assign)BOOL autoAdjustFrameToContentSize;

//宽度约束
@property (nonatomic,retain)IBOutlet NSLayoutConstraint *widthConstraint;

//最大宽度限制（自动调整自身的frame为contentSize时，如果contentSize.width大于maxWidthLimit就不会调整frame），默认为FLT_MAX，相当于无限制
@property (nonatomic,assign)CGFloat maxWidthLimit;



@property (nonatomic,assign)IBOutlet id<BBImageChooseViewDelegate> delegateForMe;

+ (BBImageChooseView *)imageChooseViewWithFrame:(CGRect)frame andShowViewController:(UIViewController *)controller;

//!开始选择图片
- (void)startChooseImage;

//!添加图片
- (UIImageView *)addImage:(UIImage *)image;
- (void)addImageWithUrl:(NSURL *)url;
- (void)addImageWithUrl:(NSURL *)url placeholder:(UIImage *)placeholder;
//- (void)addImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder onSize:(CGSize)size;
//以下两个方法用于添加带缩略图的图片，缩略图显示在imageChooseView上，大图在点击缩略图时显示在BBLargeImageView上（大图存放在bigImageUrlDic中）
- (void)addImageWithSmallUrl:(NSURL *)smallUrl addBigUrl:(NSURL *)bigUrl;
- (void)addImageWithSmallUrl:(NSURL *)smallUrl addBigUrl:(NSURL *)bigUrl placeholder:(UIImage *)placeholder;

//！根据图片数量计算自身的contentSize
- (CGSize)contentSizeFromImageCount:(NSInteger)aCount;

//!删除指定位置的图片
- (void)removeImageAtIndex:(NSInteger)index;
//!删除所有图片（无动画）
- (void)removeAllImages;

//更新自身大小
- (void)updateContentSizeAndFrame;

@end


@protocol BBImageChooseViewDelegate<NSObject>

@optional

//!是否可以开始选择图片
- (BOOL)imageChooseViewShouldBeginAddImage:(BBImageChooseView *)aImageChooseView;

//!点击了某个图片
- (void)imageChooseView:(BBImageChooseView *)aImageChooseView didTapImageAtIndex:(NSInteger)aIndex;

//!将要显示大图
//- (void)imageChooseView:(BBImageChooseView *)aImageChooseView WillShowLargeImageView:(BBLargeImageView *)aLargeImageView;

//!添加了图片
- (void)imageChooseView:(BBImageChooseView *)aImageChooseView didAddedImage:(UIImage *)aImage;

//!取消选择图片
- (void)imageChooseViewDidCancelChooseImage:(BBImageChooseView *)aImageChooseView;

//!将要删除图片
- (void)imageChooseView:(BBImageChooseView *)aImageChooseView WillRemoveImageAtIndex:(NSInteger)aIndex;

//!删除了图片
- (void)imageChooseView:(BBImageChooseView *)aImageChooseView didRemoveImageAtIndex:(NSInteger)aIndex;

@end
