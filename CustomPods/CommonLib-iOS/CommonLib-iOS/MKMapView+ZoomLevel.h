//
//  MKMapView+ZoomLevel.h
//  BPH
//
//  Created by Karol Moluszys on 18.12.2012.
//
//

#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate zoomLevel:(NSUInteger)zoomLevel animated:(BOOL)animated;
- (int)getZoomLevelBasedOnRegion;

@end
