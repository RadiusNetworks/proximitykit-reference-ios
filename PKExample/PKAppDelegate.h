//  Copyright (c) 2013 RadiusNetworks. All rights reserved.

#import <UIKit/UIKit.h>

//
// Import Proximity Kit Headers from the framwork
//
#import <ProximityKit/ProximityKit.h>

//
// Add the Proximity Kit delegate interface
//
@interface PKAppDelegate : UIResponder <UIApplicationDelegate, PKManagerDelegate>

@property (strong, nonatomic) UIWindow *window;


//
// Create a property for the proximity Kit manager
//
@property (strong, nonatomic) PKManager *manager;

- (void) alert:(NSString *)msg, ... NS_FORMAT_FUNCTION(1,2);


@end
