# Tarea 2 Sistemas Distribuidos

Ignacio Tampe Palma - 201573514-k
Franco Zalavari Palma - 201573501-8

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
Con esto se iniciará el programa, se solicitará al usuario las distintas características del avión, incluyendo la ip y puerto del avión y las de la torre inicial. Luego se pedira apretar enter para aterrizar el avión creado, luego el avión aterrizará. A continuación, el usuario podrá cargar combustible presionando la tecla "s" en consola, en caso contrario no se pedira cargar combustible. Luego se le pedirá al usuario ingresar la cantidad de pasajeros a bordo. Tras esto, se le solicitará presionar enter para pedir una písta de despegue, para luego ingresar el aeropuerto de destino (nombre). Se verificara si el avion cumple con las reglas, tras lo cual nuevamente se pedira ingresar combustible y pasajeros segun sea requerido (aumento o disminucion de estos). Si se cumplen las reglas, el avión esperará una pista disponible y despegará. Finalmente, se preguntará al usuario si quiere seguir con la ejecución, debe presionar "s" para seguir, o "n" para terminar con la ejecución.

### Pantalla de Información - Go
Para utilizarlo se debe tener instalado [Go](https://golang.org/) y realizar lo siguiente.
En el directorio "InfoScreen" ejecutar:
```bash  
	go get -u google.golang.org/grpc
	go run main.go torreServer.pb.go
```  
Con esto se compilará e iniciará el programa, se solicitará la IP y puerto del servidor de la pantalla y de la torre de control a conectar, con esto se conectará a la torre de control y procederá a mostrar información. No se necesita de más interacción por parte del usuario. 