//
//  ViewController.m
//  MapKitDemo
//
//  Created by TheAppGuruz-iOS-103 on 09/03/15.
//  Copyright (c) 2015 TheAppGururz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize objMapView;

- (IBAction)plusButton:(id)sender {

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadUserLocation];
    [self.objMapView setShowsUserLocation:YES];

}




- (void) loadUserLocation
{
    objLocationManager = [[CLLocationManager alloc] init];
    objLocationManager.delegate = self;
    objLocationManager.distanceFilter = kCLDistanceFilterNone;
    objLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    if ([objLocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [objLocationManager requestWhenInUseAuthorization];
    }
    [objLocationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0)
{
    CLLocation *newLocation = [locations objectAtIndex:0];
    latitude_UserLocation = newLocation.coordinate.latitude;
    longitude_UserLocation = newLocation.coordinate.longitude;
    [objLocationManager stopUpdatingLocation];
    [self loadMapView];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    [objLocationManager stopUpdatingLocation];
}

- (void) loadMapView
{
    CLLocationCoordinate2D objCoor2D = {.latitude =  latitude_UserLocation, .longitude =  longitude_UserLocation};
    MKCoordinateSpan objCoorSpan = {.latitudeDelta =  0.2, .longitudeDelta =  0.2};
    MKCoordinateRegion objMapRegion = {objCoor2D, objCoorSpan};
    [objMapView setRegion:objMapRegion];
}

@end
