//
//  NTAlbum.h
//  NivagationBar
//
//  Created by Chayu on 16/7/8.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CYTopWindow.h"

@protocol NTAlbumDelegate;

@interface NTAlbum : UIView


//一屏幕最多几个
@property (nonatomic,assign)CGFloat maxsection;

//!图片数量限制（默认1000张）,超过这个数量就会设置hiddenAddImageButton为YES
@property (nonatomic,assign)NSInteger imageCountLimit;


//!已选定的图片（UIImage）
@property (nonatomic,strong)NSMutableArray *imageArr;

@property (nonatomic,strong)NSMutableArray *selectArr;

//当图片数量变化时，需要更新页面
@property (nonatomic,copy)void(^imgcuntChangeBlock)(NSInteger);

@property (strong,nonatomic)  UIViewController *contro;

@property (assign,nonatomic) id<NTAlbumDelegate> delegate;

-(void)reloadImgData;

@end

@protocol NTAlbumDelegate <NSObject>

- (void)addImageClicked;

@end
