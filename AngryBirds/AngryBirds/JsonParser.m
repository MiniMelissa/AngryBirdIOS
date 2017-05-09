//
//  JsonParser.m
//  AngryBirds
//
//  Created by xumeng on 17/5/6.
//  Copyright © 2017年 xumeng. All rights reserved.
//

#import "JsonParser.h"
#import "SBJson.h"
@implementation SpriteModel
@synthesize tag,x,y,angle;
@end

@implementation JsonParser
//@synthesize tag,x,y,angle;

+(id)getAllSprite:(NSString *)file{
    //get content of json file
    NSString* content=[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    //json 解析，spriteModel的数据模型对象
    NSArray* spArray=[[[content JSONValue]objectForKey:@"sprites"]objectForKey:@"sprite"];
    
    //read sprite's data from json file
    NSMutableArray* array=[NSMutableArray array];
    for(NSDictionary* dict in spArray){
        SpriteModel* sm=[[SpriteModel alloc]init];
        //JsonParser* sm=[[JsonParser alloc]init];

        sm.tag= [[dict objectForKey:@"tag"]intValue];
        sm.x=[[dict objectForKey:@"x"]floatValue];
        sm.y=[[dict objectForKey:@"y"]floatValue];
        sm.angle=[[dict objectForKey:@"angle"]floatValue];
        
        [array addObject:sm];
        [sm release];
    }
    return array;
}

@end
