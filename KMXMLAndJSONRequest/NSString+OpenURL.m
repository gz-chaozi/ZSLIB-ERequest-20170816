//
//  NSString+OpenURL.m
//  KMXMLAndJSONRequest
//
//  Created by chaozi on 15/12/29.
//  Copyright (c) 2015年 chaozi. All rights reserved.
//

#import "NSString+OpenURL.h"

@implementation NSString (OpenURL)

+ (void)open:(NSString *)openURLStr {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openURLStr]];
}

- (void)openByBrowser {
    [NSString open:self];
}

- (void)openByEmail {
    [NSString open:[NSString stringWithFormat:@"mailto://%@", self]];
}

- (void)openByTelephone {
    [NSString open:[NSString stringWithFormat:@"tel://%@", self]];
}

- (void)openBySMS {
    [NSString open:[NSString stringWithFormat:@"sms://%@", self]];
}

@end
