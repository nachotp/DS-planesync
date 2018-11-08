///
//  Generated code. Do not modify.
//  source: torreServer.proto
///
// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import

const Empty$json = const {
  '1': 'Empty',
};

const Runway$json = const {
  '1': 'Runway',
  '2': const [
    const {'1': 'runway', '3': 1, '4': 1, '5': 5, '10': 'runway'},
    const {'1': 'airportName', '3': 2, '4': 1, '5': 9, '10': 'airportName'},
    const {'1': 'preCode', '3': 3, '4': 1, '5': 9, '10': 'preCode'},
    const {'1': 'height', '3': 4, '4': 1, '5': 5, '10': 'height'},
  ],
};

const ArrivingPlane$json = const {
  '1': 'ArrivingPlane',
  '2': const [
    const {'1': 'srcAirport', '3': 1, '4': 1, '5': 9, '10': 'srcAirport'},
    const {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'ip', '3': 3, '4': 1, '5': 9, '10': 'ip'},
    const {'1': 'port', '3': 4, '4': 1, '5': 5, '10': 'port'},
  ],
};

const DepartingPlane$json = const {
  '1': 'DepartingPlane',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'runway', '3': 2, '4': 1, '5': 5, '10': 'runway'},
    const {'1': 'height', '3': 3, '4': 1, '5': 5, '10': 'height'},
    const {'1': 'airportName', '3': 4, '4': 1, '5': 9, '10': 'airportName'},
  ],
};

const PlaneData$json = const {
  '1': 'PlaneData',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'currFuel', '3': 2, '4': 1, '5': 5, '10': 'currFuel'},
    const {'1': 'maxFuel', '3': 3, '4': 1, '5': 5, '10': 'maxFuel'},
    const {'1': 'currWeight', '3': 4, '4': 1, '5': 5, '10': 'currWeight'},
    const {'1': 'maxWeight', '3': 5, '4': 1, '5': 5, '10': 'maxWeight'},
  ],
};

const TakeoffStatus$json = const {
  '1': 'TakeoffStatus',
  '2': const [
    const {'1': 'errorCode', '3': 1, '4': 1, '5': 5, '10': 'errorCode'},
  ],
};

const Flight$json = const {
  '1': 'Flight',
  '2': const [
    const {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    const {'1': 'time', '3': 2, '4': 1, '5': 9, '10': 'time'},
    const {'1': 'airport', '3': 3, '4': 1, '5': 9, '10': 'airport'},
    const {'1': 'type', '3': 4, '4': 1, '5': 5, '10': 'type'},
    const {'1': 'runway', '3': 5, '4': 1, '5': 5, '10': 'runway'},
  ],
};

const planeHeight$json = const {
  '1': 'planeHeight',
  '2': const [
    const {'1': 'height', '3': 1, '4': 1, '5': 5, '10': 'height'},
  ],
};

const AirportInfo$json = const {
  '1': 'AirportInfo',
  '2': const [
    const {'1': 'ip', '3': 1, '4': 1, '5': 9, '10': 'ip'},
    const {'1': 'port', '3': 2, '4': 1, '5': 5, '10': 'port'},
  ],
};

const ScreenInfo$json = const {
  '1': 'ScreenInfo',
  '2': const [
    const {'1': 'ip', '3': 1, '4': 1, '5': 9, '10': 'ip'},
    const {'1': 'port', '3': 2, '4': 1, '5': 5, '10': 'port'},
  ],
};

