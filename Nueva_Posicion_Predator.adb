-- calcula la nueva posicion de los predator
     procedure Nueva_Posicion_Predator(X, Y: in out Integer ; tipo: in Integer) is
        
        incX, incY : Integer;

     begin
     
        --si es el predator de la izquierda
        if(tipo=1) then         
           if(Control_Cuadricula.Datos_Cuadricula.Leer_PosY_Actual_Prey > Y) then--si la posicion Y de la presa esta mas arriba
              incY := 1;
              incX := 0;
              
           else
              if (Control_Cuadricula.Datos_Cuadricula.Leer_PosY_Actual_Prey < Y) then --si la posicion Y esta mas abajo
                 incY := -1;
                 incX := 0;
              else             -- si la posicion Y es la misma y ...
                 if (Control_Cuadricula.Datos_Cuadricula.Leer_PosX_Actual_Prey > X) then--si la posicion X esta mas a la derecha
                    incY := 0;
                    incX := 1;
                 else
                    if (Control_Cuadricula.Datos_Cuadricula.Leer_PosX_Actual_Prey < X) then--si la posicion X esta a mas la izquierda
                       incY := 0;
                       incX := -1;
                    end if;
                 end if;
              end if;
           end if;
        end if;
        
        --si es el predator de la derecha 
        if(tipo=3) then        
           if(Control_Cuadricula.Datos_Cuadricula.Leer_PosY_Actual_Prey < Y) then --si la posicion Y de la presa esta mas abajo
              incY := -1;
              incX := 0;
           else
              if (Control_Cuadricula.Datos_Cuadricula.Leer_PosY_Actual_Prey > Y) then --si la posicion Y esta mas arriba
                 incY := 1;
                 incX := 0;
              else             -- si la posicion Y es la misma y ...
                 if (Control_Cuadricula.Datos_Cuadricula.Leer_PosX_Actual_Prey < X) then--si la posicion X esta a mas la izquierda
                    incY := 0;
                    incX := -1;
                 else
                    if (Control_Cuadricula.Datos_Cuadricula.Leer_PosX_Actual_Prey > X) then--si la posicion X esta mas a la derecha
                       incY := 0;
                       incX := 1;
                    end if;
                 end if;
              end if;
           end if;
        end if;

        --si es el predator de arriba
        if(tipo=2) then         
           if(Control_Cuadricula.Datos_Cuadricula.Leer_PosX_Actual_Prey < X) then --si la posicion X esta a mas la izquierda
              incY := 0;
              incX := -1;
           else
              if (Control_Cuadricula.Datos_Cuadricula.Leer_PosX_Actual_Prey > X) then--si la posicion X esta mas a la derecha
                 incY := 0;
                 incX := 1;
              else             -- si la posicion X es la misma y ...
                 if (Control_Cuadricula.Datos_Cuadricula.Leer_PosY_Actual_Prey < Y) then--si la posicion Y de la presa esta mas abajo
                    incY := -1;
                    incX := 0;
                 else
                    if (Control_Cuadricula.Datos_Cuadricula.Leer_PosY_Actual_Prey > Y) then--si la posicion Y esta mas arriba
                       incY := 1;
                       incX := 0;
                    end if;
                 end if;
              end if;
           end if;
        end if;
        
        --si es el predator de abajo 
        if(tipo=4) then        
           if(Control_Cuadricula.Datos_Cuadricula.Leer_PosX_Actual_Prey > X) then --si la posicion X esta mas a la derecha
              incY := 0;
              incX := 1;
           else
              if (Control_Cuadricula.Datos_Cuadricula.Leer_PosX_Actual_Prey < X) then--si la posicion X esta a mas la izquierda
                 incY := 0;
                 incX := -1;
              else             -- si la posicion X es la misma y ...
                 if (Control_Cuadricula.Datos_Cuadricula.Leer_PosY_Actual_Prey > Y) then--si la posicion Y esta mas arriba
                    incY := 1;
                    incX := 0;
                 else
                    if (Control_Cuadricula.Datos_Cuadricula.Leer_PosY_Actual_Prey < Y) then--si la posicion Y de la presa esta mas abajo
                       incY := -1;
                       incX := 0;
                    end if;
                 end if;
              end if;
           end if;
        end if;

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
