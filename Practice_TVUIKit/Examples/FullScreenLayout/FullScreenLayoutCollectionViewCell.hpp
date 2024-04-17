//
//  FullScreenLayoutCollectionViewCell.hpp
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/16/24.
//

#import <UIKit/UIKit.h>
#import <TVUIKit/TVUIKit.h>

NS_ASSUME_NONNULL_BEGIN

__attribute__((objc_direct_members))
@interface FullScreenLayoutCollectionViewCell : TVCollectionViewFullScreenCell
@property (retain, readonly, nonatomic) UIImageView *imageView;
@property (retain, readonly, nonatomic) UILabel *label;
@end

NS_ASSUME_NONNULL_END
