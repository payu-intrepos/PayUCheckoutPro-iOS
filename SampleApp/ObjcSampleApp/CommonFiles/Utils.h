//
//  Utils.h
//  CheckoutProObjCWithoutFrameworkSampleApp
//
//  Created by Umang Arya on 09/07/20.
//  Copyright © 2020 PayU Payments Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utils : NSObject

+ (NSString *) getTransactionID;

+ (NSString *) getHash:(NSString *)input;

@end

NS_ASSUME_NONNULL_END
