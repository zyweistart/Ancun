//
//  MainViewController.h
//  Car
//
//  Created by Start on 10/13/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BaseViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MainViewController : BaseViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (strong,nonatomic) MPMoviePlayerController *moviePlayer;

@end