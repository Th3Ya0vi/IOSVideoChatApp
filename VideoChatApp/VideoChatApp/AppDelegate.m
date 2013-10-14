//
//  AppDelegate.m
//  VideoChatApp
//
//  Created by Deepak on 10/10/13.
//  Copyright (c) 2013 Deepak. All rights reserved.
//

#import "AppDelegate.h"

#import "UsersListViewController.h"
#import "SplashController.h"
#import "NumberToLetterConverter.h"
#import "SignUpViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Set QuickBlox credentials
    /*[QBSettings setApplicationID:771];
    [QBSettings setAuthorizationKey:@"hOYSNJ8zwYhUspn"];
    [QBSettings setAuthorizationSecret:@"KcfDYJFY7x3r5HR"];
    [QBSettings setRestAPIVersion:@"0.1.1"];*/
    
    [QBSettings setApplicationID:4464];
    [QBSettings setAuthorizationKey:@"Bpb6qEUTR8sPkZb"];
    [QBSettings setAuthorizationSecret:@"tMugEgKvH9wkR2b"];
    [QBSettings setRestAPIVersion:@"0.1.1"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
//    self.chatViewController = [[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];
//    self.window.rootViewController = self.chatViewController;
    
    self.signUpViewController = [[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:self.signUpViewController];
    [self.signUpViewController.navigationController setNavigationBarHidden:YES];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];



    // show splash
    //[self showSplashWithAnimation:NO];

    return YES;
}
- (void)showSplashWithAnimation:(BOOL) animated showLoginButton:(BOOL)isShow{
    
    // show Splash
    SplashController *splashViewController = [[SplashController alloc] initWithNibName:@"SplashController" bundle:nil];
    splashViewController.openedAtStartApp = !animated;
    //[self.chatViewController presentModalViewController:splashViewController animated:animated];
    [self.usersListViewController.navigationController pushViewController:splashViewController animated:animated];

    //[splashViewController release];
    
    // logout
    if(animated){
        [[FBService shared].facebook setSessionDelegate:splashViewController];
        [splashViewController showLoginButton:isShow];
    }
}

- (void)showSplashWithAnimation:(BOOL) animated{
    
    // show Splash
    SplashController *splashViewController = [[SplashController alloc] initWithNibName:@"SplashController" bundle:nil];
    splashViewController.openedAtStartApp = !animated;
    [self.usersListViewController presentModalViewController:splashViewController animated:animated];
    //[splashViewController release];
    
    // logout
    if(animated){
        [[FBService shared].facebook setSessionDelegate:splashViewController];
    }
}

// For iOS 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[FBService shared].facebook handleOpenURL:url];
}

// Pre iOS 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [[FBService shared].facebook handleOpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    
    if ([DataManager shared].currentQBUser)
	{
		[[FBService shared] logOutChat];
	}
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// update access token (if it expired)
	QBASessionCreationRequest *extendedAuthRequest = [[QBASessionCreationRequest alloc] init];
	extendedAuthRequest.devicePlatorm = DevicePlatformiOS;
	extendedAuthRequest.deviceUDID = [[UIDevice currentDevice] uniqueIdentifier];
    if([DataManager shared].currentFBUser){
        extendedAuthRequest.userLogin = [[NumberToLetterConverter instance] convertNumbersToLetters:[[DataManager shared].currentFBUser objectForKey:kId]];
        extendedAuthRequest.userPassword = [NSString stringWithFormat:@"%u", [[[DataManager shared].currentFBUser objectForKey:kId] hash]];
    }
	
	// QuickBlox application authorization
	[QBAuth createSessionWithExtendedRequest:extendedAuthRequest delegate:nil];
	
	//[extendedAuthRequest release];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	if (![FBService shared].isChatDidConnect && [DataManager shared].currentQBUser) // if user was disconnected in chat & he was authenticated fo FB
	{
		[[FBService shared] logInChat]; // auth to chat again
	}
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//
//- (void) checkMemory {
//    // clear image cache
//    //[AsyncImageView clearCache];
//    
//	if (printMemoryInfo() < 3) {
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Attention","Title of alert")
//                                                        message:[NSString stringWithFormat:NSLocalizedString(@"ChattAR may crash  \n if you don't completely close \n other unused apps.", "Low memory alert"), appName]
//                                                       delegate:nil
//                                              cancelButtonTitle:nil
//                                              otherButtonTitles:NSLocalizedString(@"Go on working", "Button text"), nil];
//        [alert show];
//        //[alert release];
//	} 
//}
@end
