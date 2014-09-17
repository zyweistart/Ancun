#import "IAPHelper.h"

@implementation IAPHelper {
    HttpRequest *_http;
}

static IAPHelper * _sharedHelper;

+ (IAPHelper *)sharedHelper {
    if (_sharedHelper == nil) {
        _sharedHelper = [[IAPHelper alloc] init];
    }
    return _sharedHelper;
}

- (SKProduct *)product:(NSString *)identifier {
    for(SKProduct *product in self.products) {
        if( [identifier isEqualToString:product.productIdentifier]) {
            return product;
        }
    }
    return nil;
}

#pragma mark 产品购买
- (void)buyProductIdentifier:(SKProduct *)product {
    if([SKPaymentQueue canMakePayments]) {
//        NSLog(@"Buying %@...", product.productIdentifier);
        SKPayment* payment=[SKPayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    } else {
        [Common alert:@"应用程序内购买被禁用"];
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions){
        switch (transaction.transactionState){
            case SKPaymentTransactionStatePurchased:
//                NSLog(@"completeTransaction...");
                [self completeTransaction:transaction productIdentifier:transaction.payment.productIdentifier];
                [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
                break;
            case SKPaymentTransactionStateFailed:
//                if (transaction.error.code != SKErrorPaymentCancelled){
//                    NSLog(@"Transaction error: %@", transaction.error.localizedDescription);
//                }
                [[NSNotificationCenter defaultCenter] postNotificationName:kProductPurchaseFailedNotification object:transaction];
                [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
                break;
            case SKPaymentTransactionStateRestored:
//                NSLog(@"restoreTransaction...");
                [self completeTransaction:transaction productIdentifier:transaction.originalTransaction.payment.productIdentifier];
                [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
            default:
                break;
        }
    }
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction productIdentifier:(NSString *)productIdentifier {
    [[NSNotificationCenter defaultCenter] postNotificationName:kProductPurchasedNotification object:transaction];
}


- (void)dealloc {
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

@end
