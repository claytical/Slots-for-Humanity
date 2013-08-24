//
//  mainMenu.h
//  slots for humanity
//
//  Created by Clay Ewing on 8/24/13.
//
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"
#include "testApp.h"

@interface mainMenu : UIViewController <PayPalPaymentDelegate> {
    IBOutlet UIButton *paypalButton;
	testApp *myApp;		// points to our instance of testApp
}

-(void)setBankRoll:(NSString *)trackStr;

-(IBAction)coinsInTheSlot:(id)sender;

@end
