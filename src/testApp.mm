#include "testApp.h"
#include "mainMenu.h"
mainMenu *MainMenu;

//--------------------------------------------------------------
void testApp::setup(){
    moneyOnHand = startingCash = 0;
    tutoringTime = 0;
    coinSound.loadSound("coin.caf");
    coinShot.loadSound("shot.caf");
    bagSound.loadSound("bag.caf");
    piggyBankPosition.set(ofGetWidth()/2, ofGetHeight()-30);
	// initialize the accelerometer
	ofxAccelerometer.setup();
    font.loadFont("vag.ttf", 12);
	
	//If you want a landscape oreintation
	//iPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
	
	ofBackground(0);
    MainMenu = [[mainMenu alloc] initWithNibName:@"mainMenu" bundle:nil];


    gameState = WAITING;
    coinImage.loadImage("coin.png");
    moneyBagImage.loadImage("moneyBag.png");
    piggyBank.loadImage("piggyBank.png");
    ofSetRectMode(OF_RECTMODE_CENTER);
    ofEnableAlphaBlending();
    for (int i = 1; i < 28; i++) {
        ofImage tmpImage;
        tmpImage.loadImage("gameImage-"+ofToString(i)+".png");
        charityImages.push_back(tmpImage);
    }
    
    
    [ofxiPhoneGetGLParentView() addSubview:MainMenu.view];
 }

void testApp::findDonations() {
    vector<string> whereTo;
    string services[] = {"Environmental Science", "Mathematics", "Health & Life Sciences", "Applied Sciences", "Performing Arts", "Visual Arts", "Music", "Literacy", "Literature & Writing", "Foreign Languages", "ESL", "History & Geography", "Civics & Government", "Economics", "Social Sciences", "Early Development", "Special Needs", "Community Service", "Character Education", "College & Career Prep", "Extracurricular Learning", "Parent Involement", "Applied Learning", "Sports", "Health & Wellness", "Nutrition", "Gym & Fitness"};
    for (int i = 0; i < 28; i++) {
        if (donations[i] != 0) {
            whereTo.push_back(services[i]);
        }
    }
}
//--------------------------------------------------------------

bool testApp::checkDonation(Charity charity, Dollar dollar) {
    if(ofDist(charity.pos.x, charity.pos.y, dollar.pos.x, dollar.pos.y) <= charity.radius) {
        NSLog(@"Dollar Collected!");

        return true;
    }
    return false;
}

bool testApp::donated(Dollar &dollar){
	return (dollar.donated);
}

bool testApp::exploded(Explosion &explosion){
	return (explosion.timer > 100);
}

bool testApp::collected(Charity &charity){
	return (charity.donation);
}

//--------------------------------------------------------------
void testApp::update(){
    switch (gameState) {
        case WAITING:
            
            break;
        case SETUP:
            for (int i = 0; i < moneyOnHand; i++) {
                ofPoint rndPt;
                rndPt.set(ofRandom(COIN_RADIUS, ofGetWidth() - COIN_RADIUS), ofRandom(ofGetHeight(), ofGetHeight() - COIN_RADIUS));
                cashStack.push_back(rndPt);
            }
            gameStartTime = ofGetElapsedTimef();
            gameState = PLAYING;

            break;
        case PLAYING:
            gameTime = ofGetElapsedTimef() - gameStartTime;
            if (ofGetFrameNum()%100 == 0 && moneyDrop.size() < 1) {
                int getWhole = startingCash - moneyOnHand;
                Money moneyBomb;
                moneyBomb.create(COIN_RADIUS * 8, getWhole * .8, &moneyBagImage);
                moneyDrop.push_back(moneyBomb);
                NSLog(@"Dropping Money Bomb");

            }
            if (charities.size() <= 3) {
                Charity tmpCharity;
                int serviceId;
                string services[] = {"Environmental Science", "Mathematics", "Health and Life Sciences", "Applied Sciences", "Performing Arts", "Visual Arts", "Music", "Literacy", "Writing", "Foreign Languages", "ESL", "History", "Civics", "Economics", "Social Science", "Early Development", "Special Needs", "Community Service", "Character Education", "Career Prep", "Extracurriculars", "Parent Involvement", "Applied Learning", "Sports", "Health", "Nutrition", "Fitness"};
                
                serviceId = ofRandom(0, 27);
                NSLog(@"Service ID: %d", serviceId);
                tmpCharity.create(serviceId, ofRandom(CHARITY_RADIUS, ofGetWidth() - CHARITY_RADIUS), ofRandom(-CHARITY_RADIUS, -ofGetHeight()), CHARITY_RADIUS, .33, &charityImages[serviceId], services[serviceId], &font);
                charities.push_back(tmpCharity);
            }
            for (int j = 0; j < charities.size(); j++) {
                if (charities[j].pos.y > ofGetHeight()) {
                    charities[j].donation = true;
                    donations[charities[j].sid] += moneyOnHand;
               //     gameState = GAME_OVER;
                    break;
                }
                for (int i = 0; i < dollars.size(); i++) {

                    if(checkDonation(charities[j], dollars[i])) {
                        charities[j].donating = true;
                        donations[charities[j].sid] += 1;
                        dollars[i].donated = true;
                        coinSound.play();
                        NSLog(@"Giving to %@", ofxStringToNSString(charities[j].service));
                    }
                }
            }
            if (moneyDrop.size() > 0) {
                for (int i = 0; i < dollars.size(); i++) {
                    if (ofDist(moneyDrop[0].pos.x, moneyDrop[0].pos.y, dollars[i].pos.x, dollars[i].pos.y) <= moneyDrop[0].radius) {
                        moneyOnHand += moneyDrop[0].amount;
                        bagSound.play();
                        NSLog(@"Creating %f explosions", moneyDrop[0].amount);
                        for (int i = 0; i < 10; i++) {
                            Explosion explosion;
                            explosion.create(moneyDrop[0].pos, &coinImage);
                            explosions.push_back(explosion);
                        }
                        moneyDrop.clear();
                        
                    }
                }
            }
            ofRemove(dollars, donated);
            ofRemove(charities, collected);
            ofRemove(explosions, exploded);
            break;
        case GAME_OVER:
            break;
            
    }

}

