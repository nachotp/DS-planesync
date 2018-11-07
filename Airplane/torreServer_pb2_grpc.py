# Generated by the gRPC Python protocol compiler plugin. DO NOT EDIT!
import grpc

import torreServer_pb2 as torreServer__pb2


class towerHostStub(object):
  # missing associated documentation comment in .proto file
  pass

  def __init__(self, channel):
    """Constructor.

    Args:
      channel: A grpc.Channel.
    """
    self.requestLanding = channel.unary_unary(
        '/main.towerHost/requestLanding',
        request_serializer=torreServer__pb2.ArrivingPlane.SerializeToString,
        response_deserializer=torreServer__pb2.Runway.FromString,
        )
    self.requestTakeoff = channel.unary_unary(
        '/main.towerHost/requestTakeoff',
        request_serializer=torreServer__pb2.DepartingPlane.SerializeToString,
        response_deserializer=torreServer__pb2.Runway.FromString,
        )
    self.checkTakeoff = channel.unary_unary(
        '/main.towerHost/checkTakeoff',
        request_serializer=torreServer__pb2.PlaneData.SerializeToString,
        response_deserializer=torreServer__pb2.TakeoffStatus.FromString,
        )
    self.takeoff = channel.unary_unary(
        '/main.towerHost/takeoff',
        request_serializer=torreServer__pb2.DepartingPlane.SerializeToString,
        response_deserializer=torreServer__pb2.AirportInfo.FromString,
        )
    self.screenConnect = channel.unary_unary(
        '/main.towerHost/screenConnect',
        request_serializer=torreServer__pb2.ScreenInfo.SerializeToString,
        response_deserializer=torreServer__pb2.Empty.FromString,
        )


class towerHostServicer(object):
  # missing associated documentation comment in .proto file
  pass

  def requestLanding(self, request, context):
    # missing associated documentation comment in .proto file
    pass
    context.set_code(grpc.StatusCode.UNIMPLEMENTED)
    context.set_details('Method not implemented!')
    raise NotImplementedError('Method not implemented!')

  def requestTakeoff(self, request, context):
    # missing associated documentation comment in .proto file
    pass
    context.set_code(grpc.StatusCode.UNIMPLEMENTED)
    context.set_details('Method not implemented!')
    raise NotImplementedError('Method not implemented!')

  def checkTakeoff(self, request, context):
    # missing associated documentation comment in .proto file
    pass
    context.set_code(grpc.StatusCode.UNIMPLEMENTED)
    context.set_details('Method not implemented!')
    raise NotImplementedError('Method not implemented!')

  def takeoff(self, request, context):
    # missing associated documentation comment in .proto file
    pass
    context.set_code(grpc.StatusCode.UNIMPLEMENTED)
    context.set_details('Method not implemented!')
    raise NotImplementedError('Method not implemented!')

  def screenConnect(self, request, context):
    # missing associated documentation comment in .proto file
    pass
    context.set_code(grpc.StatusCode.UNIMPLEMENTED)
    context.set_details('Method not implemented!')
    raise NotImplementedError('Method not implemented!')


def add_towerHostServicer_to_server(servicer, server):
  rpc_method_handlers = {
      'requestLanding': grpc.unary_unary_rpc_method_handler(
          servicer.requestLanding,
          request_deserializer=torreServer__pb2.ArrivingPlane.FromString,
          response_serializer=torreServer__pb2.Runway.SerializeToString,
      ),
      'requestTakeoff': grpc.unary_unary_rpc_method_handler(
          servicer.requestTakeoff,
          request_deserializer=torreServer__pb2.DepartingPlane.FromString,
          response_serializer=torreServer__pb2.Runway.SerializeToString,
      ),
      'checkTakeoff': grpc.unary_unary_rpc_method_handler(
          servicer.checkTakeoff,
          request_deserializer=torreServer__pb2.PlaneData.FromString,
          response_serializer=torreServer__pb2.TakeoffStatus.SerializeToString,
      ),
      'takeoff': grpc.unary_unary_rpc_method_handler(
          servicer.takeoff,
          request_deserializer=torreServer__pb2.DepartingPlane.FromString,
          response_serializer=torreServer__pb2.AirportInfo.SerializeToString,
      ),
      'screenConnect': grpc.unary_unary_rpc_method_handler(
          servicer.screenConnect,
          request_deserializer=torreServer__pb2.ScreenInfo.FromString,
          response_serializer=torreServer__pb2.Empty.SerializeToString,
      ),
  }
  generic_handler = grpc.method_handlers_generic_handler(
      'main.towerHost', rpc_method_handlers)
  server.add_generic_rpc_handlers((generic_handler,))


