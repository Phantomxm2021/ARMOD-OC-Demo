//
//  main.m
//  ARDemo
//
//  Created by NSWell on 2020/10/26.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "NSObject+ARMOD.h"
int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    [[ARMOD sharedInstance] connectArgcArgv:argc setgArgv:argv];
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
