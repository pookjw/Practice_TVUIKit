//
//  CarouselViewController.mm
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/23/24.
//

#import "CarouselViewController.h"
#import <objc/message.h>
#import <objc/runtime.h>

__attribute__((objc_direct_members))
@interface CarouselViewController ()
@end

@implementation CarouselViewController

- (BOOL)respondsToSelector:(SEL)aSelector {
    BOOL result = [super respondsToSelector:aSelector];
    
    if (!result) {
        NSLog(@"%s", sel_getName(aSelector));
    }
    
    return result;
}

- (void)loadView {
    __kindof UIView *carouselView = [objc_lookUpClass("_TVCarouselView") new];
    ((void (*)(id, SEL, id))objc_msgSend)(carouselView, sel_registerName("setDelegate:"), self);
    ((void (*)(id, SEL, id))objc_msgSend)(carouselView, sel_registerName("setDataSource:"), self);
    
    self.view = carouselView;
    [carouselView release];
}

- (NSInteger)numberOfItemsInCarouselView:(__kindof UIView *)carouselView {
    return 30;
}

@end
