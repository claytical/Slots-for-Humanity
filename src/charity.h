//
//  slot.h
//  slots for humanity
//
//  Created by Clay Ewing on 8/24/13.
//
//

#include "ofMain.h"

class Charity{
    
public:
    void display();
    void create(int _id, int x, int y, int rad, float amt, ofImage *, string srv, ofTrueTypeFont *);
    ofPoint pos;
    float alpha;
    float speed;
    int radius;
    string service;
    int sid;
    float amount;
    bool donation;
    bool donating;
    ofImage *image;
    ofTrueTypeFont *font;
};
