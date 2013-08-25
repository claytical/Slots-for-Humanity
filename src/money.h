//
//  money.h
//  slots for humanity
//
//  Created by Clay Ewing on 8/24/13.
//
//

#include "ofMain.h"

class Money{
    
public:
    void display();
    void create(int r, int amt, ofImage *);
    ofPoint pos;
    float speed;
    float amount;
    float radius;
    ofImage *image;
};
