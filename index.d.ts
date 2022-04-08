export interface LatLng {
  latitude: number;
  longitude: number;
}

export interface Address extends LatLng {
  name: string;
  thoroughfare?: string;
  subThoroughfare?: string;
  locality?: string;
  subLocality?: string;
  administrativeArea?: string;
  subAdministrativeArea?: string;
  postalCode?: string;
  countryCode?: string;
  country?: string;
}

declare namespace Geocoder {

  function reverseGeocoding(coordinate: LatLng): Promise<Address[]>;

  function geocodeAnAddress(address: string): Promise<Address[]>;

  function geocodeToAddressAtLocation(address: string, coordinate: LatLng): Promise<Address[]>;
  
}

declare module 'react-native-geocoder' {
  export default Geocoder;
}
