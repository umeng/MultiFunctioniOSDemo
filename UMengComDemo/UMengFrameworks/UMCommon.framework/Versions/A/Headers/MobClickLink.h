//
//  MobClickLink.h
//
//  Created by umeng on 27/3/20.
//


#import <Foundation/Foundation.h>

@protocol MobClickLinkDelegate<NSObject>

@optional

- (void)getLinkPath:(NSString *)path params:(NSDictionary *)params;

@end

@interface MobClickLink : NSObject

+ (BOOL)handleUniversalLink:(NSUserActivity *)userActivity delegate:(id<MobClickLinkDelegate>)delegate;

+ (BOOL)handleLinkURL:(NSURL *)URL delegate:(id<MobClickLinkDelegate>)delegate;

+ (void)getInstallParams:(void (^)(NSDictionary *params, NSURL *URL, NSError *error))completion;

@end

