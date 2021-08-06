#import "Geocoder.h"


@implementation Geocoder

RCT_EXPORT_MODULE()


RCT_EXPORT_METHOD(reverseGeocoding:(double)latitude withLongitude:(double)longitude
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject){
    resolve(nil);
}


RCT_EXPORT_METHOD(geocodeAnAddress:(NSString *)name
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject){
    resolve(nil);
}


RCT_EXPORT_METHOD(geocodeToAddressAtLocation:(NSString *)name withLatitude(double)latitude withLongitude:(double)longitude
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject){
    resolve(nil);
}


RCT_EXPORT_METHOD(geocodeToAddressAtRegion:(NSString *)name
                  withLatSouthwest(double)latSouthwest
                  withLonSouthwest:(double)lonSouthwest
                  withLatNortheast(double)latNortheast
                  withLonNortheast:(double)lonNortheast
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject){
    resolve(nil);
}


@end
