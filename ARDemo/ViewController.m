//
//  ViewController.m
//  ARDemo
//
//  Created by NSWell on 2020/10/23.
//

#import "ViewController.h"
#import "NSObject+ARMOD.h"
#import "AppDelegate.h"
#import "ARViewUI.h"
#import "ARViewExtension.h"

@interface ViewController ()
@property(strong,nonatomic) ARMOD *armod ;
@property  ARViewUI *arViewUI;
@property (weak, nonatomic) IBOutlet UITextField *projectIdField;
@property UIDeviceOrientation orientationState;
@property (strong,nonatomic) NSString *projectId;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.projectIdField.delegate = self;
    //Must be init at here
    self.orientationState =[[UIDevice currentDevice] orientation];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqual:@"popoverSegue"]) {
        [[segue destinationViewController] setModalPresentationStyle:UIModalPresentationPopover];
        [[[segue destinationViewController] popoverPresentationController] setDelegate:self];
    }
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

#pragma mark - TextField Delegates

// This method is called once we click inside the textField
-(void)textFieldDidBeginEditing:(UITextField *)textField {
//   NSLog(@"Text field did begin editing");
}

// This method is called once we complete editing
-(void)textFieldDidEndEditing:(UITextField *)textField {
//   NSLog(@"Text field ended editing");
    self.projectId = textField.text;
}

// This method enables or disables the processing of return key
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
   [textField resignFirstResponder];
   return YES;
}




/// Launch AR button event
/// @param sender button
- (IBAction)ButtonEvent:(UIButton *)sender {
//    NSLog(@"Hi,You are tapping the AR-Luancher button!");
    
    //load the application config file (property list) for AR SDK
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
    [self.armod fetchProject:self.projectId];

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
