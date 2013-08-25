//
//  slot.cpp
//  slots for humanity
//
//  Created by Clay Ewing on 8/24/13.
//
//

#include "charity.h"
void Charity::display() {
    pos.y += speed;
    if (alpha <= 0) {
        donation = true;
    }
    if (donating) {
        alpha-=10;
        ofSetColor(127, 127, 127);
        font->drawString(service, pos.x - (font->stringWidth(service)/2), pos.y + (font->stringHeight(service) * 2));
    }
    ofSetColor(255, 255, 255, alpha);
    image->draw(pos, radius*2, radius*2);
}

void Charity::create(int _id, int x, int y, int rad, float amt, ofImage *img, string srv, ofTrueTypeFont *fnt) {
    pos.set(x, y);
    radius = rad;
    sid = _id;
    alpha = 200;
    amount = amt;
    speed = ofRandom(1, 3);
    donation = donating = false;
    image = img;
    font = fnt;
    service = srv;
}
