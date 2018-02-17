//
//  XMLRequestViewController.h
//  KMXMLAndJSONRequest
//
//  Created by chaozi on 15/12/29.
//  Copyright (c) 2015年 chaozi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMLRequestViewController : UIViewController <NSXMLParserDelegate>
@property (strong, nonatomic) UITextView *txtVResult;

@property (strong, nonatomic) IBOutlet UIButton *btnSendRequest;
@property (strong, nonatomic) UIToolbar *toolBar;
@end
