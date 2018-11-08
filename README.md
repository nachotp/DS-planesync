# Tarea 2 Sistemas Distribuidos
  
## Ambiente y ejecución:  
El sistema está implementado en Python 3, Go y Dart.  

### Torre de Control - Dart
Para utilizarlo se debe tener instalado [Dart](https://www.dartlang.org/) y realizar lo siguiente.
En el directorio "ControlTower/ControlTowerServer" ejecutar:
```bash  
    pub get
    dart bin/server.dart
```  
Con esto se compilará e iniciará el programa, se solicitará la IP y puerto del servidor, luego se mientras no se envíe "x" a la consola, se podrán agregar el resto de los aeropuertos con su nombre, ip y puerto respectivo.

Tras esto, el aeropuerto dará un mensaje de éxito y ejecutará sin necesidad de intervención por consola.

### Avión - Python 3
Para utilizarlo se debe tener instalado [Python](https://www.python.org/) y realizar lo siguiente.
En el directorio "Airplane" ejecutar:
(Usar pip en windows, pip3 en Unix)
```bash  
    pip install grpcio
    python avion.py
```  

### Pantalla de Información - Go
Para utilizarlo se debe tener instalado [Go](https://golang.org/) y realizar lo siguiente.
En el directorio "InfoScreen" ejecutar:
```bash  
	go get -u google.golang.org/grpc
	go run main.go torreServer.pb.go
```  
Con esto se compilará e iniciará el programa, se solicitará la IP y puerto del servidor de la pantalla y de la torre de control a conectar, con esto se conectará a la torre de control y procederá a mostrar información. No se necesita de más interacción por parte del usuario. 