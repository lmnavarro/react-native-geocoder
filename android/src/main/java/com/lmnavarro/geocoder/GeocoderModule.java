package com.lmnavarro.geocoder;

import android.location.Address;
import android.location.Geocoder;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableMap;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class GeocoderModule extends ReactContextBaseJavaModule {

    private static final int MAX_RESULTS = 10;
    private static final int RADIO = 250;

    private final ReactApplicationContext reactContext;
    private final Geocoder geocoder;

    public GeocoderModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
        this.geocoder = new Geocoder(reactContext, Locale.getDefault());
    }

    @Override
    public String getName() {
        return "Geocoder";
    }

    @ReactMethod
    public void reverseGeocoding(
            double latitude,
            double longitude,
            Promise promise) {
        List<Address> addressList = new ArrayList<>();
        try {
            addressList = geocoder.getFromLocation(latitude, longitude, MAX_RESULTS);
        } catch (IOException e) {
            promise.reject(e);
        }
        releaseData(addressList, promise);
    }

    @ReactMethod
    public void geocodeAnAddress(
            String name,
            Promise promise) {

        List<Address> addressList = new ArrayList<>();
        try {
            addressList = geocoder.getFromLocationName(name, MAX_RESULTS);
        } catch (IOException e) {
            promise.reject(e);
        }
        releaseData(addressList, promise);
    }

    @ReactMethod
    public void geocodeToAddressAtLocation(
            String name,
            double latitude,
            double longitude,
            Promise promise) {

        double latRadian = Math.toRadians(latitude);

        double degLatKm = 110.574235;
        double degLongKm = 110.572833 * Math.cos(latRadian);

        double deltaLat = (RADIO / 1000D) / degLatKm;
        double deltaLong = (RADIO / 1000D) / degLongKm;

        double SWLat = latitude - deltaLat;
        double SWLong = longitude - deltaLong;

        double NELat = latitude + deltaLat;
        double NELong = longitude + deltaLong;

        geocodeToAddressAtRegion(name, SWLat, SWLong, NELat, NELong, promise);
    }

    @ReactMethod
    public void geocodeToAddressAtRegion(
            String name,
            double latSouthwest,
            double lonSouthwest,
            double latNortheast,
            double lonNortheast,
            Promise promise) {

        List<Address> addressList = new ArrayList<>();
        try {
            addressList = geocoder.getFromLocationName(name, MAX_RESULTS, latSouthwest, lonSouthwest, latNortheast, lonNortheast);
        } catch (IOException e) {
            promise.reject(e);
        }
        releaseData(addressList, promise);
    }

    private void releaseData(List<Address> addresses, Promise promise) {
        WritableArray result = Arguments.createArray();

        for (Address address : addresses) {
            WritableMap addressMap = addressToMap(address);
            result.pushMap(addressMap);
        }

        promise.resolve(result);
    }


    private static final String ADDRESS = "address";
    private static final String THOROUGHFARE = "thoroughfare";
    private static final String SUB_THOROUGHFARE = "sub_thoroughfare";
    private static final String LOCALITY = "locality";
    private static final String SUB_LOCALITY = "sub_locality";
    private static final String ADMIN_AREA = "admin_area";
    private static final String SUB_ADMIN_AREA = "sub_admin_area";
    private static final String POSTAL_CODE = "postal_code";
    private static final String COUNTRY_CODE = "country_code";
    private static final String COUNTRY_NAME = "country_name";
    private static final String LATITUDE = "latitude";
    private static final String LONGITUDE = "longitude";
    private static final String LOCALE = "locale";


    private WritableMap addressToMap(Address address) {
        WritableMap value = Arguments.createMap();
        value.putArray(ADDRESS, address.getAddressLine(0));
        value.putString(THOROUGHFARE, address.getThoroughfare());
        value.putString(SUB_THOROUGHFARE, address.getSubThoroughfare());
        value.putString(LOCALITY, address.getLocality());
        value.putString(SUB_LOCALITY, address.getSubLocality());
        value.putString(ADMIN_AREA, address.getAdminArea());
        value.putString(SUB_ADMIN_AREA, address.getSubAdminArea());
        value.putString(POSTAL_CODE, address.getPostalCode());
        value.putString(COUNTRY_CODE, address.getCountryCode());
        value.putString(COUNTRY_NAME, address.getCountryName());
        
        value.putDouble(LATITUDE, address.getLatitude());
        value.putDouble(LONGITUDE, address.getLongitude());
        value.putString(LOCALE, address.getLocale().getDisplayLanguage());
        return value;
    }

    private WritableArray addressLinesToArray(Address address) {
        int i = 0;
        WritableArray lines = Arguments.createArray();
        while (address.getAddressLine(i) != null) {
            String line = address.getAddressLine(i);
            lines.pushString(line);
            i++;
        }
        return lines;
    }
}
