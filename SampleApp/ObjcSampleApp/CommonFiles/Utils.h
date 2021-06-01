//
//  Utils.h
//  CheckoutProObjCWithoutFrameworkSampleApp
//
//  Created by Umang Arya on 09/07/20.
//  Copyright © 2020 PayU Payments Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utils : NSObject

+ (NSString *) getTransactionID;

+ (void)presentAlertOn:(UIViewController *)controller title:(NSString *)title message:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
