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
        '/towerHost/requestLanding',
        request_serializer=torreServer__pb2.ArrivingPlane.SerializeToString,
        response_deserializer=torreServer__pb2.Runway.FromString,
        )
    self.requestTakeoff = channel.unary_unary(
        '/towerHost/requestTakeoff',
        request_serializer=torreServer__pb2.DepartingPlane.SerializeToString,
        response_deserializer=torreServer__pb2.Runway.FromString,
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
  }
  generic_handler = grpc.method_handlers_generic_handler(
      'towerHost', rpc_method_handlers)
  server.add_generic_rpc_handlers((generic_handler,))


class planeHostStub(object):
  # missing associated documentation comment in .proto file
  pass

  def __init__(self, channel):
    """Constructor.

    Args:
      channel: A grpc.Channel.
    """


class planeHostServicer(object):
  # missing associated documentation comment in .proto file
  pass


def add_planeHostServicer_to_server(servicer, server):
  rpc_method_handlers = {
  }
  generic_handler = grpc.method_handlers_generic_handler(
      'planeHost', rpc_method_handlers)
  server.add_generic_rpc_handlers((generic_handler,))
