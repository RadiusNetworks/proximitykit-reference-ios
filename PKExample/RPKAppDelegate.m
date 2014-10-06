//  Copyright (c) 2013-14 RadiusNetworks. All rights reserved.

#import <UIKit/UIKit.h>
#import "RPKAppDelegate.h"

@implementation RPKAppDelegate

#pragma mark Application Delegate Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.manager = [RPKManager managerWithDelegate:self];
    [self.manager start];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    // Called when updating applicaiton data in the background. Requires that UIBackgroundModes contains "fetch" in the applications's Info.plist. See PKExample-Info.plist for an example.
    [self.manager syncWithCompletionHandler: completionHandler];
}

#pragma mark Proximity Kit Delegate Methods

- (void)proximityKitDidSync:(RPKManager *)manager {
    NSLog(@"Did Sync");
}
- (void)proximityKit:(RPKManager *)manager didEnter:(RPKRegion*)region {
    NSLog(@"Entered Region %@ (%@)", region.name, region.identifier);
}

- (void)proximityKit:(RPKManager *)manager didExit:(RPKRegion *)region {
    NSLog(@"Exited Region %@ (%@)", region.name, region.identifier);
}

- (void)proximityKit:(RPKManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(RPKBeacon *)region
{
    for (RPKBeacon *beacon in beacons) {
        NSLog(@"Ranged UUID: %@ Major:%ld Minor:%ld RSSI:%ld", [beacon.uuid UUIDString], (long)beacon.major, (long)beacon.minor, (long)beacon.rssi);
    }
}

- (void)proximityKit:(RPKManager *)manager didDetermineState:(RPKRegionState)state forRegion:(RPKRegion *)region
{

    if (state == RPKRegionStateInside) {
        NSLog(@"State Changed: inside region %@ (%@)", region.name, region.identifier);
    } else if (state == RPKRegionStateOutside) {
        NSLog(@"State Changed: outside region %@ (%@)", region.name, region.identifier);
    } else if (state == RPKRegionStateUnknown) {
        NSLog(@"State Changed: unknown region %@ (%@)", region.name, region.identifier);
    }
}

- (void)proximityKit:(RPKManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error.description);
}

#pragma mark Helper Methods

- (void) alert:(NSString *)format, ...
{
    va_list args;
    va_start(args, format);
    NSString *str = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Proximity Kit"
                                                    message: [NSString stringWithFormat:@"%@", str]
                                                   delegate: nil
                                          cancelButtonTitle: @"OK"
                                          otherButtonTitles: nil];
    [alert show];
}

@end
