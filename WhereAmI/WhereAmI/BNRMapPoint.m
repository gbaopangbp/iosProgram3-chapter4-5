//
//  BNRMapPoint.m
//  WhereAmI
//
//  Created by tirostiros on 14-12-28.
//  Copyright (c) 2014年 cn.com.tiros. All rights reserved.
//

#import "BNRMapPoint.h"

@implementation BNRMapPoint

-(id)init
{
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(39.54, 116.23);
    return [self initWithCoordinate:coordinate title:@"天安门"];
}
-(id)initWithCoordinate:(CLLocationCoordinate2D) coordinate title:(NSString*) title
{
    self = [super init];
    if (self)
    {
        self.coordinate = coordinate;
        [self setTitle:title];
    }
    return self;
}

@end
