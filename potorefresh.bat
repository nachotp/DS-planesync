protoc -Iprotos protos/torreServer.proto --plugin=protoc-gen-dart=%APPDATA%\Pub\Cache\bin\protoc-gen-dart.bat --dart_out=grpc:ControlTower/ControlTowerServer/lib/src/generated
