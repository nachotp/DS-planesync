# Protocolos RFC

## Avion - Torre de Control
La interacción actúa principalmente como Torre de Control como el servidor y Avión como clientes.

Las funciones son:
```
rpc requestLanding(ArrivingPlane) returns (Runway)
rpc requestTakeoff(DepartingPlane) returns (Runway)
rpc checkTakeoff(PlaneData) returns (TakeoffStatus)
rpc takeoff (DepartingPlane) returns (AirportInfo)


rpc notifyLanding(Runway) returns (planeHeight)
rpc notifyDeparture(Runway) returns (Empty)
```
**requestLanding**: Un avión que va a aterrizar envía sus datos para solicitar una pista de aterrizaje y la torre le retorna una pista disponible junto con datos del aeropuerto.
**requestTakeoff**: Un avión que quiere despegar solicita una pista de despegue la cual puede ser asignada o es encolado, se le entrega la pista asignada o "-1" si no hay disponibles.
**checkTakeoff**: El avión envía sus datos de peso y combustible para que la torre revise y apruebe la solicitud, caso contrario se envía un código de error.
**takeoff**: EL avión notifica que va a despegar y se desconecta del servidor, recibe la ip y puerto del servidor que quiere conectarse.
**notifyLanding**: El avión es avisado que puede aterrizar ya que hay pistas disponibles, recibe la pista a la cual aterrizará.
**notifyDeparture**: El avión es avisado que puede ir a una pista de despegue ya que hay pistas disponibles, recibe la pista desde la cual despegará.

## Torre de Control - Pantalla de Información
```
rpc screenConnect(ScreenInfo) returns (AirportName)
rpc listFlights(stream Flight) returns (Empty)
```
**screenConnect**: La pantalla envía su IP y puerto para que la torre de control se conecte a ella y recibe el nombre del aeropuerto.
**listFlights**: La torre envía un stream con todos los vuelos actualmente en el sistema para desplegarlos.