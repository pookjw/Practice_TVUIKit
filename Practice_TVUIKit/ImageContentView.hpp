//
//  ImageContentView.hpp
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/15/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

__attribute__((objc_direct_members))
@interface ImageContentConfiguration : NSObject <UIContentConfiguration>
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName NS_DESIGNATED_INITIALIZER;
@end

__attribute__((objc_direct_members))
@interface ImageContentView : UIView <UIContentView>
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame contentConfiguration:(ImageContentConfiguration *)contentConfiguration NS_DESIGNATED_INITIALIZER;
@end

NS_ASSUME_NONNULL_END
