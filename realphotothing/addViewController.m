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
    __weak IBOutlet UITextField *title;
    __weak IBOutlet UITextField *description;
}


@synthesize miniMapView;
- (IBAction)done:(id)sender {
    NSArray *locations;
    CLLocation *newLocation = [locations objectAtIndex:0];
    latitude_UserLocation = newLocation.coordinate.latitude;
    longitude_UserLocation = newLocation.coordinate.longitude;
    NSLog(@"%f, %f",newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    [objLocationManager stopUpdatingLocation];
    [self loadMapView];
    
    CLLocationCoordinate2D pinlocation;
    pinlocation.latitude = 51.3883454; //set latitude of selected coordinate ;
    pinlocation.longitude = 1.4368011;
    //set longitude of selected coordinate;
    
    // Create Annotation point
    MKPointAnnotation *Pin = [[MKPointAnnotation alloc]init];
    Pin.coordinate = pinlocation;
    Pin.title = title.text;
    Pin.subtitle = description.text;
    
    // add annotation to mapview
}

- (IBAction)photoStream:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    
    // Don't forget to add UIImagePickerControllerDelegate in your .h
    picker.delegate = self;
    
    if((UIButton *) sender == choosePhoto) {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
    } else {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    image = picker;
    
    [self presentModalViewController:picker animated:YES];
    
}

- (IBAction)takePhoto:(id)sender {
    [self takePhoto];
}

-(void)takePhoto {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
#if TARGET_IPHONE_SIMULATOR
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#else
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
#endif
    imagePickerController.editing = YES;
    imagePickerController.delegate = (id)self;
    
    [self presentModalViewController:imagePickerController animated:YES];
    
    
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
