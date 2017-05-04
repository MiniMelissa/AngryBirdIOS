//
//  LoadingScene.h
//  AngryBirds
//
//  Created by xumeng on 17/5/4.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface LoadingScene : CCLayer{
    //define a 展示字符串的对象
    CCLabelBMFont *loadingtitle;
}

//class method, provide a scene to other class(外部)
+(id) scene;
@end
