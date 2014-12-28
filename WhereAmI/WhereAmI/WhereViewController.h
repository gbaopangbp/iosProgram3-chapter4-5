//
//  WhereViewController.h
//  WhereAmI
//
//  Created by tirostiros on 14-12-28.
//  Copyright (c) 2014年 cn.com.tiros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface WhereViewController : UIViewController<CLLocationManagerDelegate>

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation;

@end
