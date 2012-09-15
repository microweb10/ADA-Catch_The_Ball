with AdaGraph;

package Control_Cuadricula is

     -- Dimensiones de la cuadrícula
     Ancho_Cuadricula: constant Integer := 15;
     Alto_Cuadricula: constant Integer := 10; 

     -- Tipos de datos
     type Casilla_Cuadricula is (Libre, Ocupada);
     type Matriz_Cuadricula is array (1..Ancho_Cuadricula,1..Alto_Cuadricula) of Casilla_Cuadricula;  
  
     -- Devuelve el ancho y alto (en número de casillas) de la cuadrícula
     function Leer_Ancho return Integer;
     function Leer_Alto return Integer; 
     

   protected Datos_Cuadricula is
   
     -- Inicializa la cuadrícula
     procedure Inicializar;

     -- Devuelve true si la casilla especificada esta libre
     function Casilla_Libre (X, Y: Integer) return Boolean;
     
     -- Marca una casilla libre como ocupada
     procedure Prey_Ocupa_Casilla (actual_X, actual_Y, nueva_X, nueva_Y: Integer; exito: in out Boolean);
     procedure Predator_Ocupa_Casilla (actual_X, actual_Y, nueva_X, nueva_Y: Integer; exito: in out Boolean);
     
     -- pintar una casilla de la cuadricula con un color determinado
     procedure Pintar(X, Y: integer; Color: AdaGraph.Color_Type);
    
     -- calcular la posicion inicial de la prey y los predator
     procedure Posicion_Inicial_Prey;  
     procedure Posicion_Inicial_Predator(X, Y: in out integer; tipo: in integer); 

     -- Obtener la posicion inicial y actual de la prey
     function Leer_PosX_Inicial_Prey return Integer;
     function Leer_PosY_Inicial_Prey return Integer;
     function Leer_PosX_Actual_Prey return Integer;
     function Leer_PosY_Actual_Prey return Integer;
     
              
  private   
     Matriz           : Matriz_Cuadricula;  
     
     PosX_Inicial_Prey: Integer;            
     PosY_Inicial_Prey: Integer;
     
     PosX_Actual_Prey : Integer;
     PosY_Actual_Prey : Integer;

  end Datos_Cuadricula;
          
end Control_Cuadricula;