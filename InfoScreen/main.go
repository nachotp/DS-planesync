/*
 *
 * Copyright 2015 gRPC authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

//go:generate protoc -I ../helloworld --go_out=plugins=grpc:../helloworld ../helloworld/helloworld.proto

package main

import (
	"fmt"
	"io"
	"log"
	"net"
	"time"

	"golang.org/x/net/context"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

// server is used to implement helloworld.GreeterServer.
type server struct{}

func (s *server) ListFlights(stream ScreenHost_ListFlightsServer) error {
	var i int
	i = 0
	for {
		flight, err := stream.Recv()
		if err == io.EOF {
			return stream.SendMsg(&Empty{})
		}
		fmt.Printf("Vuelo %x\n", i)
		i++
		fmt.Printf("%s\n", flight.Code)

	}
}

func main() {
	var port, twPort int32
	var ip, twIP string
	fmt.Print("Ingrese ip de la pantalla: ")
	fmt.Scan(&ip)
	fmt.Print("Ingrese puerto de la pantalla: ")
	fmt.Scan(&port)
	fmt.Print("Ingrese ip de la torre de control: ")
	fmt.Scan(&twIP)
	fmt.Print("Ingrese puerto de la torre de control: ")
	fmt.Scan(&twPort)
	fmt.Print("\n")

	conn, _ := grpc.Dial(fmt.Sprintf("%s:%d", twIP, twPort), grpc.WithInsecure())
	c := NewTowerHostClient(conn)
	ctx, _ := context.WithTimeout(context.Background(), time.Second)
	c.ScreenConnect(ctx, &ScreenInfo{Ip: ip, Port: port})
	lis, err := net.Listen("tcp", fmt.Sprintf("0.0.0.0:%d", port))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()

	RegisterScreenHostServer(s, &server{})
	// Register reflection service on gRPC server.
	reflection.Register(s)
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
