//
//  CollectionCell.m
//  UICollectionView-Demo
//
//  Created by leadingwinner on 13-12-20.
//  Copyright (c) 2013年 leadingwinner. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray * nibs=[[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:self options:nil];
        for (id obj in nibs) {
            if ([obj isKindOfClass:[CollectionCell class]]) {
                self =(CollectionCell *)obj;
            }
        }
        
//        // 初始化时加载collectionCell.xib文件
//        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:self options: nil];
//       
//        // 如果路径不存在，return nil
//        if(arrayOfViews.count < 1){return nil;}
// 
//        // 如果xib中view不属于UICollectionViewCell类，return nil
//        if(![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]){
//         
//            return nil;
//        }
//       
//        // 加载nib
//        self = [arrayOfViews objectAtIndex:0];

    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
