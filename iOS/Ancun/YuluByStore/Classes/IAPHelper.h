#import <Foundation/Foundation.h>
#import "StoreKit/StoreKit.h"

#define kProductPurchasedNotification      @"ProductPurchased"
#define kProductPurchaseFailedNotification  @"ProductPurchaseFailed"

@interface IAPHelper:NSObject<SKPaymentTransactionObserver>

@property (strong,nonatomic) NSArray* products;
@property (strong,nonatomic) NSMutableArray* productlist;

+ (IAPHelper *)sharedHelper;

- (SKProduct *)product:(NSString *)identifier;
- (void)buyProductIdentifier:(SKProduct*)product;

@end