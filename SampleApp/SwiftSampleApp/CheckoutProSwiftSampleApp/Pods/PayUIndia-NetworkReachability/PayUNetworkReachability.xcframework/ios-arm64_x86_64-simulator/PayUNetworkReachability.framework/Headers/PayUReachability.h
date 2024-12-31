/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Basic demonstration of how to use the SystemConfiguration Reachablity APIs.
 */

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

typedef enum : NSInteger {
    PayUNotReachable = 0,
    PayUReachableViaWiFi,
    PayUReachableViaWWAN
} PayUNetworkStatus;

extern NSString *kPayUReachabilityChangedNotification;


@interface PayUReachability : NSObject

/*!
 * Checks whether the default route is available. Should be used by applications that do not connect to a particular host.
 */
+ (instancetype)reachabilityForInternetConnection;

/*!
 * Start listening for reachability notifications on the current run loop.
 */
- (BOOL)startNotifier;
- (void)stopNotifier;

- (PayUNetworkStatus)currentReachabilityStatus;

- (BOOL)currentNetworkStatus;

@end