//--------------------------------------------------------------
void testApp::draw(){
    switch (gameState) {
        case WAITING:
            break;
        case TUTORING:
            tutoringTime++;
            ofSetColor(255, 255, 0);
            font.drawString("Tap to Donate\nDon't Give It Away\nAll At Once!", 20, ofGetHeight()/2);
            if (tutoringTime >= TUTOR_TIMER) {
                tutoringTime = 0;
                gameState = SETUP;
            }
            break;
        case PLAYING:
            for (int i = 0; i < charities.size(); i++) {
                charities[i].display();
            }
            for (int i = 0; i < dollars.size(); i++) {
                dollars[i].display();
                coinImage.draw(dollars[i].pos, COIN_RADIUS*2, COIN_RADIUS*2);
            }
            
            for (int i = 0; i < moneyDrop.size(); i++) {
                moneyDrop[i].display();
            }
            
//            font.drawString("$" + ofToString(moneyOnHand) + " LEFT", 20, 20);

            ofSetColor(255, 255, 255);
            
            font.drawString("Time Spent Donating: " + ofToString(int(gameTime)), 20, 20);

            ofSetColor(255, 255, 255);
            piggyBank.draw(piggyBankPosition, 50, 50);
            ofSetColor(0, 0, 0);
            font.drawString(ofToString(moneyOnHand), piggyBankPosition.x, piggyBankPosition.y + 5);
            break;
        case GAME_OVER:
            break;
        default:
            break;
    }

}

//--------------------------------------------------------------
void testApp::exit(){

}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch){
    Dollar tmpDollar;
    switch (gameState) {
        case PLAYING:
            piggyBankPosition.x = touch.x - 3;
            tmpDollar.create(touch.x, COIN_RADIUS);
            dollars.push_back(tmpDollar);
            coinShot.play();
            moneyOnHand--;
            break;
        case GAME_OVER:
            break;
        case WAITING:
            break;
    }
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){
    if (moneyOnHand <= 0) {
        gameState = GAME_OVER;
    }
    /*
    if (currentSlot == 3) {
        if (stoppedOn[0] == 0 && stoppedOn[1] == 0 && stoppedOn[2] == 0) {
            NSLog(@"You actually won!");
        }
        else {
            for (int i = 0; i < 3; i++) {
                if (stoppedOn[i] != 0) {
                    NSLog(@"Sending 33 cents to %s", spinner1[stoppedOn[i]].service.c_str());

                    NSMutableURLRequest *request =
                    [[NSMutableURLRequest alloc] initWithURL:
                     [NSURL URLWithString:@"http://api.dataplayed.com/slots/donate.php"]];
                    
                    [request setHTTPMethod:@"POST"];
                    
                    NSString *postString = [NSString stringWithFormat:@"service=%@&amount=.33", ofxStringToNSString(spinner1[stoppedOn[i]].service)];
                    
                    [request setValue:[NSString
                                       stringWithFormat:@"%d", [postString length]]
                   forHTTPHeaderField:@"Content-length"];
                    
                    [request setHTTPBody:[postString 
                                          dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    [[NSURLConnection alloc] 
                     initWithRequest:request delegate:ofxiPhoneGetAppDelegate()];
                
                }
            }
        }
    }
*/
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void testApp::lostFocus(){

}

//--------------------------------------------------------------
void testApp::gotFocus(){

}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){

}

