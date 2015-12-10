//
//  addViewController.m
//  realphotothing
//
//  Created by Kevin Fang on 12/9/15.
//  Copyright © 2015 Kevin Fang. All rights reserved.
//

#import "addViewController.h"

@interface addViewController ()

@end

@implementation addViewController{
    IBOutletCollection(UIImageView) NSArray *image;
    __weak IBOutlet UIButton *choosePhoto;
}


@synthesize miniMapView;

- (IBAction)photoStream:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    
    // Don't forget to add UIImagePickerControllerDelegate in your .h
    picker.delegate = self;
    
    if((UIButton *) sender == choosePhoto) {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
    } else {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    [self presentModalViewController:picker animated:YES];
    
}

- (IBAction)takePhoto:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    
    // Don't forget to add UIImagePickerControllerDelegate in your .h
    picker.delegate = self;
    
    if((UIButton *) sender == choosePhoto) {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
    } else {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    [self presentModalViewController:picker animated:YES];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadUserLocation];
    [self.miniMapView setShowsUserLocation:YES];
    
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
    [miniMapView setRegion:objMapRegion];
}


@end
