#import <Foundation/Foundation.h>

#ifdef __cplusplus
#    define PayU_CrashReporter_EXTERN extern "C" __attribute__((visibility("default")))
#else
#    define PayU_CrashReporter_EXTERN extern __attribute__((visibility("default")))
#endif

#if TARGET_OS_IOS || TARGET_OS_TV
#    define PayU_CrashReporter_HAS_UIDEVICE 1
#else
#    define PayU_CrashReporter_HAS_UIDEVICE 0
#endif

#if PayU_CrashReporter_HAS_UIDEVICE
#    define PayU_CrashReporter_HAS_UIKIT 1
#else
#    define PayU_CrashReporter_HAS_UIKIT 0
#endif

#define PAYU_CrashReporter_NO_INIT                                                                             \
    -(instancetype)init NS_UNAVAILABLE;                                                            \
    +(instancetype) new NS_UNAVAILABLE;

@class PayUCREvent, PayUCRBreadcrumb;

/**
 * Block used for returning after a request finished
 */
typedef void (^PayUCRRequestFinished)(NSError *_Nullable error);

/**
 * Block used for request operation finished, shouldDiscardEvent is YES if event
 * should be deleted regardless if an error ocured or not
 */
typedef void (^PayUCRRequestOperationFinished)(
    NSHTTPURLResponse *_Nullable response, NSError *_Nullable error);
/**
 * Block can be used to mutate a breadcrumb before it's added to the scope.
 * To avoid adding the breadcrumb altogether, return nil instead.
 */
typedef PayUCRBreadcrumb *_Nullable (^PayUCRBeforeBreadcrumbCallback)(
    PayUCRBreadcrumb *_Nonnull breadcrumb);

/**
 * Block can be used to mutate event before its send.
 * To avoid sending the event altogether, return nil instead.
 */
typedef PayUCREvent *_Nullable (^PayCrashReporterBeforeSendEventCallback)(PayUCREvent *_Nonnull event);

/**
 * A callback to be notified when the last program execution terminated with a crash.
 */
typedef void (^PayCrashReporterOnCrashedLastRunCallback)(PayUCREvent *_Nonnull event);

/**
 * Block can be used to determine if an event should be queued and stored
 * locally. It will be tried to send again after next successful send. Note that
 * this will only be called once the event is created and send manully. Once it
 * has been queued once it will be discarded if it fails again.
 */
typedef BOOL (^PayCrashReporterShouldQueueEvent)(
    NSHTTPURLResponse *_Nullable response, NSError *_Nullable error);

/**
 * CrashReporter level
 */
typedef NS_ENUM(NSUInteger, PayUCRLevel) {
    // Defaults to None which doesn't get serialized
    kPayUCRLevelNone = 0,
    // Goes from Debug to Fatal so possible to: (level > Info) { .. }
    kPayUCRLevelDebug = 1,
    kPayUCRLevelInfo = 2,
    kPayUCRLevelWarning = 3,
    kPayUCRLevelError = 4,
    kPayUCRLevelFatal = 5,
};

/**
 * Static internal helper to convert enum to string
 */
static NSString *_Nonnull const PayUCRLevelNames[] = {
    @"none",
    @"debug",
    @"info",
    @"warning",
    @"error",
    @"fatal",
};

static NSUInteger const defaultMaxBreadcrumbs = 100;
