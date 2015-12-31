//
//  Photo.h
//  Witness
//
//  Created by Start on 12/28/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BaseEntity.h"

@interface Photo : BaseEntity

@property (strong,nonatomic)NSString*title;
@property (copy,nonatomic)NSString *addTime;
@property (copy,nonatomic)NSString *address;
@property (copy,nonatomic)NSString *attchStatus;
@property (copy,nonatomic)NSString *attchUrl;
@property (strong,nonatomic)NSString *calledNo;
@property (strong,nonatomic)NSString *duration;
@property (strong,nonatomic)NSString *fileNo;
@property (strong,nonatomic)NSString *fileSize;
@property (strong,nonatomic)NSString *id;

@property (strong,nonatomic)NSString *is_encrypt;
@property (strong,nonatomic)NSString *is_receive;
@property (strong,nonatomic)NSString *labelName;
@property (copy,nonatomic)NSString *level;

@property (strong,nonatomic)UIImage *thumbnail;

@end
