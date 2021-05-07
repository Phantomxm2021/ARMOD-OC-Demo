//
//  UIResponder+ARViewUI.m
//  ARDemo
//
//  Created by NSWell on 2020/10/26.
//

#import "ARViewUI.h"
#import "NSObject+ARMOD.h"
@implementation ARViewUI



- (void)createARViewButton:(ARMOD*) setARMOD{
    self.armod = setARMOD;
    if (@available(iOS 13.0, *)) {
        self.closeBtn = [UIButton buttonWithType:UIButtonTypeClose];
    } else {
        // Fallback on earlier versions
        self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [self.closeBtn addTarget:self action:@selector(closeARView:) forControlEvents:UIControlEventTouchUpInside];
    [self.closeBtn setFrame:CGRectMake(10, 30, 30, 30)];
//    [self addSubview:self.closeBtn];
    [[[self.armod getARMODController] view] addSubview:self.closeBtn];
}


-(void)closeARView:(UIButton*) sender{
//    NSLog(@"close pressed");
    [self.armod unloadAndHideARMODView];
}
@end
