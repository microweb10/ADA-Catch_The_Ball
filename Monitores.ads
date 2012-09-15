package Monitores is


     -- Inicializar cuadricula
     procedure Inicializar;
     
     -- Calcular posicion inicial de la Prey 
     procedure Inicializar_Pos_Prey;
     procedure Inicializar_Pos_Predator(X, Y: in out integer; tipo: in integer);
     
     -- Reservar una posicion 
     procedure Reservar_Prey(Actual_X, Actual_Y, Nueva_X, Nueva_Y: Integer; Exito: in out Boolean);
     procedure Reservar_Predator(Actual_X, Actual_Y, Nueva_X, Nueva_Y: Integer; Exito: in out Boolean);

     -- Calcular nueva posicion de la Prey
     procedure Nueva_Posicion_Prey(X, Y: in out Integer);
     -- Calcular nueva posicion del Predator
     procedure Nueva_Posicion_Predator(X, Y: in out Integer ; tipo: in Integer);
    
     -- Obtener posicion inicial de la prey  
     function Leer_PosX_Inicial_Prey return integer;
     function Leer_PosY_Inicial_Prey return integer;
    
     -- Devuelver la anchura y altura de la cuadrícula
     function Leer_Ancho return integer;
     function Leer_Alto return integer;
     
     -- ¿Esta libre una casilla?
     function Casilla_Libre(X, Y: integer) return boolean;
     
     -- Notificar el final de una prey
     procedure Fin_Prey;
     
     -- nos dice si una presa ya esta capturada
     function Prey_Capturada return Boolean;
     
     -- evita un obstaculo
     procedure Evitar_Obstaculo(X, Y: Integer; incX, incY: in out Integer);
     
     -- calcula el retardo de las tareas presa y predator
     function Calcula_Retardo return float;
     
     -- devuelve un retardo aleatorio entre 0.1 y 1 segundos
     procedure Retardo_Aleatorio(X: in out float);
     
     -- pide al usuario el numero de presas a capturar
     function Cuantas_Presas return integer;
     
           
end Monitores;