class planeHostStub(object):
  # missing associated documentation comment in .proto file
  pass

  def __init__(self, channel):
    """Constructor.

    Args:
      channel: A grpc.Channel.
    """
    self.notifyLanding = channel.unary_unary(
        '/main.planeHost/notifyLanding',
        request_serializer=torreServer__pb2.Runway.SerializeToString,
        response_deserializer=torreServer__pb2.planeHeight.FromString,
        )
    self.notifyDeparture = channel.unary_unary(
        '/main.planeHost/notifyDeparture',
        request_serializer=torreServer__pb2.Runway.SerializeToString,
        response_deserializer=torreServer__pb2.Empty.FromString,
        )


class planeHostServicer(object):
  # missing associated documentation comment in .proto file
  pass

  def notifyLanding(self, request, context):
    # missing associated documentation comment in .proto file
    pass
    context.set_code(grpc.StatusCode.UNIMPLEMENTED)
    context.set_details('Method not implemented!')
    raise NotImplementedError('Method not implemented!')

  def notifyDeparture(self, request, context):
    # missing associated documentation comment in .proto file
    pass
    context.set_code(grpc.StatusCode.UNIMPLEMENTED)
    context.set_details('Method not implemented!')
    raise NotImplementedError('Method not implemented!')


def add_planeHostServicer_to_server(servicer, server):
  rpc_method_handlers = {
      'notifyLanding': grpc.unary_unary_rpc_method_handler(
          servicer.notifyLanding,
          request_deserializer=torreServer__pb2.Runway.FromString,
          response_serializer=torreServer__pb2.planeHeight.SerializeToString,
      ),
      'notifyDeparture': grpc.unary_unary_rpc_method_handler(
          servicer.notifyDeparture,
          request_deserializer=torreServer__pb2.Runway.FromString,
          response_serializer=torreServer__pb2.Empty.SerializeToString,
      ),
  }
  generic_handler = grpc.method_handlers_generic_handler(
      'main.planeHost', rpc_method_handlers)
  server.add_generic_rpc_handlers((generic_handler,))


class screenHostStub(object):
  # missing associated documentation comment in .proto file
  pass

  def __init__(self, channel):
    """Constructor.

    Args:
      channel: A grpc.Channel.
    """
    self.listFlights = channel.stream_unary(
        '/main.screenHost/listFlights',
        request_serializer=torreServer__pb2.Flight.SerializeToString,
        response_deserializer=torreServer__pb2.Empty.FromString,
        )


class screenHostServicer(object):
  # missing associated documentation comment in .proto file
  pass

  def listFlights(self, request_iterator, context):
    # missing associated documentation comment in .proto file
    pass
    context.set_code(grpc.StatusCode.UNIMPLEMENTED)
    context.set_details('Method not implemented!')
    raise NotImplementedError('Method not implemented!')


def add_screenHostServicer_to_server(servicer, server):
  rpc_method_handlers = {
      'listFlights': grpc.stream_unary_rpc_method_handler(
          servicer.listFlights,
          request_deserializer=torreServer__pb2.Flight.FromString,
          response_serializer=torreServer__pb2.Empty.SerializeToString,
      ),
  }
  generic_handler = grpc.method_handlers_generic_handler(
      'main.screenHost', rpc_method_handlers)
  server.add_generic_rpc_handlers((generic_handler,))
