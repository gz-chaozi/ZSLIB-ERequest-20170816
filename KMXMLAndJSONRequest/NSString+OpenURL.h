//
//  NSString+OpenURL.h
//  KMXMLAndJSONRequest
//
//  Created by chaozi on 15/12/29.
//  Copyright (c) 2015年 chaozi. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NSString (OpenURL)
/**
 *  打开浏览器
 */
- (void)openByBrowser;

/**
 *  打开邮件
 */
- (void)openByEmail;

/**
 *  拨打电话
 */
- (void)openByTelephone;

/**
 *  打开短信（Short Messaging Service）
 */
- (void)openBySMS;

@end