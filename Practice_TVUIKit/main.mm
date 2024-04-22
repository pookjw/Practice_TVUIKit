//
//  main.mm
//  Practice_TVUIKit
//
//  Created by Jinwoo Kim on 4/14/24.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.hpp"
#import "NSObject+Foundation_IvarDescription.h"

int main(int argc, char * argv[]) {
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    
    /*
     setSystemInputViewControllerDelegate:
     */
    NSLog(@"%@", [NSObject _fd__protocolDescriptionForProtocol:NSProtocolFromString(@"UISystemInputViewControllerDelegate")]);
    
    int result = UIApplicationMain(argc, argv, nil, NSStringFromClass(AppDelegate.class));
    [pool release];
    return result;
}
