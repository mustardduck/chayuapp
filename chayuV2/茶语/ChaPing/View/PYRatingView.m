//
//  PYRatingView.m
//  Frameworks
//
//  Created by 李 峥 on 14/11/28.
//  Copyright (c) 2014年 李 峥. All rights reserved.
//

#import "PYRatingView.h"

//两颗星星间的间距
#define kImageSpace 5

@interface PYRatingView ()
{
    id<PYRatingViewDelegate> mDelegate;
    UIImage *mUnselectedImg, *mPartlySelectedImg, *mFullySelectedImg;
    CGFloat mStarRating, mLastRating;
    CGFloat mHeight, mWidth; // of each image of the star!
}

@property (nonatomic, strong) UIImageView *mS1;
@property (nonatomic, strong) UIImageView *mS2;
@property (nonatomic, strong) UIImageView *mS3;
@property (nonatomic, strong) UIImageView *mS4;
@property (nonatomic, strong) UIImageView *mS5;

@end

@implementation PYRatingView

- (void)setImagesDeselected:(NSString *)unselectedImage partlySelected:(NSString *)partlySelectedImage fullSelected:(NSString *)fullSelectedImage andDelegate:(id<PYRatingViewDelegate>)delegate
{
    mUnselectedImg = [UIImage imageNamed:unselectedImage];
    mPartlySelectedImg = [UIImage imageNamed:partlySelectedImage];
    mFullySelectedImg = [UIImage imageNamed:fullSelectedImage];
    mDelegate = delegate;
    
    mHeight = 0.f;
    mWidth  = 0.f;
    
    if (mHeight < [mUnselectedImg size].height) {
        mHeight = [mUnselectedImg size].height;
    }
    
    if (mWidth < [mUnselectedImg size].width) {
        mWidth = [mUnselectedImg size].width;
    }
    
    if (_iSpacing > 0) {
        mWidth += _iSpacing;
    }else
    {
        mWidth += kImageSpace;
    }
    
    mStarRating = 0.f;
    mLastRating = 0.f;
    
    _mS1 = [[UIImageView alloc] initWithImage:mUnselectedImg];
    _mS2 = [[UIImageView alloc] initWithImage:mUnselectedImg];
    _mS3 = [[UIImageView alloc] initWithImage:mUnselectedImg];
    _mS4 = [[UIImageView alloc] initWithImage:mUnselectedImg];
    _mS5 = [[UIImageView alloc] initWithImage:mUnselectedImg];
    
    _mS1.contentMode = UIViewContentModeLeft;
    _mS2.contentMode = UIViewContentModeLeft;
    _mS3.contentMode = UIViewContentModeLeft;
    _mS4.contentMode = UIViewContentModeLeft;
    _mS5.contentMode = UIViewContentModeLeft;
    
    [_mS1 setFrame:CGRectMake(0,         (self.frame.size.height - mHeight)/2, mWidth, mHeight)];
    [_mS2 setFrame:CGRectMake(mWidth,     (self.frame.size.height - mHeight)/2, mWidth, mHeight)];
    [_mS3 setFrame:CGRectMake(2 * mWidth, (self.frame.size.height - mHeight)/2, mWidth, mHeight)];
    [_mS4 setFrame:CGRectMake(3 * mWidth, (self.frame.size.height - mHeight)/2, mWidth, mHeight)];
    [_mS5 setFrame:CGRectMake(4 * mWidth, (self.frame.size.height - mHeight)/2, mWidth, mHeight)];
    
    [_mS1 setUserInteractionEnabled:NO];
    [_mS2 setUserInteractionEnabled:NO];
    [_mS3 setUserInteractionEnabled:NO];
    [_mS4 setUserInteractionEnabled:NO];
    [_mS5 setUserInteractionEnabled:NO];
    
    [self addSubview:_mS1];
    [self addSubview:_mS2];
    [self addSubview:_mS3];
    [self addSubview:_mS4];
    [self addSubview:_mS5];
    
    CGRect frame = [self frame];
    frame.size.width = mWidth * 5;
    [self setFrame:frame];
    
    self.backgroundColor = [UIColor clearColor];
}

-(void)displayRating:(CGFloat)rating {
    [_mS1 setImage:mUnselectedImg];
    [_mS2 setImage:mUnselectedImg];
    [_mS3 setImage:mUnselectedImg];
    [_mS4 setImage:mUnselectedImg];
    [_mS5 setImage:mUnselectedImg];
    
    if (rating >= 0.5) {
        [_mS1 setImage:mPartlySelectedImg];
    }
    if (rating >= 1) {
        [_mS1 setImage:mFullySelectedImg];
    }
    if (rating >= 1.5) {
        [_mS2 setImage:mPartlySelectedImg];
    }
    if (rating >= 2) {
        [_mS2 setImage:mFullySelectedImg];
    }
    if (rating >= 2.5) {
        [_mS3 setImage:mPartlySelectedImg];
    }
    if (rating >= 3) {
        [_mS3 setImage:mFullySelectedImg];
    }
    if (rating >= 3.5) {
        [_mS4 setImage:mPartlySelectedImg];
    }
    if (rating >= 4) {
        [_mS4 setImage:mFullySelectedImg];
    }
    if (rating >= 4.5) {
        [_mS5 setImage:mPartlySelectedImg];
    }
    if (rating >= 5) {
        [_mS5 setImage:mFullySelectedImg];
    }
    
    mStarRating = rating;
    mLastRating = rating;
    [mDelegate ratingChanged:rating andPYRatingView:self];
}

-(void) touchesBegan: (NSSet *)touches withEvent: (UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}

-(void) touchesMoved: (NSSet *)touches withEvent: (UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self];
    int newRating = (int) (pt.x / mWidth) + 1;
    if (newRating < 1 || newRating > 5)
        return;
    
    if (newRating != mLastRating)
        [self displayRating:newRating];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self touchesMoved:touches withEvent:event];
}

-(CGFloat)rating {
    return mStarRating;
}


@end
