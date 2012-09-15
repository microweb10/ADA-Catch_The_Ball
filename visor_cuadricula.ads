with AdaGraph;

package Visor_Cuadricula is

  -- Inicializa la ventana grafica
  procedure IniciarGrafico;

  -- Destruye la ventana grafica
  procedure QuitarGrafico;

  -- Dibuja una casilla como ocupada. Antes de llamar a esta funcion
  -- se debe haber llamado a la función Revisar de la cuadrícula con exito
  procedure Ocupar(X, Y: Integer; Color: AdaGraph.Color_Type);


private
  -- Procedimiento privado para visualizar la cuadrícula
  procedure Mostrar_Cuadricula;

end Visor_Cuadricula;