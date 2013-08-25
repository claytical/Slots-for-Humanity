#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "charity.h"
#include "dollar.h"
#include "money.h"
#include "explosion.h"

#define WAITING     0
#define TUTORING    1
#define SETUP       2
#define PLAYING     3
#define GAME_OVER   4

#define TUTOR_TIMER 200
#define CHARITY_RADIUS  30
#define COIN_RADIUS 8

class testApp : public ofxiPhoneApp{
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
        static bool donated(Dollar &dollar);
        static bool collected(Charity &charity);
        static bool exploded(Explosion &explosion);
        bool checkDonation(Charity charity, Dollar dollar);
        void findDonations();

        vector<Charity> charities;
        vector<Dollar> dollars;
        vector<ofPoint> cashStack;
        vector<ofImage> charityImages;
        vector<Money> moneyDrop;
        vector<Explosion> explosions;
        ofTrueTypeFont font;
        ofImage coinImage;
        ofImage moneyBagImage;
        ofImage piggyBank;
        ofPoint piggyBankPosition;
        int moneyOnHand;
        int startingCash;
        int gameState;
        int tutoringTime;
        float gameStartTime;
        float gameTime;
        int donations[28];
        ofxOpenALSoundPlayer coinSound;
        ofxOpenALSoundPlayer coinShot;
        ofxOpenALSoundPlayer bagSound;
};


