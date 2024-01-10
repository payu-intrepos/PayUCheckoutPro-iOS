#import <Foundation/Foundation.h>

#import "PayUCRDefines.h"
#import "PayUCRSerializable.h"

NS_ASSUME_NONNULL_BEGIN

@interface PayUCRBreadcrumb : NSObject <PayUCRSerializable>

/**
 * Level of breadcrumb
 */
@property (nonatomic) PayUCRLevel level;

/**
 * Category of bookmark, can be any string
 */
@property (nonatomic, copy) NSString *category;

/**
 * NSDate when the breadcrumb happened
 */
@property (nonatomic, strong) NSDate *_Nullable timestamp;

/**
 * Type of breadcrumb, can be e.g.: http, empty, user, navigation
 * This will be used as icon of the breadcrumb
 */
@property (nonatomic, copy) NSString *_Nullable type;

/**
 * Message for the breadcrumb
 */
@property (nonatomic, copy) NSString *_Nullable message;

/**
 * Arbitrary additional data that will be sent with the breadcrumb
 */
@property (nonatomic, strong) NSDictionary<NSString *, id> *_Nullable data;

/**
 * Initializer for PayUCRBreadcrumb
 *
 * @param level PayUCRLevel
 * @param category String
 * @return PayUCRBreadcrumb
 */
- (instancetype)initWithLevel:(PayUCRLevel)level category:(NSString *)category;
- (instancetype)init;
+ (instancetype)new NS_UNAVAILABLE;

- (NSDictionary<NSString *, id> *)serialize;

- (BOOL)isEqual:(id _Nullable)other;

- (BOOL)isEqualToBreadcrumb:(PayUCRBreadcrumb *)breadcrumb;

- (NSUInteger)hash;

@end

NS_ASSUME_NONNULL_END
