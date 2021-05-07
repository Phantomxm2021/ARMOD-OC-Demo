//
//  AppDelegate.h
//  ARDemo
//
//  Created by NSWell on 2020/10/23.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow * window;
@property (readonly, strong) NSPersistentContainer *persistentContainer;
- (void)saveContext;


@end

