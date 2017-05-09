//
//  JsonParser.h
//  AngryBirds
//
//  Created by xumeng on 17/5/6.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpriteModel : NSObject{
    int tag;
    float x;
    float y;
    float angle;
}
@property(nonatomic,assign) int tag;
@property(nonatomic,assign) float x;
@property(nonatomic,assign) float y;
@property(nonatomic,assign) float angle;

@end



@interface JsonParser : NSObject
/*{
    int tag;
    float x;
    float y;
    float angle;
}
@property(nonatomic,assign) int tag;
@property(nonatomic,assign) float x;
@property(nonatomic,assign) float y;
@property(nonatomic,assign) float angle;*/
+(id)getAllSprite:(NSString*)file;



@end
