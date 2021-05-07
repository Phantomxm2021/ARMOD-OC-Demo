//
//  UIResponder+ARViewUI.h
//  ARDemo
//
//  Created by NSWell on 2020/10/26.
//

#import <UIKit/UIKit.h>
#import "NSObject+ARMOD.h"
NS_ASSUME_NONNULL_BEGIN

@interface ARViewUI:NSObject
@property(strong,nonatomic) UIButton *closeBtn;
@property ARMOD *armod;
- (void)createARViewButton:(ARMOD*) setARMOD;
@end

NS_ASSUME_NONNULL_END
