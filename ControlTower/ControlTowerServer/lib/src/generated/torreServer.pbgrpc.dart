///
//  Generated code. Do not modify.
//  source: torreServer.proto
///
// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import

import 'dart:async' as $async;

import 'package:grpc/grpc.dart';

import 'torreServer.pb.dart';
export 'torreServer.pb.dart';

class towerHostClient extends Client {
  static final _$requestLanding = new ClientMethod<ArrivingPlane, Runway>(
      '/main.towerHost/requestLanding',
      (ArrivingPlane value) => value.writeToBuffer(),
      (List<int> value) => new Runway.fromBuffer(value));
  static final _$requestTakeoff = new ClientMethod<DepartingPlane, Runway>(
      '/main.towerHost/requestTakeoff',
      (DepartingPlane value) => value.writeToBuffer(),
      (List<int> value) => new Runway.fromBuffer(value));
  static final _$checkTakeoff = new ClientMethod<PlaneData, TakeoffStatus>(
      '/main.towerHost/checkTakeoff',
      (PlaneData value) => value.writeToBuffer(),
      (List<int> value) => new TakeoffStatus.fromBuffer(value));
  static final _$takeoff = new ClientMethod<DepartingPlane, AirportInfo>(
      '/main.towerHost/takeoff',
      (DepartingPlane value) => value.writeToBuffer(),
      (List<int> value) => new AirportInfo.fromBuffer(value));
  static final _$screenConnect = new ClientMethod<ScreenInfo, AirportName>(
      '/main.towerHost/screenConnect',
      (ScreenInfo value) => value.writeToBuffer(),
      (List<int> value) => new AirportName.fromBuffer(value));

  towerHostClient(ClientChannel channel, {CallOptions options})
      : super(channel, options: options);

