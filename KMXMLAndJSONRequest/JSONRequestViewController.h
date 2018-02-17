//
//  JSONRequestViewController.h
//  KMXMLAndJSONRequest
//
//  Created by chaozi on 15/12/29.
//  Copyright (c) 2015年 chaozi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSONRequestViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate>
@property (strong, nonatomic) NSMutableArray *mArrCell;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UILabel *lblEmptyDataMsg;
@property (strong, nonatomic) UIWebView *webView;

@property (strong, nonatomic) IBOutlet UIButton *btnSendRequest;
@end
