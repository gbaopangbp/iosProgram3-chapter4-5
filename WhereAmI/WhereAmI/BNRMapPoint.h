//
//  BNRMapPoint.h
//  WhereAmI
//
//  Created by tirostiros on 14-12-28.
//  Copyright (c) 2014年 cn.com.tiros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BNRMapPoint : NSObject<MKAnnotation>
@property (nonatomic) CLLocationCoordinate2D coordinate;
// Title and subtitle for use by selection UI.
@property (nonatomic, copy) NSString *title;


-(id)init;
-(id)initWithCoordinate:(CLLocationCoordinate2D) coordinate title:(NSString*) title;


@end
