import { NativeModules } from 'react-native';

const { Geocoder: Native } = NativeModules;

export default Geocoder = {
  reverseGeocoding: ({ latitude, longitude }) =>
    Native.reverseGeocoding(latitude, longitude),
  geocodeAnAddress: (address) =>
    Native.geocodeAnAddress(address),
  geocodeToAddressAtLocation: (address, { latitude, longitude }) =>
    Native.geocodeToAddressAtLocation(address, latitude, longitude)
}