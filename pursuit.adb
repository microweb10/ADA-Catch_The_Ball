with Monitores;

-- FUNCIONES AUXILIARES




-- ************* PROCEDIMIENTO PRINCIPAL *******************

procedure Pursuit is

   -- ******** Declaración de tipos y variables GLOBALES *********
   
   -- *** Tipo Presa ***
   task type Prey(X, Y: Integer);
   type Prey_Ptr is access Prey;

   type Position is
      record
         X: integer;
         Y: integer;
      end record;
   
   -- variables
   Retardo                  : float;    -- retardo entre movimientos
   X1,Y1,X2,Y2,X3,Y3,X4,Y4  : integer;  -- valores iniciales X e Y de los predator (del 1 al 4)
   num_Presas, presa        : integer;

   
   procedure Crear_Prey(X, Y: integer) is
      Pre: Prey_Ptr;
   begin
      Pre := new Prey(X, Y);
   end;
   
   task body Prey is
      exito       : Boolean;
      nueva_pos   : Position;
      actual_pos  : Position;
   begin
      actual_pos.X := X;
      actual_pos.Y := Y;
      nueva_pos := actual_pos;
      
      delay(1.0);
      
      loop        -- bucle que va moviendo (aleatoriamente) la presa
        Monitores.Reservar_Prey(actual_pos.X, actual_pos.y, nueva_pos.X, nueva_pos.Y, exito);
        
        if exito then
           actual_pos := nueva_pos;
        end if;
                                 
        nueva_pos := actual_pos;
        Monitores.Nueva_Posicion_Prey(nueva_pos.X, nueva_pos.Y);
  
        delay(duration(Retardo));       

        exit when(Monitores.Prey_Capturada); --cuando la ultima presa este capturada finalizara
      end loop;
 
      Monitores.Fin_Prey; --finaliza la presa
      
      if(presa<num_Presas) then     
         Monitores.Inicializar_Pos_Prey; --se crea una nueva presa
         Crear_Prey(Monitores.Leer_Posx_Inicial_Prey, Monitores.Leer_Posy_Inicial_Prey);
         presa := presa+1;
      else
         presa := presa+1;
      end if;
      

   end Prey;
   
-- *** Tipo Predator ***
   task type Predator(X, Y, tipo: Integer);
   type Predator_Ptr is access Predator;
   
   type Posicion is
      record
         X:    integer;
         Y:    integer;
      end record;
   

   
   procedure Crear_Predator(X, Y, tipo: integer) is
      Pre: Predator_Ptr;
   begin
      Pre:= new Predator(X, Y, tipo);
   end;
   
   task body Predator is
      exito      : Boolean;
      nueva_pos  : Posicion;
      actual_Pos : Posicion;
      id         : integer;
   begin
      actual_pos.X := X;
      actual_pos.Y := Y;
      nueva_pos := actual_pos;
      id:=tipo;

      delay(1.0);
      
      loop        -- bucle que va moviendo () los predator
        Monitores.Reservar_Predator(actual_pos.X, actual_pos.y, nueva_pos.X, nueva_pos.Y, exito);
        
        if exito then
           actual_pos := nueva_pos;
        end if;
                                 
        nueva_pos := actual_pos;
        Monitores.Nueva_Posicion_Predator(nueva_pos.X, nueva_pos.Y, id);
  
        delay(duration(Retardo));       
        
        exit when (presa>num_Presas);
      end loop;

   end Predator;



-- *********************** CUERPO PRINCIPAL ************************

begin                  
      presa := 1;
      Retardo := Monitores.Calcula_Retardo;
      num_Presas := Monitores.Cuantas_Presas;
      Monitores.Inicializar;
      Monitores.Inicializar_Pos_Prey;
      Monitores.Inicializar_Pos_Predator(X1, Y1, 1);
      Monitores.Inicializar_Pos_Predator(X2, Y2, 2);
      Monitores.Inicializar_Pos_Predator(X3, Y3, 3);
      Monitores.Inicializar_Pos_Predator(X4, Y4, 4);
      Crear_Prey(Monitores.Leer_Posx_Inicial_Prey, Monitores.Leer_Posy_Inicial_Prey);
      Crear_Predator(X1, Y1, 1);
      Crear_Predator(X2, Y2, 2);
      Crear_Predator(X3, Y3, 3);
      Crear_Predator(X4, Y4, 4);
end Pursuit;