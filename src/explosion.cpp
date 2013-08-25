//
//  explosion.cpp
//  slots for humanity
//
//  Created by Clay Ewing on 8/25/13.
//
//

#include "explosion.h"
void Explosion::display() {
    pos += speed;
    ofSetColor(255, 255, 255);
    image->draw(pos, 5, 5);
    timer++;
}

void Explosion::create(ofPoint origin, ofImage * img) {
    pos.set(origin);
    speed.set(ofRandom(-3,3), ofRandom(-3,3));
    timer = 0;
    image = img;
    
}
