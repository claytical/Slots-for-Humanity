//
//  gameOver.h
//  slots for humanity
//
//  Created by Clay Ewing on 8/25/13.
//
//
#import <UIKit/UIKit.h>
#include "testApp.h"
@interface gameOver : UIViewController {
    IBOutlet UIButton *paypalButton;
    IBOutlet UIButton *gameCenterButton;
    IBOutlet UISegmentedControl *donationLevel;
	testApp *myApp;		// points to our instance of testApp
}

-(IBAction)mainMenu;

@end
