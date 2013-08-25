//
//  money.cpp
//  slots for humanity
//
//  Created by Clay Ewing on 8/24/13.
//
//

#include "money.h"

void Money::display() {
    pos.y += speed;
    ofSetColor(255);
    image->draw(pos, radius, radius);
    //    ofCircle(pos.x, pos.y, radius);
}

void Money::create(int r, int amt, ofImage * img) {
    pos.set(ofRandom(r, ofGetWidth() - r), -ofGetHeight() - r);
    radius = r;
    speed = 3;
    amount = amt;
    image = img;
    
}
