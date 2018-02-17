//
//  KMTableViewCel.m
//  KMXMLAndJSONRequest
//
//  Created by chaozi on 15/12/29.
//  Copyright (c) 2015年 chaozi. All rights reserved.
//

#import "KMTableViewCell.h"

#import "UIImageView+WebCache.h"

static UIImage *placeholderImage;
static CGFloat widthOfLabel;
@implementation KMTableViewCell

- (void)awakeFromNib {
    // Initialization code
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        placeholderImage = [UIImage imageNamed:@"JSON"];
        widthOfLabel = [[UIScreen mainScreen] bounds].size.width - 100.0;
    });
    
    _imgVAvatarImage.layer.masksToBounds = YES;
   // _imgVAvatarImage.layer.cornerRadius = 10.0;
    
    _imgVAvatarImage.layer.shadowColor=[UIColor blackColor].CGColor;
    _imgVAvatarImage.layer.shadowOffset=CGSizeMake(4,4);
    _imgVAvatarImage.layer.shadowOpacity=0.5;
    _imgVAvatarImage.layer.shadowRadius=10.0;
   
    
    //由于 xib 中对标签自适应宽度找不到合适的方式来控制，所以这里用代码编写；这里屏幕复用的 Cell 有几个，就会执行几次 awakeFromNib 方法
    _lblText = [[UILabel alloc] initWithFrame:CGRectMake(110.0, 38.0, widthOfLabel-20.0, 52.0)];
    _lblText.numberOfLines = 5;
    _lblText.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:_lblText];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setAvatarImageStr:(NSString *)avatarImageStr {
    if (![_avatarImageStr isEqualToString:avatarImageStr]) {
        _avatarImageStr = [avatarImageStr copy];
        NSURL *avatarImageURL = [NSURL URLWithString:_avatarImageStr];
        //NSData *avatarImageData = [NSData dataWithContentsOfURL:avatarImageURL];
        //_imgVAvatarImage.image = [UIImage imageWithData:avatarImageData];
        
        //图片缓存；性能优化的第一步
        //方法一：AFNetworking 框架：UIImageView+AFNetworking
        //        [_imgVAvatarImage setImageWithURL:avatarImageURL
        //                         placeholderImage:placeholderImage];
        
        //方法二：SDWebImage 框架：UIImageView+WebCache
        [_imgVAvatarImage sd_setImageWithURL:avatarImageURL
                            placeholderImage:placeholderImage];
    }
}

- (void)setName:(NSString *)name {
    _name = [name copy];
    _lblName.text = _name;
}
- (void)setAuthor:(NSString *)author {  //该死，为什么setAuthor中的a要大写？？？？？？
    _author = [author copy];
    _lblAuthor.text = _author;
}
- (void)setText:(NSString *)text {
    _text = [text copy];
    _lblText.text = _text;
}

- (void)setCreatedAt:(NSString *)createdAt {
    _createdAt = [createdAt copy];
    _lblCreatedAt.text = _createdAt;
}

- (void)setHaveLink:(BOOL)haveLink {
    _haveLink = haveLink;
    _imgVLink.hidden = !_haveLink;
}

@end