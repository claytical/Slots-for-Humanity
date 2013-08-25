//
//  mainMenu.h
//  slots for humanity
//
//  Created by Clay Ewing on 8/24/13.
//
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"
#import <GameKit/GameKit.h>
#import "GameCenterManager.h"
#include "testApp.h"
#define kLeaderboardID @"leaderboard_one"

@class GameCenterManager;
@interface mainMenu : UIViewController <PayPalPaymentDelegate,GKLeaderboardViewControllerDelegate, GameCenterManagerDelegate> {
    GameCenterManager *gameCenterManager;
    IBOutlet UIButton *paypalButton;
    IBOutlet UIButton *gameCenterButton;
    IBOutlet UISegmentedControl *donationLevel;
	testApp *myApp;		// points to our instance of testApp
}
@property (nonatomic, retain) GameCenterManager *gameCenterManager;

-(void)setBankRoll:(NSString *)trackStr;
-(IBAction)showLeaderboard;
-(IBAction)coinsInTheSlot:(id)sender;

@end
