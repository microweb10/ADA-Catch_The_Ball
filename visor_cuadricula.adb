with AdaGraph; use AdaGraph;
with Control_Cuadricula; use Control_Cuadricula;

package body Visor_Cuadricula is

  Fondo: Color_Type:= White;
  Color_Pared: Color_Type := Blue;
  
  Margen_Izquierdo : constant Integer := 10;
  Margen_Derecho   : constant Integer := 10;
  Margen_Superior  : constant Integer := 10;
  Margen_Inferior  : constant Integer := 10;
  Ancho_Casilla    : Integer;
  Alto_Casilla     : Integer;
  Radio            : Integer;

  X_Max,  Y_Max  : Integer;  -- Maximum window coordinates
  X_Char, Y_Char : Integer;  -- Character size
  X_Ventana : constant Integer := 600;
  Y_Ventana : constant Integer := 500;


  procedure IniciarGrafico is
  begin
     Create_Sized_Graph_Window (X_Ventana, Y_Ventana, X_Max, Y_Max, X_Char, Y_Char);
     Set_Window_Title ("Pursuit Domain");
     Clear_Window(fondo);
     Mostrar_Cuadricula;
  end IniciarGrafico;


  procedure QuitarGrafico is
  begin
     Destroy_Graph_Window;
  end QuitarGrafico;


  procedure Mostrar_Cuadricula is
    Ancho: Integer := Leer_Ancho;
    Alto: Integer := Leer_Alto;
    PosX, PosY: Integer;
  begin
    Ancho_Casilla := (X_Ventana - Margen_Izquierdo - Margen_Derecho) / Ancho;
    Alto_Casilla := (Y_Ventana - Margen_Superior - Margen_Inferior) / Alto;
    Radio := Ancho_Casilla / 3;
    for X in 1..Ancho loop
      PosX := Margen_Izquierdo + (X - 1) * Ancho_Casilla;
      for Y in 1..Alto loop
         PosY := Margen_Superior + (Y - 1) * Alto_Casilla;
         Draw_Box(PosX, PosY, PosX + Ancho_Casilla - 1, PosY + Alto_Casilla - 1, Black, No_Fill);        
      end loop;
    end loop;
  end;


  procedure Ocupar(X, Y: Integer; Color: AdaGraph.Color_Type) is
     PosX, PosY: Integer;
  begin
     PosX := (Margen_Izquierdo + (X - 1) * Ancho_Casilla) + (Ancho_Casilla / 2);
     PosY := (Margen_Superior + (Y - 1) * Alto_Casilla) + (Alto_Casilla / 2);
     Draw_Circle(PosX, PosY, Radio, Color, Fill);
  end;

end Visor_Cuadricula;