  ResponseFuture<Runway> requestLanding(ArrivingPlane request,
      {CallOptions options}) {
    final call = $createCall(
        _$requestLanding, new $async.Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }

  ResponseFuture<Runway> requestTakeoff(DepartingPlane request,
      {CallOptions options}) {
    final call = $createCall(
        _$requestTakeoff, new $async.Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }

  ResponseFuture<TakeoffStatus> checkTakeoff(PlaneData request,
      {CallOptions options}) {
    final call = $createCall(
        _$checkTakeoff, new $async.Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }

  ResponseFuture<AirportInfo> takeoff(DepartingPlane request,
      {CallOptions options}) {
    final call = $createCall(
        _$takeoff, new $async.Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }

  ResponseFuture<AirportName> screenConnect(ScreenInfo request,
      {CallOptions options}) {
    final call = $createCall(
        _$screenConnect, new $async.Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }
}

abstract class towerHostServiceBase extends Service {
  String get $name => 'main.towerHost';

  towerHostServiceBase() {
    $addMethod(new ServiceMethod<ArrivingPlane, Runway>(
        'requestLanding',
        requestLanding_Pre,
        false,
        false,
        (List<int> value) => new ArrivingPlane.fromBuffer(value),
        (Runway value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<DepartingPlane, Runway>(
        'requestTakeoff',
        requestTakeoff_Pre,
        false,
        false,
        (List<int> value) => new DepartingPlane.fromBuffer(value),
        (Runway value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<PlaneData, TakeoffStatus>(
        'checkTakeoff',
        checkTakeoff_Pre,
        false,
        false,
        (List<int> value) => new PlaneData.fromBuffer(value),
        (TakeoffStatus value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<DepartingPlane, AirportInfo>(
        'takeoff',
        takeoff_Pre,
        false,
        false,
        (List<int> value) => new DepartingPlane.fromBuffer(value),
        (AirportInfo value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<ScreenInfo, AirportName>(
        'screenConnect',
        screenConnect_Pre,
        false,
        false,
        (List<int> value) => new ScreenInfo.fromBuffer(value),
        (AirportName value) => value.writeToBuffer()));
  }

  $async.Future<Runway> requestLanding_Pre(
      ServiceCall call, $async.Future request) async {
    return requestLanding(call, await request);
  }

  $async.Future<Runway> requestTakeoff_Pre(
      ServiceCall call, $async.Future request) async {
    return requestTakeoff(call, await request);
  }

  $async.Future<TakeoffStatus> checkTakeoff_Pre(
      ServiceCall call, $async.Future request) async {
    return checkTakeoff(call, await request);
  }

  $async.Future<AirportInfo> takeoff_Pre(
      ServiceCall call, $async.Future request) async {
    return takeoff(call, await request);
  }

  $async.Future<AirportName> screenConnect_Pre(
      ServiceCall call, $async.Future request) async {
    return screenConnect(call, await request);
  }

  $async.Future<Runway> requestLanding(ServiceCall call, ArrivingPlane request);
  $async.Future<Runway> requestTakeoff(
      ServiceCall call, DepartingPlane request);
  $async.Future<TakeoffStatus> checkTakeoff(
      ServiceCall call, PlaneData request);
  $async.Future<AirportInfo> takeoff(ServiceCall call, DepartingPlane request);
  $async.Future<AirportName> screenConnect(
      ServiceCall call, ScreenInfo request);
}

class planeHostClient extends Client {
  static final _$notifyLanding = new ClientMethod<Runway, planeHeight>(
      '/main.planeHost/notifyLanding',
      (Runway value) => value.writeToBuffer(),
      (List<int> value) => new planeHeight.fromBuffer(value));
  static final _$notifyDeparture = new ClientMethod<Runway, Empty>(
      '/main.planeHost/notifyDeparture',
      (Runway value) => value.writeToBuffer(),
      (List<int> value) => new Empty.fromBuffer(value));

  planeHostClient(ClientChannel channel, {CallOptions options})
      : super(channel, options: options);

  ResponseFuture<planeHeight> notifyLanding(Runway request,
      {CallOptions options}) {
    final call = $createCall(
        _$notifyLanding, new $async.Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }

  ResponseFuture<Empty> notifyDeparture(Runway request, {CallOptions options}) {
    final call = $createCall(
        _$notifyDeparture, new $async.Stream.fromIterable([request]),
        options: options);
    return new ResponseFuture(call);
  }
}

abstract class planeHostServiceBase extends Service {
  String get $name => 'main.planeHost';

  planeHostServiceBase() {
    $addMethod(new ServiceMethod<Runway, planeHeight>(
        'notifyLanding',
        notifyLanding_Pre,
        false,
        false,
        (List<int> value) => new Runway.fromBuffer(value),
        (planeHeight value) => value.writeToBuffer()));
    $addMethod(new ServiceMethod<Runway, Empty>(
        'notifyDeparture',
        notifyDeparture_Pre,
        false,
        false,
        (List<int> value) => new Runway.fromBuffer(value),
        (Empty value) => value.writeToBuffer()));
  }

  $async.Future<planeHeight> notifyLanding_Pre(
      ServiceCall call, $async.Future request) async {
    return notifyLanding(call, await request);
  }

  $async.Future<Empty> notifyDeparture_Pre(
      ServiceCall call, $async.Future request) async {
    return notifyDeparture(call, await request);
  }

  $async.Future<planeHeight> notifyLanding(ServiceCall call, Runway request);
  $async.Future<Empty> notifyDeparture(ServiceCall call, Runway request);
}

class screenHostClient extends Client {
  static final _$listFlights = new ClientMethod<Flight, Empty>(
      '/main.screenHost/listFlights',
      (Flight value) => value.writeToBuffer(),
      (List<int> value) => new Empty.fromBuffer(value));

  screenHostClient(ClientChannel channel, {CallOptions options})
      : super(channel, options: options);

  ResponseFuture<Empty> listFlights($async.Stream<Flight> request,
      {CallOptions options}) {
    final call = $createCall(_$listFlights, request, options: options);
    return new ResponseFuture(call);
  }
}

abstract class screenHostServiceBase extends Service {
  String get $name => 'main.screenHost';

  screenHostServiceBase() {
    $addMethod(new ServiceMethod<Flight, Empty>(
        'listFlights',
        listFlights,
        true,
        false,
        (List<int> value) => new Flight.fromBuffer(value),
        (Empty value) => value.writeToBuffer()));
  }

  $async.Future<Empty> listFlights(
      ServiceCall call, $async.Stream<Flight> request);
}
