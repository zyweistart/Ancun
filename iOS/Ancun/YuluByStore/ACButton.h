//
//  ACButton.h
//  Ancun
//
//  Created by Start on 4/29/15.
//
//

#import <UIKit/UIKit.h>

#define BUTTONNORMALCOLOR [UIColor colorWithRed:(57/255.0) green:(115/255.0) blue:(221/255.0) alpha:1]
#define BUTTONPRESENDCOLOR [UIColor colorWithRed:(100/255.0) green:(165/255.0) blue:(225/255.0) alpha:1]

#define BUTTON2ORMALCOLOR [UIColor colorWithRed:(77/255.0) green:(205/255.0) blue:(112/255.0) alpha:1]
#define BUTTON2PRESENDCOLOR [UIColor colorWithRed:(172/255.0) green:(221/255.0) blue:(185/255.0) alpha:1]

@interface ACButton : UIButton

- (id)initWithFrame:(CGRect)rect Name:(NSString*)name;
- (id)initWithFrame:(CGRect)rect Name:(NSString*)name Type:(int)type;

@end
