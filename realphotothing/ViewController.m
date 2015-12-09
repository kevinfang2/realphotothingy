//
//  ViewController.m
//  realphotothing
//
//  Created by Kevin Fang on 12/8/15.
//  Copyright © 2015 Kevin Fang. All rights reserved.
//

#import "ViewController.h"
#import <Mapkit/Mapkit.h>
#import <CoreLocation/CoreLocation.h>


@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapview;

@end

@implementation ViewController
#define METERS_PER_MILE 1609.344


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) findLocation{
    CLLocationCoordinate2D location = [[[_mapview userLocation] location] coordinate];
    NSLog(@"Location found from Map: %f %f",location.latitude,location.longitude);
    
}

- (void)viewWillAppear:(BOOL)animated {
    // 1

    
    CLLocationCoordinate2D zoomLocation;
//    zoomLocation.latitude = location.latitude;
//    zoomLocation.longitude= location.longitude;
    zoomLocation.latitude = 5;
    zoomLocation.longitude = 6;
    NSLog(@"locationfound:from map: %f %f",zoomLocation.latitude,zoomLocation.longitude);
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    // 3
    [_mapView setRegion:viewRegion animated:YES];
}

@end
