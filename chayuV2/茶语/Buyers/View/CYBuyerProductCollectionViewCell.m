//
//  CYBuyerProductCollectionViewCell.m
//  茶语
//
//  Created by Leen on 16/6/24.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import "CYBuyerProductCollectionViewCell.h"

@implementation CYBuyerProductCollectionViewCell

- (IBAction)deleteClicked:(id)sender {
    if(self.deleteBtnBlock)
    {
        self.deleteBtnBlock();
    }
}

- (IBAction)addImageClicked:(id)sender {
    if(self.addImageBtnBlock)
    {
        self.addImageBtnBlock();
    }
}

@end
