//
//  Dollar.h
//  slots for humanity
//
//  Created by Clay Ewing on 8/24/13.
//
//

#include "ofMain.h"

class Dollar{
    
public:
    void display();
    void create(int x, int r);
    ofPoint pos;
    float speed;
    float amount;
    float radius;
    bool donated;
};
