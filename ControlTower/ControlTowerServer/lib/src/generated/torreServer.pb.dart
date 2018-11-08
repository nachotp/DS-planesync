///
//  Generated code. Do not modify.
//  source: torreServer.proto
///
// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, override;

import 'package:protobuf/protobuf.dart' as $pb;

class Empty extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('Empty', package: const $pb.PackageName('main'))
    ..hasRequiredFields = false
  ;

  Empty() : super();
  Empty.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Empty.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Empty clone() => new Empty()..mergeFromMessage(this);
  Empty copyWith(void Function(Empty) updates) => super.copyWith((message) => updates(message as Empty));
  $pb.BuilderInfo get info_ => _i;
  static Empty create() => new Empty();
  static $pb.PbList<Empty> createRepeated() => new $pb.PbList<Empty>();
  static Empty getDefault() => _defaultInstance ??= create()..freeze();
  static Empty _defaultInstance;
  static void $checkItem(Empty v) {
    if (v is! Empty) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }
}

class Runway extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('Runway', package: const $pb.PackageName('main'))
    ..a<int>(1, 'runway', $pb.PbFieldType.O3)
    ..aOS(2, 'airportName')
    ..aOS(3, 'preCode')
    ..a<int>(4, 'height', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  Runway() : super();
  Runway.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Runway.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Runway clone() => new Runway()..mergeFromMessage(this);
  Runway copyWith(void Function(Runway) updates) => super.copyWith((message) => updates(message as Runway));
  $pb.BuilderInfo get info_ => _i;
  static Runway create() => new Runway();
  static $pb.PbList<Runway> createRepeated() => new $pb.PbList<Runway>();
  static Runway getDefault() => _defaultInstance ??= create()..freeze();
  static Runway _defaultInstance;
  static void $checkItem(Runway v) {
    if (v is! Runway) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  int get runway => $_get(0, 0);
  set runway(int v) { $_setSignedInt32(0, v); }
  bool hasRunway() => $_has(0);
  void clearRunway() => clearField(1);

  String get airportName => $_getS(1, '');
  set airportName(String v) { $_setString(1, v); }
  bool hasAirportName() => $_has(1);
  void clearAirportName() => clearField(2);

  String get preCode => $_getS(2, '');
  set preCode(String v) { $_setString(2, v); }
  bool hasPreCode() => $_has(2);
  void clearPreCode() => clearField(3);

  int get height => $_get(3, 0);
  set height(int v) { $_setSignedInt32(3, v); }
  bool hasHeight() => $_has(3);
  void clearHeight() => clearField(4);
}

class ArrivingPlane extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('ArrivingPlane', package: const $pb.PackageName('main'))
    ..aOS(1, 'srcAirport')
    ..aOS(2, 'code')
    ..aOS(3, 'ip')
    ..a<int>(4, 'port', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ArrivingPlane() : super();
  ArrivingPlane.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ArrivingPlane.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ArrivingPlane clone() => new ArrivingPlane()..mergeFromMessage(this);
  ArrivingPlane copyWith(void Function(ArrivingPlane) updates) => super.copyWith((message) => updates(message as ArrivingPlane));
  $pb.BuilderInfo get info_ => _i;
  static ArrivingPlane create() => new ArrivingPlane();
  static $pb.PbList<ArrivingPlane> createRepeated() => new $pb.PbList<ArrivingPlane>();
  static ArrivingPlane getDefault() => _defaultInstance ??= create()..freeze();
  static ArrivingPlane _defaultInstance;
  static void $checkItem(ArrivingPlane v) {
    if (v is! ArrivingPlane) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  String get srcAirport => $_getS(0, '');
  set srcAirport(String v) { $_setString(0, v); }
  bool hasSrcAirport() => $_has(0);
  void clearSrcAirport() => clearField(1);

  String get code => $_getS(1, '');
  set code(String v) { $_setString(1, v); }
  bool hasCode() => $_has(1);
  void clearCode() => clearField(2);

  String get ip => $_getS(2, '');
  set ip(String v) { $_setString(2, v); }
  bool hasIp() => $_has(2);
  void clearIp() => clearField(3);

  int get port => $_get(3, 0);
  set port(int v) { $_setSignedInt32(3, v); }
  bool hasPort() => $_has(3);
  void clearPort() => clearField(4);
}

class DepartingPlane extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('DepartingPlane', package: const $pb.PackageName('main'))
    ..aOS(1, 'code')
    ..a<int>(2, 'runway', $pb.PbFieldType.O3)
    ..a<int>(3, 'height', $pb.PbFieldType.O3)
    ..aOS(4, 'airportName')
    ..hasRequiredFields = false
  ;

  DepartingPlane() : super();
  DepartingPlane.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DepartingPlane.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DepartingPlane clone() => new DepartingPlane()..mergeFromMessage(this);
  DepartingPlane copyWith(void Function(DepartingPlane) updates) => super.copyWith((message) => updates(message as DepartingPlane));
  $pb.BuilderInfo get info_ => _i;
  static DepartingPlane create() => new DepartingPlane();
  static $pb.PbList<DepartingPlane> createRepeated() => new $pb.PbList<DepartingPlane>();
  static DepartingPlane getDefault() => _defaultInstance ??= create()..freeze();
  static DepartingPlane _defaultInstance;
  static void $checkItem(DepartingPlane v) {
    if (v is! DepartingPlane) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  String get code => $_getS(0, '');
  set code(String v) { $_setString(0, v); }
  bool hasCode() => $_has(0);
  void clearCode() => clearField(1);

  int get runway => $_get(1, 0);
  set runway(int v) { $_setSignedInt32(1, v); }
  bool hasRunway() => $_has(1);
  void clearRunway() => clearField(2);

  int get height => $_get(2, 0);
  set height(int v) { $_setSignedInt32(2, v); }
  bool hasHeight() => $_has(2);
  void clearHeight() => clearField(3);

  String get airportName => $_getS(3, '');
  set airportName(String v) { $_setString(3, v); }
  bool hasAirportName() => $_has(3);
  void clearAirportName() => clearField(4);
}

class PlaneData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('PlaneData', package: const $pb.PackageName('main'))
    ..aOS(1, 'code')
    ..a<int>(2, 'currFuel', $pb.PbFieldType.O3)
    ..a<int>(3, 'maxFuel', $pb.PbFieldType.O3)
    ..a<int>(4, 'currWeight', $pb.PbFieldType.O3)
    ..a<int>(5, 'maxWeight', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  PlaneData() : super();
  PlaneData.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PlaneData.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PlaneData clone() => new PlaneData()..mergeFromMessage(this);
  PlaneData copyWith(void Function(PlaneData) updates) => super.copyWith((message) => updates(message as PlaneData));
  $pb.BuilderInfo get info_ => _i;
  static PlaneData create() => new PlaneData();
  static $pb.PbList<PlaneData> createRepeated() => new $pb.PbList<PlaneData>();
  static PlaneData getDefault() => _defaultInstance ??= create()..freeze();
  static PlaneData _defaultInstance;
  static void $checkItem(PlaneData v) {
    if (v is! PlaneData) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  String get code => $_getS(0, '');
  set code(String v) { $_setString(0, v); }
  bool hasCode() => $_has(0);
  void clearCode() => clearField(1);

  int get currFuel => $_get(1, 0);
  set currFuel(int v) { $_setSignedInt32(1, v); }
  bool hasCurrFuel() => $_has(1);
  void clearCurrFuel() => clearField(2);

  int get maxFuel => $_get(2, 0);
  set maxFuel(int v) { $_setSignedInt32(2, v); }
  bool hasMaxFuel() => $_has(2);
  void clearMaxFuel() => clearField(3);

  int get currWeight => $_get(3, 0);
  set currWeight(int v) { $_setSignedInt32(3, v); }
  bool hasCurrWeight() => $_has(3);
  void clearCurrWeight() => clearField(4);

  int get maxWeight => $_get(4, 0);
  set maxWeight(int v) { $_setSignedInt32(4, v); }
  bool hasMaxWeight() => $_has(4);
  void clearMaxWeight() => clearField(5);
}

class TakeoffStatus extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('TakeoffStatus', package: const $pb.PackageName('main'))
    ..a<int>(1, 'errorCode', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  TakeoffStatus() : super();
  TakeoffStatus.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TakeoffStatus.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TakeoffStatus clone() => new TakeoffStatus()..mergeFromMessage(this);
  TakeoffStatus copyWith(void Function(TakeoffStatus) updates) => super.copyWith((message) => updates(message as TakeoffStatus));
  $pb.BuilderInfo get info_ => _i;
  static TakeoffStatus create() => new TakeoffStatus();
  static $pb.PbList<TakeoffStatus> createRepeated() => new $pb.PbList<TakeoffStatus>();
  static TakeoffStatus getDefault() => _defaultInstance ??= create()..freeze();
  static TakeoffStatus _defaultInstance;
  static void $checkItem(TakeoffStatus v) {
    if (v is! TakeoffStatus) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  int get errorCode => $_get(0, 0);
  set errorCode(int v) { $_setSignedInt32(0, v); }
  bool hasErrorCode() => $_has(0);
  void clearErrorCode() => clearField(1);
}

class Flight extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('Flight', package: const $pb.PackageName('main'))
    ..aOS(1, 'code')
    ..aOS(2, 'time')
    ..aOS(3, 'airport')
    ..a<int>(4, 'type', $pb.PbFieldType.O3)
    ..a<int>(5, 'runway', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  Flight() : super();
  Flight.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Flight.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Flight clone() => new Flight()..mergeFromMessage(this);
  Flight copyWith(void Function(Flight) updates) => super.copyWith((message) => updates(message as Flight));
  $pb.BuilderInfo get info_ => _i;
  static Flight create() => new Flight();
  static $pb.PbList<Flight> createRepeated() => new $pb.PbList<Flight>();
  static Flight getDefault() => _defaultInstance ??= create()..freeze();
  static Flight _defaultInstance;
  static void $checkItem(Flight v) {
    if (v is! Flight) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  String get code => $_getS(0, '');
  set code(String v) { $_setString(0, v); }
  bool hasCode() => $_has(0);
  void clearCode() => clearField(1);

  String get time => $_getS(1, '');
  set time(String v) { $_setString(1, v); }
  bool hasTime() => $_has(1);
  void clearTime() => clearField(2);

  String get airport => $_getS(2, '');
  set airport(String v) { $_setString(2, v); }
  bool hasAirport() => $_has(2);
  void clearAirport() => clearField(3);

  int get type => $_get(3, 0);
  set type(int v) { $_setSignedInt32(3, v); }
  bool hasType() => $_has(3);
  void clearType() => clearField(4);

  int get runway => $_get(4, 0);
  set runway(int v) { $_setSignedInt32(4, v); }
  bool hasRunway() => $_has(4);
  void clearRunway() => clearField(5);
}

class planeHeight extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('planeHeight', package: const $pb.PackageName('main'))
    ..a<int>(1, 'height', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  planeHeight() : super();
  planeHeight.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  planeHeight.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  planeHeight clone() => new planeHeight()..mergeFromMessage(this);
  planeHeight copyWith(void Function(planeHeight) updates) => super.copyWith((message) => updates(message as planeHeight));
  $pb.BuilderInfo get info_ => _i;
  static planeHeight create() => new planeHeight();
  static $pb.PbList<planeHeight> createRepeated() => new $pb.PbList<planeHeight>();
  static planeHeight getDefault() => _defaultInstance ??= create()..freeze();
  static planeHeight _defaultInstance;
  static void $checkItem(planeHeight v) {
    if (v is! planeHeight) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  int get height => $_get(0, 0);
  set height(int v) { $_setSignedInt32(0, v); }
  bool hasHeight() => $_has(0);
  void clearHeight() => clearField(1);
}

class AirportInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('AirportInfo', package: const $pb.PackageName('main'))
    ..aOS(1, 'ip')
    ..a<int>(2, 'port', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  AirportInfo() : super();
  AirportInfo.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AirportInfo.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AirportInfo clone() => new AirportInfo()..mergeFromMessage(this);
  AirportInfo copyWith(void Function(AirportInfo) updates) => super.copyWith((message) => updates(message as AirportInfo));
  $pb.BuilderInfo get info_ => _i;
  static AirportInfo create() => new AirportInfo();
  static $pb.PbList<AirportInfo> createRepeated() => new $pb.PbList<AirportInfo>();
  static AirportInfo getDefault() => _defaultInstance ??= create()..freeze();
  static AirportInfo _defaultInstance;
  static void $checkItem(AirportInfo v) {
    if (v is! AirportInfo) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  String get ip => $_getS(0, '');
  set ip(String v) { $_setString(0, v); }
  bool hasIp() => $_has(0);
  void clearIp() => clearField(1);

  int get port => $_get(1, 0);
  set port(int v) { $_setSignedInt32(1, v); }
  bool hasPort() => $_has(1);
  void clearPort() => clearField(2);
}

class ScreenInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('ScreenInfo', package: const $pb.PackageName('main'))
    ..aOS(1, 'ip')
    ..a<int>(2, 'port', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ScreenInfo() : super();
  ScreenInfo.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ScreenInfo.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ScreenInfo clone() => new ScreenInfo()..mergeFromMessage(this);
  ScreenInfo copyWith(void Function(ScreenInfo) updates) => super.copyWith((message) => updates(message as ScreenInfo));
  $pb.BuilderInfo get info_ => _i;
  static ScreenInfo create() => new ScreenInfo();
  static $pb.PbList<ScreenInfo> createRepeated() => new $pb.PbList<ScreenInfo>();
  static ScreenInfo getDefault() => _defaultInstance ??= create()..freeze();
  static ScreenInfo _defaultInstance;
  static void $checkItem(ScreenInfo v) {
    if (v is! ScreenInfo) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  String get ip => $_getS(0, '');
  set ip(String v) { $_setString(0, v); }
  bool hasIp() => $_has(0);
  void clearIp() => clearField(1);

  int get port => $_get(1, 0);
  set port(int v) { $_setSignedInt32(1, v); }
  bool hasPort() => $_has(1);
  void clearPort() => clearField(2);
}

class AirportName extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('AirportName', package: const $pb.PackageName('main'))
    ..aOS(1, 'name')
    ..hasRequiredFields = false
  ;

  AirportName() : super();
  AirportName.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AirportName.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AirportName clone() => new AirportName()..mergeFromMessage(this);
  AirportName copyWith(void Function(AirportName) updates) => super.copyWith((message) => updates(message as AirportName));
  $pb.BuilderInfo get info_ => _i;
  static AirportName create() => new AirportName();
  static $pb.PbList<AirportName> createRepeated() => new $pb.PbList<AirportName>();
  static AirportName getDefault() => _defaultInstance ??= create()..freeze();
  static AirportName _defaultInstance;
  static void $checkItem(AirportName v) {
    if (v is! AirportName) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  String get name => $_getS(0, '');
  set name(String v) { $_setString(0, v); }
  bool hasName() => $_has(0);
  void clearName() => clearField(1);
}

