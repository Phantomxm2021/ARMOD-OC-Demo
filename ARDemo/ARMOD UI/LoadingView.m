//
//  UIView+LoadingView.m
//  ARDemo
//
//  Created by NSWell on 2020/11/5.
//

#import "LoadingView.h"

@implementation LoadingView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - Class methods

+(LoadingView *)loadingViewInView:(UIView *)superView
{
  // Create a new view with the same frame size as the superView
    LoadingView * loadingView = [[LoadingView alloc] initWithFrame:superView.bounds];
    
    // If something's gone wrong, abort!
    if(!loadingView)
        return nil;
    
    loadingView.opaque = NO;
    
    // Create background view and add as subview
    UIView * background = [[UIView alloc] initWithFrame:loadingView.frame];
    loadingView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
    [loadingView addSubview:background];
    
    // Add activity indicator
    UIActivityIndicatorView * indicator = [[UIActivityIndicatorView alloc]
                                           initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
    
    // Set the resizing mask so it's not stretched
    indicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin |
                                 UIViewAutoresizingFlexibleRightMargin |
                                 UIViewAutoresizingFlexibleBottomMargin |
                                 UIViewAutoresizingFlexibleLeftMargin;
    
    // Place it in the middle of the view
    indicator.center = superView.center;
    
    // Add it into the loadingView
    [loadingView addSubview:indicator];
    
    // Start it animating
    [indicator startAnimating];

    // Add the loading view to the superView.
    [superView addSubview:loadingView];
    
    // Create a new fade animation & add to superview
    CATransition * animation = [CATransition animation];
    [animation setType:kCATransitionFade];
    [[superView layer] addAnimation:animation forKey:@"layerAnimation"];
    
    return loadingView;
}

#pragma mark

-(void)removeView
{
    CATransition * animation = [CATransition animation];
    [animation setType:kCATransitionFade];
    [[[self superview] layer] addAnimation:animation forKey:@"layerAnimation"];
    
    [super removeFromSuperview];
}

@end
