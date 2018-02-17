//
//  ViewController.h
//  KMXMLAndJSONRequest
//
//  Created by chaozi on 15/12/29.
//  Copyright (c) 2015年 chaozi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController
@property (copy, nonatomic) NSArray *arrSampleName;
@property (copy, nonatomic) UIToolbar *toolBar;
- (instancetype)initWithSampleNameArray:(NSArray *)arrSampleName;
@end

