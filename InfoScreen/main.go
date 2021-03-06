package main

import (
	"fmt"
	"io"
	"log"
	"net"
	"os"
	"text/tabwriter"
	"time"

	"golang.org/x/net/context"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

type server struct{
	airportName string
}

func (s *server) ListFlights(stream ScreenHost_ListFlightsServer) error { // funcion encargada de imprimir los vuelos en pantalla
	w := new(tabwriter.Writer) // crear un tabwriter : una especie de tabla
	w.Init(os.Stdout, 5, 0, 1, ' ', tabwriter.TabIndent) // inicializarlo
	fmt.Printf("[Pantalla de información - %s]\n", s.airportName)
	fmt.Fprintln(w, "Departures\t\t\t\t|	Arrivals\t\t\t\t")
	fmt.Fprintln(w, "-----------\t\t\t\t|	---------\t\t\t\t")
	fmt.Fprintln(w, "Avión\tDestino\tPista\tHora\t|	Avión\tProveniente\tPista\tHora")
	for {
		flight, err := stream.Recv() //recibir los vuelos
		if err == io.EOF { // mientras haya stream no se hace esto
			w.Flush()
			fmt.Print("\n---------------------------------------------------------------\n")
			return stream.SendMsg(&Empty{})
		}
		if flight.Type == 1 { // si son aviones que van saliendo
			s := fmt.Sprintf("%s\t%s\t%d\t%s\t|	-\t-\t-\t-", flight.Code, flight.Airport, flight.Runway, flight.Time)
			fmt.Fprintln(w, s)
		} else { // si son aviones que van llegando
			s := fmt.Sprintf("-\t-\t-\t-\t|	%s\t%s\t%d\t%s", flight.Code, flight.Airport , flight.Runway, flight.Time)
			fmt.Fprintln(w, s)
		}
	}
}

func main() {
	var port, twPort int32
	var ip, twIP string
	var aeropuerto *AirportName
	// ingresar ips y puertos
	fmt.Print("Ingrese ip de la pantalla: ")
	fmt.Scan(&ip)
	fmt.Print("Ingrese puerto de la pantalla: ")
	fmt.Scan(&port)
	fmt.Print("Ingrese ip de la torre de control: ")
	fmt.Scan(&twIP)
	fmt.Print("Ingrese puerto de la torre de control: ")
	fmt.Scan(&twPort)
	fmt.Print("\n")

	conn, err := grpc.Dial(fmt.Sprintf("%s:%d", twIP, twPort), grpc.WithInsecure()) 
	c := NewTowerHostClient(conn)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	ctx, _ := context.WithTimeout(context.Background(), 60*time.Second)
	aeropuerto, err = c.ScreenConnect(ctx, &ScreenInfo{Ip: ip, Port: port})
	lis, err := net.Listen("tcp", fmt.Sprintf("0.0.0.0:%d", port))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()

	RegisterScreenHostServer(s, &server{aeropuerto.Name})
	reflection.Register(s)
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
