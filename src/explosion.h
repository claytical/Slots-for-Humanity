//
//  explosion.h
//  slots for humanity
//
//  Created by Clay Ewing on 8/25/13.
//
//

#include "ofMain.h"

class Explosion{
    
public:
    void display();
    void create(ofPoint _origin, ofImage *);
    ofPoint speed;
    ofPoint pos;
    ofImage *image;
    int timer;
    bool dead;
};
