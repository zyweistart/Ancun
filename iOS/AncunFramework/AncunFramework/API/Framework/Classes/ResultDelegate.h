@protocol ResultDelegate <NSObject>

@required
- (void)onControllerResult:(NSInteger)resultCode requestCode:(NSInteger)requestCode data:(id)resultData;

@end