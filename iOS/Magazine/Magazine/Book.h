//
//  Book.h
//  Magazine
//
//  Created by Start on 6/16/14.
//  Copyright (c) 2014 Ancun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * bookAuthor;
@property (nonatomic, retain) NSString * bookId;
@property (nonatomic, retain) NSString * bookType;
@property (nonatomic, retain) NSString * collect;
@property (nonatomic, retain) NSString * descriptions;
@property (nonatomic, retain) NSString * endPageUrl;
@property (nonatomic, retain) NSString * frontPageUrl;
@property (nonatomic, retain) NSString * index;
@property (nonatomic, retain) NSString * introduction;
@property (nonatomic, retain) NSString * periods;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * readpotin;
@property (nonatomic, retain) NSString * recommmend;
@property (nonatomic, retain) NSString * totalPage;
@property (nonatomic, retain) NSDate * readtime;

@end
