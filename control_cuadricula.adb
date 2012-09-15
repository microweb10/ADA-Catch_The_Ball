with AdaGraph;
with Ada.Numerics.Discrete_Random;
with Visor_Cuadricula;


package body Control_Cuadricula is

  Color_Prey     : AdaGraph.Color_Type := AdaGraph.Light_Green;
  Color_Fondo    : AdaGraph.Color_Type := AdaGraph.White;
  Color_Predator : AdaGraph.Color_Type := AdaGraph.Light_Blue;
     
     
     -- devuelve el ancho (numero de columnas) de la cuadricula 
     function Leer_Ancho return Integer is
     begin
        return Ancho_Cuadricula;
     end;


     -- devuelve el alto (numero de filas) de la cuadricula
     function Leer_Alto return Integer is
     begin
        return Alto_Cuadricula;
     end;
     
   protected body datos_Cuadricula is
     -- devuelve la coordenada X de la prey (Inicial) 
     function Leer_PosX_Inicial_Prey return Integer is
     begin
        return PosX_Inicial_Prey;
     end;


     -- devuelve la coordenada Y de la prey (Inicial)      
     function Leer_PosY_Inicial_Prey return Integer is
     begin
        return PosY_Inicial_Prey;
     end;


     -- devuelve la coordenada X de la prey (Actual)
     function Leer_PosX_Actual_Prey return Integer is
     begin
        return PosX_Actual_Prey;
     end;


     -- devuelve la coordenada Y de la prey (Actual)
     function Leer_PosY_Actual_Prey return Integer is
     begin
        return PosY_Actual_Prey;
     end;
  
  
     -- inicializa el grafico de la cuadricula
     procedure Inicializar is
     begin
        for X in 1..Ancho_Cuadricula loop
           for Y in 1..Alto_Cuadricula loop
              Matriz(X,Y) := Libre;
           end loop;
        end loop;      
     end;


     -- nos dice si una casilla esta libre u ocupada  
     function Casilla_Libre (X, Y: Integer) return Boolean is
     begin
        if (X < 1) OR (X > Leer_Ancho) OR (Y < 1) OR (Y > Leer_Alto) then
           return false;
        else
           return (Matriz(X, Y) = Libre);
        end if;
     end;
     
     
     -- ocupa una casilla con una prey
     procedure Prey_Ocupa_Casilla (actual_X, actual_Y, nueva_X, nueva_Y: Integer; exito: in out Boolean) is
     begin
        if(Matriz(nueva_X,nueva_Y)=Libre) then
           PosX_Actual_Prey := nueva_X;
           PosY_Actual_Prey := nueva_Y;
           Matriz(actual_X,actual_Y):=Libre;
           Pintar(actual_X, actual_Y, Color_Fondo);
           Pintar(nueva_X, nueva_Y, Color_Prey);
           Matriz(nueva_X,nueva_Y):=Ocupada;
           exito := true;
        else
           exito := false;
        end if;
     end;
     
     
     -- ocupa una casilla con un predator
     procedure Predator_Ocupa_Casilla (actual_X, actual_Y, nueva_X, nueva_Y: Integer; exito: in out Boolean) is
     begin
        if(Matriz(nueva_X,nueva_Y)=Libre) then
           Matriz(actual_X,actual_Y):=Libre;
           Pintar(actual_X, actual_Y, Color_Fondo);
           Pintar(nueva_X, nueva_Y, Color_Predator);
           Matriz(nueva_X,nueva_Y):=Ocupada;
           exito := true;
        else
           exito := false;
        end if;
        
     end;


     -- pinta una casilla con un color
     procedure Pintar(X, Y: integer; Color: AdaGraph.Color_Type) is
     begin
        Visor_Cuadricula.Ocupar(X, Y, Color);
     end;


     -- inicializa la posicion de la presa
     procedure Posicion_Inicial_Prey is
        subtype Rango_Aleatorio_PosX_Inicial_Prey is Integer range 1..Ancho_Cuadricula;
        package Numeros_Aleatorios_PosX_Inicial_Prey is
                new Ada.Numerics.Discrete_Random(Rango_Aleatorio_PosX_Inicial_Prey);
        Generador_PosX_Inicial_Prey: Numeros_Aleatorios_PosX_Inicial_Prey.Generator;

        subtype Rango_Aleatorio_PosY_Inicial_Prey is Integer range 1..Alto_Cuadricula;
        package Numeros_Aleatorios_PosY_Inicial_Prey is
                new Ada.Numerics.Discrete_Random(Rango_Aleatorio_PosY_Inicial_Prey);
        Generador_PosY_Inicial_Prey: Numeros_Aleatorios_PosY_Inicial_Prey.Generator;

     begin
        loop
           Numeros_Aleatorios_PosX_Inicial_Prey.Reset(Generador_PosX_Inicial_Prey);
           Numeros_Aleatorios_PosY_Inicial_Prey.Reset(Generador_PosY_Inicial_Prey);

           PosX_Inicial_Prey := Numeros_Aleatorios_PosX_Inicial_Prey.Random(Generador_PosX_Inicial_Prey);
           PosY_Inicial_Prey := Numeros_Aleatorios_PosY_Inicial_Prey.Random(Generador_PosY_Inicial_Prey);
           
           exit when Casilla_Libre(PosX_Inicial_Prey, PosY_Inicial_Prey);
        end loop;
  
     end Posicion_Inicial_Prey;          
 
 
     -- inicializa la posicion de los predator
     procedure Posicion_Inicial_Predator(X, Y: in out integer; tipo: in integer) is
        subtype Rango_Aleatorio_PosX_Inicial_Predator is Integer range 1..Ancho_Cuadricula;
        package Numeros_Aleatorios_PosX_Inicial_Predator is
                new Ada.Numerics.Discrete_Random(Rango_Aleatorio_PosX_Inicial_Predator);
        Generador_PosX_Inicial_Predator: Numeros_Aleatorios_PosX_Inicial_Predator.Generator;

        subtype Rango_Aleatorio_PosY_Inicial_Predator is Integer range 1..Alto_Cuadricula;
        package Numeros_Aleatorios_PosY_Inicial_Predator is
                new Ada.Numerics.Discrete_Random(Rango_Aleatorio_PosY_Inicial_Predator);
        Generador_PosY_Inicial_Predator: Numeros_Aleatorios_PosY_Inicial_Predator.Generator;

     begin
        
        if(tipo=1) then --si es un predator izquierda
           X := 1;
           loop
              Numeros_Aleatorios_PosY_Inicial_Predator.Reset(Generador_PosY_Inicial_Predator);
              Y := Numeros_Aleatorios_PosY_Inicial_Predator.Random(Generador_PosY_Inicial_Predator);
           
              exit when Casilla_Libre(X,Y);
           end loop;
        end if;
        
        if(tipo=3) then --si es un predator derecha
           X := Leer_Ancho;
           loop
              Numeros_Aleatorios_PosY_Inicial_Predator.Reset(Generador_PosY_Inicial_Predator);
              Y := Numeros_Aleatorios_PosY_Inicial_Predator.Random(Generador_PosY_Inicial_Predator);
           
              exit when Casilla_Libre(X,Y);
           end loop;
        end if;
        
        if(tipo=2) then --si es un predator arriba
           Y := Leer_Alto;
           loop
              Numeros_Aleatorios_PosX_Inicial_Predator.Reset(Generador_PosX_Inicial_Predator);
              X := Numeros_Aleatorios_PosX_Inicial_Predator.Random(Generador_PosX_Inicial_Predator);
                         
              exit when Casilla_Libre(X,Y);
           end loop;
        end if;
        
        if(tipo=4) then --si es un predator abajo
           Y := 1;
           loop
              Numeros_Aleatorios_PosX_Inicial_Predator.Reset(Generador_PosX_Inicial_Predator);
              X := Numeros_Aleatorios_PosX_Inicial_Predator.Random(Generador_PosX_Inicial_Predator);
                         
              exit when Casilla_Libre(X,Y);
           end loop;
        end if; 
        
     end Posicion_Inicial_Predator;
     
     
  end Datos_Cuadricula;
  
end Control_Cuadricula;
