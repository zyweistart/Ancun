//
//  RecordDetailViewController.m
//  Car
//
//  Created by Start on 11/12/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "RecordDetailViewController.h"

@implementation RecordDetailViewController

- (id)initWithData:(NSDictionary*)data
{
    self.cData=data;
    self=[super init];
    if(self){
        [self setTitle:@"录音笔"];
    }
    return self;
}

@end
