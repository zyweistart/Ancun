//
//  Periodical.h
//  Magazine
//
//  Created by Start on 6/16/14.
//  Copyright (c) 2014 Ancun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Periodical : NSManagedObject

@property (nonatomic, retain) NSString * bigTitle;
@property (nonatomic, retain) NSString * bookId;
@property (nonatomic, retain) NSString * contenturl;
@property (nonatomic, retain) NSString * downloadUrl;
@property (nonatomic, retain) NSString * periods;
@property (nonatomic, retain) NSString * smallTitle;

@end
