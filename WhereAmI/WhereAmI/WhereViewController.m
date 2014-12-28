//
//  WhereViewController.m
//  WhereAmI
//
//  Created by tirostiros on 14-12-28.
//  Copyright (c) 2014年 cn.com.tiros. All rights reserved.
//

#import "WhereViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface WhereViewController ()
@property(nonatomic,strong)CLLocationManager *locationManger;

@end

@implementation WhereViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.locationManger = [[CLLocationManager alloc] init];
    [self.locationManger setDelegate:self];
    //设置精度
    [self.locationManger setDesiredAccuracy:kCLLocationAccuracyBest];
    //设置更新距离，超过了才回调更新
    [self.locationManger setDistanceFilter:500.0];
    [self.locationManger startUpdatingLocation];
}

-(void)dealloc
{
    //delegate不是弱饮用也不是强饮用，而是unsafe_unretain
    //和weak的区别：weak不增加计数器，只有指针，并且当指针内容被释放后，指针会被置为nil，内存不会乱
    //unsafe_unretain不会被置为nil，所以不使用的地方最好手动置为nil
    [self.locationManger setDelegate:nil];
}

#pragma mark 定位回调协议
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"old:%@",oldLocation);
    NSLog(@"new:%@",newLocation);
}




@end
