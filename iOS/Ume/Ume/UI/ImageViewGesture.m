#import "ImageViewGesture.h"
#import "SJAvatarBrowser.h"

@implementation ImageViewGesture

- (id)initWithFrame:(CGRect)rect {
    self=[super initWithFrame:rect];
    if(self){
        [self setUserInteractionEnabled:YES];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]                          initWithTarget:self action:@selector(zoomImage:)]];
    }
    return self;
}

- (void)zoomImage:(UITapGestureRecognizer*)sender
{
    UIImageView *imageV=(UIImageView*)[sender view];
    [SJAvatarBrowser showImage:imageV];
}

@end