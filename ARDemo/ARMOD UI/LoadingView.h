//
//  UIView+LoadingView.h
//  ARDemo
//
//  Created by NSWell on 2020/11/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoadingView:UIView
+(LoadingView *)loadingViewInView:(UIView *)superView;
-(void)removeView;
@end

NS_ASSUME_NONNULL_END
