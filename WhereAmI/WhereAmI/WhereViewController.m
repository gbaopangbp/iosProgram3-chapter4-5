//
//  WhereViewController.m
//  WhereAmI
//
//  Created by tirostiros on 14-12-28.
//  Copyright (c) 2014年 cn.com.tiros. All rights reserved.
//

#import "WhereViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "BNRMapPoint.h"

@interface WhereViewController ()
@property(nonatomic,strong)CLLocationManager *locationManger;
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)segementChange:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *control;

@end

@implementation WhereViewController

#define MAP_TYPE @"mapDefineType"


//类的初始化函数，较早执行，应该userdefault设置默认项，如果不设，获取的没有设置过的key的结果都是0，
//获取一个key对应的value，先查找配置文件，如果没有在默认项查找，如果没有配置默认项，返回0
//默认项必须每次都启动都配置，否则不会生效。并且需要在调用userdefault之前就配置好，所以选择initialize中进行
+(void)initialize
{
    NSDictionary *dir = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:1] forKey:MAP_TYPE];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dir];
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.locationManger = [[CLLocationManager alloc] init];

        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.mapView setShowsUserLocation:YES];
    
    [self.locationManger setDelegate:self];
    //设置精度
    [self.locationManger setDesiredAccuracy:kCLLocationAccuracyBest];
    //设置更新距离，超过了才回调更新
    [self.locationManger setDistanceFilter:500.0];
    
    [self.titleText setDelegate:self];
    
    //地图显示用户位置，才会有地图上的定位回调
    [self.mapView setDelegate:self];
    NSInteger type = [[NSUserDefaults standardUserDefaults] integerForKey:MAP_TYPE];
    [self setMapType:type];
    
    //    [self.mapView setMapType:MKMapTypeHybrid];
    //    [self.locationManger startUpdatingLocation];
    [self.control setSelectedSegmentIndex:type];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userChangeMap:) name:NSUserDefaultsDidChangeNotification object:nil];

}

-(void)userChangeMap:(NSNotification*)change
{
    NSLog(@"%@",change);
}

-(void)setMapType:(NSInteger)type
{
    if (type == 0)
    {
        [self.mapView setMapType:MKMapTypeStandard];
    }
    else
    {
        [self.mapView setMapType:MKMapTypeHybrid];
    }
}


-(void)dealloc
{
    //delegate不是弱饮用也不是强饮用，而是unsafe_unretain
    //和weak的区别：weak不增加计数器，只有指针，并且当指针内容被释放后，指针会被置为nil，内存不会乱
    //unsafe_unretain不会被置为nil，所以不使用的地方最好手动置为nil
    [self.locationManger setDelegate:nil];
}

//开始定位
-(void)findLocation
{
    [self.locationManger startUpdatingLocation];
    [self.indicator startAnimating];
    [self.titleText setHidden:YES];
}

//定位成功
-(void)locationed:(CLLocationCoordinate2D)loc
{
    //增加点
    BNRMapPoint * point = [[BNRMapPoint alloc] initWithCoordinate:loc title:self.titleText.text];
    [self.mapView addAnnotation:point];
    
    //设置显示范围
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 2000, 2000);
    [self.mapView setRegion:region animated:YES];
    
    //重置界面
    [self.titleText setText:@""];
    [self.titleText setHidden:NO];
    [self.locationManger stopUpdatingLocation];
    [self.indicator stopAnimating];

}

#pragma mark 定位回调协议
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"old:%@",oldLocation);
    NSLog(@"new:%@",newLocation);
    
    NSTimeInterval t = [newLocation.timestamp timeIntervalSinceNow];
    NSLog(@"time interl:%f",t);
    //很早以前的位置不要
    if (t > -180)
    {
        [self locationed:[newLocation coordinate]];
    }
    
}



#pragma mark 地图回调协议
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateSpan span = MKCoordinateSpanMake(0.3, 0.3);
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.location.coordinate, span);
    [mapView setRegion:region animated:YES];
}

#pragma mark textView回调协议
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [self findLocation];
    [self.titleText resignFirstResponder];
    return YES;
}






- (IBAction)segementChange:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    [self setMapType:control.selectedSegmentIndex];
    [[NSUserDefaults standardUserDefaults] setInteger:control.selectedSegmentIndex forKey:MAP_TYPE];
}
@end
