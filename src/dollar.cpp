//
//  Dollar.cpp
//  slots for humanity
//
//  Created by Clay Ewing on 8/24/13.
//
//

#include "dollar.h"

void Dollar::display() {
    pos.y -= speed;
    //ofSetColor(0, 255, 0);
    //ofCircle(pos.x, pos.y, radius);
}

void Dollar::create(int x, int r) {
    pos.set(x, ofGetHeight() - (r + 5));
    radius = r;
    speed = 5;
    donated = false;
}
