protoc -Iprotos protos/torreServer.proto --plugin=protoc-gen-dart=c:\Users\thena\AppData\Roaming\Pub\Cache\bin\protoc-gen-dart.bat --dart_out=grpc:ControlTower/ControlTowerServer/lib/src/generated

protoc -Iprotos protos/torreServer.proto --python_out=grpc:Airplane/