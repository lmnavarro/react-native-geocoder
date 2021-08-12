#import <CoreLocation/CoreLocation.h>
#import "Geocoder.h"

@implementation Geocoder

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(reverseGeocoding:(double)latitude
                  longitude:(double)longitude
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    NSLog(@"Start Reverse Geocoding With latitde: %f And longitude: %f", latitude, longitude);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"Geocode failed with error: %@", error);
            reject(@"ERROR_FOUND", @"Geocode failed", error);
            return; // Request failed, log error
        }
        
        if (!placemarks){
            resolve(nil);
            return;
        }
        NSLog(@"Getting %lu Places", (unsigned long)placemarks.count);
        
        if(!(placemarks.count>0)){
            resolve(nil);
            return;
        }
        
        CLPlacemark *placemark = placemarks[0];
        
        NSMutableDictionary *place = [[NSMutableDictionary alloc] initWithObjectsAndKeys:placemark.name, @"name", nil];
        [place setValue:placemark.thoroughfare forKey:@"thoroughfare"];
        [place setValue:placemark.subThoroughfare forKey:@"sub_thoroughfare"];
        [place setValue:placemark.locality forKey:@"locality"];
        [place setValue:placemark.subLocality forKey:@"sub_locality"];
        [place setValue:placemark.administrativeArea forKey:@"admin_area"];
        [place setValue:placemark.subAdministrativeArea forKey:@"sub_admin_area"];
        [place setValue:placemark.postalCode forKey:@"postal_code"];
        [place setValue:placemark.ISOcountryCode forKey:@"country_code"];
        [place setValue:placemark.country forKey:@"country_name"];
                
        [place setValue:@"0.0" forKey:@"latitude"];
        [place setValue:@"0.0" forKey:@"longitude"];
        
        
        resolve(place);
    }];
}

RCT_EXPORT_METHOD(geocodeAnAddress:(NSString *)addressName
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    NSLog(@"Start Gecode An Address With: %@", addressName);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:addressName completionHandler:^(NSArray *placemarks, NSError *error){
        if (error) {
            NSLog(@"Geocode failed with error: %@", error);
            reject(@"ERROR_FOUND", @"Geocode failed", error);
            return; // Request failed, log error
        }
        if (!placemarks){
            resolve(nil);
            return;
        }
        for (CLPlacemark *placemark in placemarks) {
            NSLog(@"addressToMap %@ ", placemark);
            //NSDictionary *addressDictionary = placemark.addressDictionary;
        }
    }];
}

RCT_EXPORT_METHOD(geocodeToAddressAtLocation:(NSString *)addressName
                  latitude:(double)latitude
                  longitude:(double)longitude
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    NSLog(@"Start Gecode To Address At Location With: %@", addressName);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:addressName completionHandler:^(NSArray *placemarks, NSError *error){
        if (error) {
            NSLog(@"Geocode failed with error: %@", error);
            reject(@"ERROR_FOUND", @"Geocode failed", error);
            return; // Request failed, log error
        }
        if (!placemarks){
            resolve(nil);
            return;
        }
        for (CLPlacemark *placemark in placemarks) {
            NSLog(@"addressToMap %@ ", placemark);
            //NSDictionary *addressDictionary = placemark.addressDictionary;
        }
    }];
}

RCT_EXPORT_METHOD(geocodeToAddressAtRegion:(NSString *)addressName
                  withLatSouthwest:(double)latSouthwest
                  withLonSouthwest:(double)lonSouthwest
                  withLatNortheast:(double)latNortheast
                  withLonNortheast:(double)lonNortheast
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    NSLog(@"Start Gecode To Addres At Region With: %@", addressName);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:addressName completionHandler:^(NSArray *placemarks, NSError *error){
        if (error) {
            NSLog(@"Geocode failed with error: %@", error);
            reject(@"ERROR_FOUND", @"Geocode failed", error);
            return; // Request failed, log error
        }
        if (!placemarks){
            resolve(nil);
            return;
        }
        for (CLPlacemark *placemark in placemarks) {
            NSLog(@"addressToMap %@ ", placemark);
            //NSDictionary *addressDictionary = placemark.addressDictionary;
        }
    }];
}

@end
