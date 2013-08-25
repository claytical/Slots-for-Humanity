//
//  mainMenu.cpp
//  slots for humanity
//
//  Created by Clay Ewing on 8/24/13.
//
//

#include "mainMenu.h"
#include "ofxiPhoneExtras.h"

@implementation mainMenu
@synthesize gameCenterManager;

-(void)viewDidLoad {
	myApp = (testApp*)ofGetAppPtr();
    if ([GameCenterManager isGameCenterAvailable]) {
        self.gameCenterManager = [[[GameCenterManager alloc] init] autorelease];
        [self.gameCenterManager setDelegate:self];
        [self.gameCenterManager authenticateLocalUser];
    } else {
        NSLog(@"Not Supported");
        // The current device does not support Game Center.
    }
}
-(IBAction)showLeaderboard {
        GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
        if (leaderboardController != NULL)
        {
            leaderboardController.category = kLeaderboardID;
            leaderboardController.timeScope = GKLeaderboardTimeScopeWeek;
            leaderboardController.leaderboardDelegate = self;
            [self presentModalViewController: leaderboardController animated: YES];
        }
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    [self dismissModalViewControllerAnimated: YES];
    [viewController release];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Start out working with the test environment! When you are ready, remove this line to switch to live.
    
    [PayPalPaymentViewController setEnvironment:PayPalEnvironmentNoNetwork];
    [PayPalPaymentViewController prepareForPaymentUsingClientId:@"AYi1wBC7uV5-04EXj6GJrulUCtwp_ZZpQgydQ1gg0AXlhlKtgL8EFtwzk4fO"];
    
}


//----------------------------------------------------------------
-(void)setBankRoll:(NSString *)trackStr{
	self.view.hidden = YES;

}


//----------------------------------------------------------------
-(IBAction)coinsInTheSlot:(id)sender{
    // Create a PayPalPayment
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    switch (donationLevel.selectedSegmentIndex) {
        case 0:
            payment.amount = [[NSDecimalNumber alloc] initWithString:@"1.00"];

            break;
        case 1:
            payment.amount = [[NSDecimalNumber alloc] initWithString:@"2.00"];

            break;
        case 2:
            payment.amount = [[NSDecimalNumber alloc] initWithString:@"5.00"];

            break;
        case 3:
            payment.amount = [[NSDecimalNumber alloc] initWithString:@"10.00"];

            break;
    }
    myApp->moneyOnHand = [payment.amount integerValue] * 10;
    myApp->startingCash = [payment.amount integerValue] * 10;
    
    payment.currencyCode = @"USD";
    payment.shortDescription = @"Amount of Change";
    
    // Check whether payment is processable.
    if (!payment.processable) {
        // If, for example, the amount was negative or the shortDescription was empty, then
        // this payment would not be processable. You would want to handle that here.
    }
    // Start out working with the test environment! When you are ready, remove this line to switch to live.
    [PayPalPaymentViewController setEnvironment:PayPalEnvironmentNoNetwork];
    
    // Provide a payerId that uniquely identifies a user within the scope of your system,
    // such as an email address or user ID.
    NSString *aPayerId = @"you@example.com";
    
    // Create a PayPalPaymentViewController with the credentials and payerId, the PayPalPayment
    // from the previous step, and a PayPalPaymentDelegate to handle the results.
    PayPalPaymentViewController *paymentViewController;
    paymentViewController = [[PayPalPaymentViewController alloc] initWithClientId:@"AYi1wBC7uV5-04EXj6GJrulUCtwp_ZZpQgydQ1gg0AXlhlKtgL8EFtwzk4fO"
                                                                    receiverEmail:@"clay@dataplayed.com"
                                                                          payerId:aPayerId
                                                                          payment:payment
                                                                         delegate:self];
    
    // Present the PayPalPaymentViewController.
    [self presentViewController:paymentViewController animated:YES completion:nil];
	
	
}


#pragma mark - PayPalPaymentDelegate methods

- (void)payPalPaymentDidComplete:(PayPalPayment *)completedPayment {
    // Payment was processed successfully; send to server for verification and fulfillment.
    [self verifyCompletedPayment:completedPayment];
    
    // Dismiss the PayPalPaymentViewController.
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel {
    // The payment was canceled; dismiss the PayPalPaymentViewController.
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)verifyCompletedPayment:(PayPalPayment *)completedPayment {
    // Send the entire confirmation dictionary
    NSData *confirmation = [NSJSONSerialization dataWithJSONObject:completedPayment.confirmation
                                                           options:0
                                                             error:nil];
    NSLog(@"Completed Payment");
    self.view.hidden = YES;
    myApp->gameState = TUTORING;
    
    // Send confirmation to your server; your server should verify the proof of payment
    // and give the user their goods or services. If the server is not reachable, save
    // the confirmation and try again later.
}

@end
