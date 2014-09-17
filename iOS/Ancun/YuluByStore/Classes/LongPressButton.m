#import "LongPressButton.h"

@interface TargetObject : NSObject {
    id __object;
	SEL __action;
}

-(id)initWithTarget:(id)target actiion:(SEL)action;
-(void)execTarget;

@end

@implementation TargetObject

- (id)initWithTarget:(id)target actiion:(SEL)action {
    if ((self=[super init])) {
        __object=target;
        __action=action;
    }
    return self;
}

- (void)execTarget {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [__object performSelector:__action];
#pragma clang diagnostic pop
}

@end

@interface LongPressButton ()

@property(nonatomic)UIButton *button;
@property(nonatomic)NSMutableDictionary  *targetDictonary;

@end

@implementation LongPressButton

- (void) dealloc {
    NSLog(@"LongButton dealloc");
}

@synthesize button=__button;
@synthesize targetDictonary=__targetDictonary;
@synthesize minimumPressDuration;

- (void)commonInit {
    self.targetDictonary=[NSMutableDictionary dictionaryWithCapacity:3];
    minimumPressDuration=0.5f;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        self.button=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.button addTarget:self action:@selector(buttonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
        [self.button addTarget:self action:@selector(buttonTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
        [self.button addTarget:self action:@selector(buttonTouchDown) forControlEvents:UIControlEventTouchDown];
        [self.button setFrame:self.bounds];
        [self addSubview:self.button];
    }
    return self;
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(LongPressEvents)controlEvents {
    TargetObject *targetObject=[[TargetObject alloc] initWithTarget:target actiion:action];
    switch (controlEvents) {
        case ControlEventTouchCancel:
            [self.targetDictonary setObject:targetObject forKey:@"ControlEventTouchCancel"];
            break;
        default:
            [self.targetDictonary setObject:targetObject forKey:@"ControlEventTouchLongPress"];
            break;
    }
}

- (void)buttonTouchDown {
	[self performSelector:@selector(lazyButtontouchDown) withObject:nil afterDelay:self.minimumPressDuration];
}

-(void)lazyButtontouchDown {
    TargetObject *targetObject=[self.targetDictonary objectForKey:@"ControlEventTouchLongPress"];
    if (targetObject) {
        [targetObject execTarget];
    }
}

- (void)buttonTouchUpInside {
	[NSObject cancelPreviousPerformRequestsWithTarget:self
											 selector:@selector(lazyButtontouchDown)
											   object:nil];
    TargetObject *targetObject=[self.targetDictonary objectForKey:@"ControlEventTouchCancel"];
    if (targetObject) {
        [targetObject execTarget];
    }
}

- (void)buttonTouchUpOutside {
	[NSObject cancelPreviousPerformRequestsWithTarget:self
											 selector:@selector(lazyButtontouchDown)
											   object:nil];
    TargetObject *targetObject=[self.targetDictonary objectForKey:@"ControlEventTouchCancel"];
    if (targetObject) {
        [targetObject execTarget];
    }
}

#pragma mark 设置图片，和背景图片。
- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [self.button setImage:image forState:state];
}

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state {
    [self.button setBackgroundImage:image forState:state];
}

#pragma mark 设置标题，颜色，阴影
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [self.button setTitle:title forState:state];
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state {
    [self.button setTitleColor:color forState:state];
}

- (void)setTitleShadowColor:(UIColor *)color forState:(UIControlState)state {
    [self.button setTitleShadowColor:color forState:state];
}

@end
