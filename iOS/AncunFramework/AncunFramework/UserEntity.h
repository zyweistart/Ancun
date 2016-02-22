//
//  UserEntity.h
//  AncunFramework
//
//  Created by Start on 12/31/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BaseEntity.h"

@interface UserEntity : BaseEntity

@property (strong,nonatomic)NSString *userName;
@property (strong,nonatomic)NSString *age;

@property (strong,nonatomic)UserEntity *user;


@end
