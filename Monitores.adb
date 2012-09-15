with AdaGraph;
with Ada.Numerics.Discrete_Random;
with Ada.Numerics.Float_Random;
with Visor_Cuadricula;
with Ada.Text_IO;
with gnat.io;
with Ada.Float_Text_IO;
with Control_Cuadricula;

package body Monitores is

     Color_Prey_Capturada : AdaGraph.Color_Type := AdaGraph.Light_Red;


     -- inicializa la cuadricula     
     procedure Inicializar is
     begin
        Ada.Text_IO.Put_line("Inicializando la cuadricula");
        Control_Cuadricula.Datos_Cuadricula.Inicializar;
        Visor_Cuadricula.IniciarGrafico;
        Ada.Text_IO.Put_line("Comienzo de la persecucion");
     end;


     -- inicializa las posicion de la prey
     procedure Inicializar_Pos_Prey is
     begin
        Control_Cuadricula.Datos_Cuadricula.Posicion_Inicial_Prey;
     end;

     
     -- inicializa las posicion del predator
     procedure Inicializar_Pos_Predator (X, Y: in out integer; tipo: in integer) is
     begin
        Control_Cuadricula.Datos_Cuadricula.Posicion_Inicial_Predator(X,Y,tipo);
     end;

     
     -- reserva una casilla para una prey
     procedure Reservar_Prey(actual_X, actual_Y, nueva_X, nueva_Y: Integer; exito: in out Boolean) is
     begin
        Control_Cuadricula.Datos_Cuadricula.Prey_Ocupa_Casilla(actual_X, actual_Y, nueva_X, nueva_Y, exito);
     end;
     

     -- reserva una casilla para un predator     
     procedure Reservar_Predator(actual_X, actual_Y, nueva_X, nueva_Y: Integer; exito: in out Boolean) is
     begin
        Control_Cuadricula.Datos_Cuadricula.Predator_Ocupa_Casilla(actual_X, actual_Y, nueva_X, nueva_Y, exito);
     end;


     -- calcula la nueva posicion de la prey
     procedure Nueva_Posicion_Prey(X, Y: in out Integer) is
        subtype Rango_Aleatorio_Movimiento is Integer range -1..1;
        package Numeros_Aleatorios_Movimiento is
                new Ada.Numerics.Discrete_Random(Rango_Aleatorio_Movimiento);
        Generador_Movimiento: Numeros_Aleatorios_Movimiento.Generator;

        incX, incY : Integer;

     begin
        loop
           Numeros_Aleatorios_Movimiento.Reset(Generador_Movimiento);
           incX := Numeros_Aleatorios_Movimiento.Random(Generador_Movimiento);

           Numeros_Aleatorios_Movimiento.Reset(Generador_Movimiento);
           incY := Numeros_Aleatorios_Movimiento.Random(Generador_Movimiento);

           exit when (incX /= incY) and (incX /= -incY);
        end loop;

        if (X=Control_Cuadricula.Leer_Ancho and incX=1)or(X=1 and incX=-1) then
           X:=X;
        else
           X:= X + incX;
        end if;
        
        if (Y=Control_Cuadricula.Leer_Alto and incY=1)or(Y=1 and incY=-1) then
           Y:=Y;
        else
           Y:= Y + incY;
        end if;
           
     end Nueva_Posicion_Prey;

     -- calcula la nueva posicion de los predator
     procedure Nueva_Posicion_Predator(X, Y: in out Integer ; tipo: in Integer) is
        
        incX, incY : Integer;

     begin
     
        --si es el predator de la izquierda
        if(tipo=1) then         
           if(Control_Cuadricula.Datos_Cuadricula.Leer_PosX_Actual_Prey > X) then
              incX := 1;
              incY := 0;
           else
              if (Control_Cuadricula.Datos_Cuadricula.Leer_PosX_Actual_Prey < X) then 
                 incX := -1;
                 incY := 0;
              else            
                 if (Control_Cuadricula.Datos_Cuadricula.Leer_PosY_Actual_Prey > Y) then
                    incX := 0;
                    incY := 1;
                 else
                    if (Control_Cuadricula.Datos_Cuadricula.Leer_PosY_Actual_Prey < Y) then
                       incX := 0;
                       incY := -1;
                    end if;
                 end if;
              end if;
           end if;
        end if;
        
        --si es el predator de la derecha 
        if(tipo=3) then        
           if(Control_Cuadricula.Datos_Cuadricula.Leer_PosX_Actual_Prey < X) then
              incX := -1;
              incY := 0;
           else
              if (Control_Cuadricula.Datos_Cuadricula.Leer_PosX_Actual_Prey > X) then 
                 incX := 1;
                 incY := 0;
              else            
                 if (Control_Cuadricula.Datos_Cuadricula.Leer_PosY_Actual_Prey > Y) then
                    incX := 0;
                    incY := 1;
                 else
                    if (Control_Cuadricula.Datos_Cuadricula.Leer_PosY_Actual_Prey < Y) then
                       incX := 0;
                       incY := -1;
                    end if;
                 end if;
              end if;
           end if;
        end if;

        --si es el predator de arriba
        if(tipo=2) then         
           if(Control_Cuadricula.Datos_Cuadricula.Leer_PosY_Actual_Prey > Y) then
              incX := 0;
              incY := 1;
           else
              if (Control_Cuadricula.Datos_Cuadricula.Leer_PosY_Actual_Prey < Y) then 
                 incX := 0;
                 incY := -1;
              else            
                 if (Control_Cuadricula.Datos_Cuadricula.Leer_PosX_Actual_Prey > X) then
                    incX := 1;
                    incY := 0;
                 else
                    if (Control_Cuadricula.Datos_Cuadricula.Leer_PosX_Actual_Prey < X) then
                       incX := -1;
                       incY := 0;
                    end if;
                 end if;
              end if;
           end if;
        end if;
        
        --si es el predator de abajo 
        if(tipo=4) then        
           if(Control_Cuadricula.Datos_Cuadricula.Leer_PosY_Actual_Prey < Y) then
              incX := 0;
              incY := -1;
           else
              if (Control_Cuadricula.Datos_Cuadricula.Leer_PosY_Actual_Prey > Y) then 
                 incX := 0;
                 incY := 1;
              else            
                 if (Control_Cuadricula.Datos_Cuadricula.Leer_PosX_Actual_Prey > X) then
                    incX := 1;
                    incY := 0;
                 else
                    if (Control_Cuadricula.Datos_Cuadricula.Leer_PosX_Actual_Prey < X) then
                       incX := -1;
                       incY := 0;
                    end if;
                 end if;
              end if;
           end if;
        end if;

         
        --evitamos algun posible obstaculo
        Evitar_Obstaculo(X,Y,incX,incY);
        
        --comprobamos que no se salga del tamanyo de la cuadricula
        if (X=Leer_Ancho and Incx=1)or(X=1 and Incx=-1) then 
           X:=X;
        else
           X:= X + Incx;
        end if;
        if (Y=Leer_Alto and Incy=1)or(Y=1 and Incy=-1) then
           Y:=Y;
        else
           Y:= Y + Incy;
        end if;
           
     end Nueva_Posicion_Predator;


     -- evita un obstaculo
     procedure Evitar_Obstaculo(X, Y: Integer; incX, incY: in out Integer) is
     begin
        -- si queremos ir para arriba
        if ((incX=0)and(incY=1)) then
           if (Casilla_Libre(X,Y+1)=false and Control_Cuadricula.Datos_Cuadricula.Leer_PosY_Actual_Prey/=Y+1 ) then --si no se puede avanzar
              if(Casilla_Libre(X-1,Y)) then --si puede ir a la izquierda
                 incX:=-1;
                 incY:=0;
              else
                 incX:=1;
                 incY:=0;
              end if;
           end if;
        end if;
        
        -- si queremos ir para abajo
        if ((incX=0)and(incY=-1)) then
           if (Casilla_Libre(X,Y-1)=false and Control_Cuadricula.Datos_Cuadricula.Leer_PosY_Actual_Prey/=Y-1) then --si no se puede avanzar
              if(Casilla_Libre(X-1,Y)) then --si puede ir a la izquierda
                 incX:=-1;
                 incY:=0;
              else
                 incX:=1;
                 incY:=0;
              end if;
           end if;
        end if;
        
        -- si queremos ir para la izquierda
        if ((incX=-1)and(incY=0)) then
           if (Casilla_Libre(X-1,Y)=false and Control_Cuadricula.Datos_Cuadricula.Leer_PosX_Actual_Prey/=X-1) then --si no se puede avanzar
              if(Casilla_Libre(X,Y-1)) then --si puede ir hacia abajo
                 incX:=0;
                 incY:=-1;
              else
                 incX:=0;
                 incY:=1;
              end if;
           end if;
        end if;
        
        -- si queremos ir para la derecha
        if ((incX=1)and(incY=0)) then
           if (Casilla_Libre(X+1,Y)=false and Control_Cuadricula.Datos_Cuadricula.Leer_PosX_Actual_Prey/=X+1) then --si no se puede avanzar
              if(Casilla_Libre(X,Y-1)) then --si puede ir hacia abajo
                 incX:=0;
                 incY:=-1;
              else
                 incX:=0;
                 incY:=1;
              end if;
           end if;
        end if;
     end Evitar_Obstaculo;


     -- devuelve la posicion X Inicial de la prey
     function Leer_PosX_Inicial_Prey return integer is
     begin
        return Control_Cuadricula.Datos_Cuadricula.Leer_PosX_Inicial_Prey;
     end;

     -- devuelve la posicion Y Inicial de la prey
     function Leer_PosY_Inicial_Prey return integer is
     begin
        return Control_Cuadricula.Datos_Cuadricula.Leer_PosY_Inicial_Prey;
     end;

     -- devuelve el ancho (numero de columnas) de la cuadricula     
     function Leer_Ancho return integer is
     begin
        return Control_Cuadricula.Leer_Ancho;
     end;

     -- devuelve el alto (numero de filas) de la cuadricula
     function Leer_Alto return integer is
     begin
        return Control_Cuadricula.Leer_Alto;
     end;
     
     -- nos dice si la casilla esta libre u ocupada
     function Casilla_Libre(X, Y: integer) return boolean is
     begin
        return Control_Cuadricula.Datos_Cuadricula.Casilla_Libre(X, Y);
     end;
     
     -- finaliza una prey
     procedure Fin_Prey is
     begin
        ADA.Text_IO.Put_Line("Finaliza una prey");
        Control_Cuadricula.Datos_Cuadricula.Pintar(Control_Cuadricula.Datos_Cuadricula.Leer_PosX_Actual_Prey, Control_Cuadricula.Datos_Cuadricula.Leer_PosY_Actual_Prey, Color_Prey_Capturada);
     end;
     
     
     -- nos dice si una presa ya esta capturada
     function Prey_Capturada return Boolean is
     X, Y: Integer;
     begin
        X:=Control_Cuadricula.Datos_Cuadricula.Leer_PosX_Actual_Prey;
        Y:=Control_Cuadricula.Datos_Cuadricula.Leer_PosY_Actual_Prey;
        if ((Casilla_Libre(X,Y+1))or(Casilla_Libre(X,Y-1))or(Casilla_Libre(X+1,Y))or(Casilla_Libre(X-1,Y))) then
               return false;
        else
               return true;
        end if;
     end Prey_Capturada;
  
  
   -- devuelve un retardo aleatorio entre 0.1 y 1 segundos
   procedure Retardo_Aleatorio(X: in out float) is
   
         Generador_Retardo: Ada.Numerics.Float_Random.Generator;

      begin
         Ada.Numerics.Float_Random.Reset(Generador_Retardo);
         X := Ada.Numerics.Float_Random.Random(Generador_Retardo);
           
   end Retardo_Aleatorio;

      
  
   -- calcula el retardo de las tareas presa y predator
   function Calcula_Retardo return float is 
   
   -- variables
   opc: Integer;
   Ret: float;
   -- cuerpo
   begin
      Ada.Text_IO.put("Primero Elije el Tipo de RETARDO que quieres para la Presa y los Depredadores"); Ada.Text_IO.new_line;
      Ada.Text_IO.put("        1.    Retardo Fijo definido por el usuario      (Pulsa 1)"); Ada.Text_IO.new_line;
      Ada.Text_IO.put("        2.    Retardo Aleatorio entre 0.1 y 1 segundos  (Pulsa 2)"); Ada.Text_IO.new_line;
      Ada.Text_IO.put("   Pulsa AQUI tu numero de opcion seguido de la tecla Intro ");
      gnat.io.get(opc);
      if (opc<1 or opc>2) then
         loop
            Ada.Text_IO.put("Has elegido una opcion NO VALIDA. Pulsa AQUI tu numero de opcion seguido de la tecla Intro ");
            gnat.io.get(opc);
            exit when (opc>=1 and opc<=2);
         end loop;
      end if;
      
      if (opc=1) then
         Ada.Text_IO.put("Escribe a continuacion el RETARDO ");
         Ada.Float_Text_IO.get(Ret);
         return Ret;
      else
         Retardo_Aleatorio(Ret);
         return Ret;
      end if;
      
   end Calcula_Retardo;
   
   
   -- pide al usuario el numero de presas a capturar
     function Cuantas_Presas return integer is
     num : Integer;
     begin
        Ada.Text_IO.put("Escribe el numero de presas que quieres que capture el programa (debe ser mayor o igual a 1)"); Ada.Text_IO.new_line;
        gnat.io.get(num);
        if(num<1) then
           loop
              Ada.Text_IO.put("NUMERO INCORRECTO (debe ser mayor o igual a 1)"); Ada.Text_IO.new_line;
              gnat.io.get(num);
              exit when (num>=1);
           end loop;
        end if;
        return num;
     end Cuantas_Presas;
  
  
end Monitores;