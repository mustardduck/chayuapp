//
//  CYBuyerAllLetterView.h
//  茶语
//
//  Created by Leen on 16/6/28.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYBuyerAllLetterViewDelegate;

@interface CYBuyerAllLetterView : UIView

@property (nonatomic,assign)id<CYBuyerAllLetterViewDelegate>delegate;


@end

@protocol CYBuyerAllLetterViewDelegate <NSObject>


-(void)selectLetter:(NSString *)letter;

@end