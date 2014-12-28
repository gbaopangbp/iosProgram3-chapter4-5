//
//  WhereViewController.h
//  WhereAmI
//
//  Created by tirostiros on 14-12-28.
//  Copyright (c) 2014年 cn.com.tiros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface WhereViewController : UIViewController<UITextFieldDelegate,MKMapViewDelegate,CLLocationManagerDelegate>

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation;

//- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView;
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation;

- (BOOL)textFieldShouldReturn:(UITextField *)textField;




@end
