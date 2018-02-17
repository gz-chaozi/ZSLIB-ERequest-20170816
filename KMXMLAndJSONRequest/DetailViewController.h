//
//  DetailViewController.h
//  UICollectionView-Demo
//
//  Created by leadingwinner on 13-12-20.
//  Copyright (c) 2013年 leadingwinner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) UIImage *image;
- (IBAction)back:(id)sender;

@end
