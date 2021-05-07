//
//  NativeCallsProtocol+ARViewExtension.m
//  ARDemo
//
//  Created by NSWell on 2020/10/29.
//

#import "ARViewExtension.h"
#import "NSObject+ARMOD.h"
#import "LoadingView.h"


@interface ARViewExtension()
@property LoadingView *loadingview;
@end
@implementation ARViewExtension

- (void)addLoadingOverlay {
    NSLog(@"Start Loading view");
    UIView *armod_view = [[[ARMOD sharedInstance] getARMODController] view];
    self.loadingview = [LoadingView loadingViewInView:armod_view];
    
}

- (void)alertConfirmationView:(NSString *)title addMessage:(NSString *)message addCallBack:(NSString *)callback {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
        
        [[ARMOD sharedInstance] unloadAndHideARMODView];
    }];
    
    [alert addAction:okAction];
    [[[ARMOD sharedInstance] getARMODController] presentViewController:alert animated:YES completion:nil];
}

- (void)deviceNotSupport {
    NSLog(@"Your device is not support");
//    [self alertConfirmationView:@"Error" addMessage:@"Your device is not support!" addCallBack:@""];
}

- (void)removeLoadingOverlay {
    NSLog(@"Finished");
    [self.loadingview removeView];
}

- (void)updateLoadingProgress:(float)progress {
    NSLog(@"Download asset: %f",progress);
}

- (void)sdkInitialized {
    NSLog(@"AR Algorithm Initialized");
}

- (void)recognitionStart {
    NSLog(@"RecognitionStart");
}

- (void)recognitionComplete {
    NSLog(@"RecognitionComplete");
}

- (void)throwException:(NSString *)message errorCode:(int)code {
    NSLog(@"ERROR:%d,%@",code,message);
    [self removeLoadingOverlay];
    if(code==1000){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Notice"
                                                                       message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action){
            
            [[ARMOD sharedInstance] fetchProjectByImage];
        }];
        
        [alert addAction:okAction];
        [[[ARMOD sharedInstance] getARMODController] presentViewController:alert animated:YES completion:nil];
        return;
    }
    [self alertConfirmationView:@"Notice" addMessage:message addCallBack:nil];
}

- (void)openBuiltInBrowser:(NSString *)url{
    [[ARMOD sharedInstance] unloadAndHideARMODView];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}




- (NSString *)tryAcquireInformation:(NSString *)opTag {
    return @"";
}

- (void)packageSizeMoreThanPresetSize:(float)currentSize preset:(float)presetSize {
    
}





@end
