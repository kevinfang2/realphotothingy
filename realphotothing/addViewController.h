//
//  addViewController.h
//  realphotothing
//
//  Created by Kevin Fang on 12/9/15.
//  Copyright © 2015 Kevin Fang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface addViewController : UIViewController <UIImagePickerControllerDelegate>{
    CLLocationManager *objLocationManager;
    double latitude_UserLocation, longitude_UserLocation;
}
@property (weak, nonatomic) IBOutlet MKMapView *miniMapView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
