//
//  Utils.m
//  CheckoutProObjCWithoutFrameworkSampleApp
//
//  Created by Umang Arya on 09/07/20.
//  Copyright © 2020 PayU Payments Pvt Ltd. All rights reserved.
//

#import "Utils.h"
#include <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation Utils

+ (NSString *) getHash:(NSString *)input
{
        const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
        NSData *data = [NSData dataWithBytes:cstr length:input.length];
        uint8_t digest[CC_SHA512_DIGEST_LENGTH];

        // This is an iOS5-specific method.
        // It takes in the data, how much data, and then output format, which in this case is an int array.
        CC_SHA512(data.bytes, (int)data.length, digest);

        NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];

        //Parse through the CC_SHA256 results (stored inside of digest[]).
        for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
            [output appendFormat:@"%02x", digest[i]];
        }
        return output;
}


+ (NSString *) getTransactionID {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyMMddHHmmss";
    NSString *txnID = [NSString stringWithFormat:@"iOS%@",[formatter stringFromDate:[NSDate date]]];
    return  txnID;
}

+ (void)presentAlertOn:(UIViewController *)controller title:(NSString *)title message:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
        [alertController addAction:actionOk];
        
        [controller presentViewController:alertController animated:YES completion:nil];
    });
}


@end
