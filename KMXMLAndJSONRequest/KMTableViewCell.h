//
//  KMTableViewCel.h
//  KMXMLAndJSONRequest
//
//  Created by chaozi on 15/12/29.
//  Copyright (c) 2015年 chaozi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KMTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgVAvatarImage;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblAuthor;
@property (strong, nonatomic) IBOutlet UILabel *lblCreatedAt;
@property (strong, nonatomic) IBOutlet UIImageView *imgVLink;

@property (strong, nonatomic) UILabel *lblText;
@property (copy, nonatomic) NSString *avatarImageStr;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *author;
@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) NSString *createdAt;
@property (assign, nonatomic, getter=isHaveLink) BOOL haveLink;

@end
