//
//  TZCBOOkJSONRequestViewController.h
//  TZCXMLAndJSONRequest
//
//  Created by chaozi on 16/1/4.
//  Copyright (c) 2016年 chaozi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZCBOOkJSONRequestViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate>
@property (strong, nonatomic) NSMutableArray *mArrCell;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UILabel *lblEmptyDataMsg;
@property (strong, nonatomic) UIWebView *webView;

@property (strong, nonatomic) IBOutlet UIButton *btnSendRequest;
@end
