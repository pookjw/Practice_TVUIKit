//
//  main.mm
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/14/24.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.hpp"

int main(int argc, char * argv[]) {
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    int result = UIApplicationMain(argc, argv, nil, NSStringFromClass(AppDelegate.class));
    [pool release];
    return result;
}
