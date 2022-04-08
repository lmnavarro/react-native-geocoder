declare namespace Geocoder {

  interface LatLng {
    latitude: number;
    longitude: number;
  }

  interface Address extends LatLng {
    address: string;
    thoroughfare?: string;
    sub_thoroughfare?: string;
    locality?: string;
    sub_locality?: string;
    admin_area?: string;
    sub_admin_area?: string;
    postal_code?: string;
    country_code?: string;
    country_name?: string;
    locale?: string;
  }

  function reverseGeocoding(coordinate: LatLng): Promise<Address[]>;

  function geocodeAnAddress(address: string): Promise<Address[]>;

  function geocodeToAddressAtLocation(address: string, coordinate: LatLng): Promise<Address[]>;
  
}

declare module 'react-native-geocoder' {
  export default Geocoder;
}
