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
        
        NSMutableArray *result = [NSMutableArray array];
        if (!placemarks){
            resolve(result);
            return;
        }
        NSLog(@"Getting %lu Places", (unsigned long)placemarks.count);
        
        for (CLPlacemark *placemark in placemarks) {
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

            [place setValue:latitde forKey:@"latitude"];
            [place setValue:longitude forKey:@"longitude"];

            [result addObject:place];
        }

        resolve(result);
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
        
        NSMutableArray *result = [NSMutableArray array];
        if (!placemarks){
            resolve(result);
            return;
        }
        NSLog(@"Getting %lu Places", (unsigned long)placemarks.count);
        
        for (CLPlacemark *placemark in placemarks) {
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

            [place setValue:latitde forKey:@"latitude"];
            [place setValue:longitude forKey:@"longitude"];

            [result addObject:place];
        }

        resolve(result);
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
        
        NSMutableArray *result = [NSMutableArray array];
        if (!placemarks){
            resolve(result);
            return;
        }
        NSLog(@"Getting %lu Places", (unsigned long)placemarks.count);
        
        for (CLPlacemark *placemark in placemarks) {
            NSMutableDictionary *place = [[NSMutableDictionary alloc] initWithObjectsAndKeys:placemark.name, @"address", nil];
            [place setValue:placemark.thoroughfare forKey:@"thoroughfare"];
            [place setValue:placemark.subThoroughfare forKey:@"sub_thoroughfare"];
            [place setValue:placemark.locality forKey:@"locality"];
            [place setValue:placemark.subLocality forKey:@"sub_locality"];
            [place setValue:placemark.administrativeArea forKey:@"admin_area"];
            [place setValue:placemark.subAdministrativeArea forKey:@"sub_admin_area"];
            [place setValue:placemark.postalCode forKey:@"postal_code"];
            [place setValue:placemark.ISOcountryCode forKey:@"country_code"];
            [place setValue:placemark.country forKey:@"country_name"];

            [place setValue:latitde forKey:@"latitude"];
            [place setValue:longitude forKey:@"longitude"];

            [result addObject:place];
        }

        resolve(result);
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
        
        NSMutableArray *result = [NSMutableArray array];
        if (!placemarks){
            resolve(result);
            return;
        }
        NSLog(@"Getting %lu Places", (unsigned long)placemarks.count);
        
        for (CLPlacemark *placemark in placemarks) {
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

            [place setValue:latitde forKey:@"latitude"];
            [place setValue:longitude forKey:@"longitude"];

            [result addObject:place];
        }

        resolve(result);
    }];
}

@end
