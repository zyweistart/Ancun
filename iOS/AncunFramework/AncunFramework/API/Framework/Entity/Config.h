//
//  Config.h
//  Witness
//
//  Created by Start on 12/1/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject

@property (assign,nonatomic) BOOL firstOpenApp;
@property (assign,nonatomic) BOOL configUploadFile2G3GAuto;
@property (assign,nonatomic) BOOL configUploadFileWiFiAuto;

+ (Config *) getInstance;

@end
