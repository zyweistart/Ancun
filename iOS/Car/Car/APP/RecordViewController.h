//
//  RecordViewController.h
//  Car
//
//  Created by Start on 10/13/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BaseViewController.h"

@interface RecordViewController : BaseViewController

@property (nonatomic) BOOL isRecording;
@property (strong,nonatomic) NSString *recordedFileName;
@property (strong,nonatomic) NSString *recordedFilePath;

@end
