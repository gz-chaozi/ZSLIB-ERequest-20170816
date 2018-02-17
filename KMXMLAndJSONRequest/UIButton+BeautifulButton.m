//
//  UIButton+BeautifulButton.m
//  KMXMLAndJSONRequest
//
//  Created by chaozi on 15/12/29.
//  Copyright (c) 2015年 chaozi. All rights reserved.
//

#import "UIButton+BeautifulButton.h"

@implementation UIButton (BeautifulButton)

- (void)beautifulButton:(UIColor *)tintColor {
    self.tintColor = tintColor ?: [UIColor darkGrayColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10.0;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1.0;
}

@end
