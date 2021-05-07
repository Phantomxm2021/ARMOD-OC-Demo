//
//  PopOver.m
//  ARDemo
//
//  Created by NSWell on 2021/1/6.
//

#import <Foundation/Foundation.h>
#import "PopOverView.h"
#import "ViewController.h"
#import "NSObject+ARMOD.h"
#import "AppDelegate.h"
#import "ARViewUI.h"
#import "ARViewExtension.h"

@interface PopOverView ()
@property(strong,nonatomic) ARMOD *armod ;
@property  ARViewUI *arViewUI;
@property (weak, nonatomic) IBOutlet UITextField *projectIdField;
@property UIDeviceOrientation orientationState;
@property (strong,nonatomic) NSString *projectId;
@end


@implementation PopOverView

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)arScaner:(UIButton *)sender {
    NSString *appConfigFilePath = [[NSBundle mainBundle] pathForResource:@"AppConfig" ofType:@"plist"];
    NSDictionary *appConfigDict = [NSDictionary dictionaryWithContentsOfFile:appConfigFilePath];
    
    //ARSDK is a singleton
    self.armod = ARMOD.sharedInstance;
    
    //SDK event register,e.g. download asset event,Not Support event and so on.
    [self.armod registerAPIforNativeCalls:[ARViewExtension alloc]];
    
    //Configure AR SDK. We need to convert the dictionary to NSString and then pass it to our SDK.
    [self.armod initARMOD:[self convertToJsonData:appConfigDict]];
    
    //Set the ar view to follow the orientation of the app itself
    [self.armod setUIInterfaceOrientation:(int)self.orientationState];
    
    //Init show the AR view
    [self.armod loadAndShowARMODView];
    
    //Fetch data
    [self.armod fetchProjectByImage];

    self.arViewUI = [[ARViewUI alloc] init];
    [self.arViewUI createARViewButton:self.armod];

}


/// Convert dict to json string
/// @param dict dict
/// @return Json string
- (NSString *)convertToJsonData:(NSDictionary *)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    
    if (!jsonData) {
        NSLog(@"%@",error);
    } else {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }

    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
}


@end

