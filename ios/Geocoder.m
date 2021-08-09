#import <CoreLocation/CoreLocation.h>
#import "Geocoder.h"

@implementation Geocoder

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(reverseGeocoding:(double)latitude
                  longitude:(double)longitude
                  resolver:(RCTPrommiseResolbeBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"Geocode failed with error: %@", error);
            reject("ERROR_FOUND", "Geocode failed", error);
            return; // Request failed, log error
        }
        // Check if any placemarks were found                                                                    
        if (placemarks) {// && placemarks.count > 0
            [releaseData:placemarks resolver:resolve rejecter:reject];
        }else{
            resolve(nil);
        }
    }];
}

RCT_EXPORT_METHOD(geocodeAnAddress:(NSString *)addressName
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    [self.geocodeAddressString:addressName resolver:resolve rejecter:rejecter];
}

RCT_EXPORT_METHOD(geocodeToAddressAtLocation:(NSString *)addressName
                  latitude:(double)latitude
                  longitude:(double)longitude
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    [self.geocodeAddressString:addressName resolver:resolve rejecter:reject];
}

RCT_EXPORT_METHOD(geocodeToAddressAtRegion:(NSString *)addressName
                  withLatSouthwest:(double)latSouthwest
                  withLonSouthwest:(double)lonSouthwest
                  withLatNortheast:(double)latNortheast
                  withLonNortheast:(double)lonNortheast
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    [self.geocodeAddressString:addressName resolver:resolve rejecter:reject];
}

-(void)geocodeAddressString:(NSString) *addressName resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject
{
    NSLog(@"geocodeAddressString %@",addressName);
    
    [geocoder geocodeAddressString:addressName completionHandler:^(NSArray *placemarks, NSError *error){
        if (error) {
            NSLog(@"Geocode failed with error: %@", error);
            reject("ERROR_FOUND", "Geocode failed", error);
            return; // Request failed, log error
        }

        // Check if any placemarks were found                                                                    
        if (placemarks) {// && placemarks.count > 0
            [releaseData:placemarks resolver:resolve rejecter:reject];
        }else{
            resolve(nil);
        }
    }];
}

-(void)releaseData:(NSArray) *placemarks resolver:(RCTPromiseResolveBlock)resolve
{
    NSLog(@"releaseData %@",placemarks);
    for (id *element in placemarks) {
        [addressToMap:element]
    }
    resolve(true)
}

-(NSDictionary)addressToMap:(CLPlacemark) *placemark
{
    NSLog(@"addressToMap %@ ", placemark);
    NSDictionary *addressDictionary = placemark.addressDictionary;
    return addressDictionary
}

@end
