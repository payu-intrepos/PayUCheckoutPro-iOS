#import <Foundation/Foundation.h>

#import "PayUCRDefines.h"
@class PayUCRHub, PayUCRBreadcrumb, PayUCRId;

NS_ASSUME_NONNULL_BEGIN

/**
 "static api" for easy access to most common CrashReporter sdk features

 try `PayUCRHub` for advanced features
 */
@interface PayUCrashReporterSDK : NSObject
PAYU_CrashReporter_NO_INIT

/**
 * Returns current hub
 */
+ (PayUCRHub *)currentHub;




/**
 * Inits and configures CrashReporter (PayUCRHub, PayUCRClient) and sets up all integrations. Make sure to
 * set a valid DSN otherwise.
 */

+ (void)startWithExecutableName:(NSString *)name NS_SWIFT_NAME(start(executableName:));

+ (void)startWithExecutableName:(NSString *)name  withDsn:(NSString *)dsn NS_SWIFT_NAME(start(executableName:dsn:));




@end

NS_ASSUME_NONNULL_END
