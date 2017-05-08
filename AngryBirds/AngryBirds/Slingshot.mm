//
//  Slingshot.m
//  AngryBirds
//
//  Created by xumeng on 17/5/7.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "Slingshot.h"

@implementation Slingshot
@synthesize startPoint1=_startPoint1,startPoint2=_startPoint2,endPoint=_endPoint;


//draw fucntion is the virtual function from ccnode, if we wanna draw sth, we need to implement this func
-(void)draw{

    //set width of line
    glLineWidth(2.0f);
    //set color of line
    glColor4f(1.0f, 0.0f, 0.0f, 0.0f);
    
    //把线反锯齿
    glEnable(GL_LINE_SMOOTH);
    //stop state machine
    glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    glDisableClientState(GL_COLOR_ARRAY);
    
    //draw lines
    GLfloat vertices1[4]={static_cast<GLfloat>(_startPoint1.x),static_cast<GLfloat>(_startPoint1.y),static_cast<GLfloat>(_endPoint.x),static_cast<GLfloat>(_endPoint.y)};
    glVertexPointer(2, GL_FLOAT, 0, vertices1);
    glDrawArrays(GL_LINES, 0, 2);
    
    GLfloat vertices2[4]={static_cast<GLfloat>(_startPoint2.x),static_cast<GLfloat>(_startPoint2.y),static_cast<GLfloat>(_endPoint.x),static_cast<GLfloat>(_endPoint.y)};
    glVertexPointer(2, GL_FLOAT, 0, vertices2);
    glDrawArrays(GL_LINES, 0, 2);
    
    glEnableClientState(GL_COLOR_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glEnable(GL_TEXTURE_2D);
    //取消反锯齿
    glDisable(GL_LINE_SMOOTH);

}

@end
