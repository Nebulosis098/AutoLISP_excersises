(defun c:RECIPIENTE ()
  ; Preparacion de AutoCAD
  (setq snp(getvar "osmode"))
  (setvar "osmode" 0)
  
  (setvar "isolines" 20)
  
  (setq puntoVista (list 1 -1 1))
  (command "vpoint" puntoVista "")
  
  (command "-visualstyles" "C" "R")

  ; Solicitud de puntos
  (setq puntoInsercion (getpoint "Ingrese el punto de inserción del Recipiente:"))
  
  ; Calculo de variables
  (setq radioMayor 40)
  (setq alturaMayor 100)
  (setq puntoCuello (list (nth 0 puntoInsercion) (nth 1 puntoInsercion) alturaMayor))
  (setq radioCuello 25)
  (setq alturaCuello 20)
  (setq puntoTapa (list (nth 0 puntoInsercion) (nth 1 puntoInsercion) (+ alturaMayor 20)))
  (setq radioTapa 35)
  (setq alturaTapa 25)
  (setq puntoCorte (list (nth 0 puntoInsercion) (nth 1 puntoInsercion) (+ alturaMayor 40)))
  (setq radioCorte 32)
  (setq alturaCorte 15)
  (setq puntoManija (list (+ (nth 0 puntoInsercion) 35) (nth 1 puntoInsercion) (+ alturaMayor 20)))
  (setq largoManija 10)
  (setq anchoManija 5)
  (setq alturaManija 25)
  
  ;Dibujo primer cilindro
  (command "layer" "m" "CUERPO" "c" "4" "" "")
  (command "cylinder" puntoInsercion radioMayor alturaMayor)
  (setq mayor (entlast))
  
  ;Dibujo cuello recipiente
  (command "cylinder" puntoCuello radioCuello alturaCuello)
  (setq cuello (entlast))
  
  ;Dibujo tapa recipiente
  (command "layer" "m" "TAPA" "c" "7" "" "")
  ;(command "-layer" "set" "TAPA" "")
  (command "cylinder" puntoTapa radioTapa alturaTapa)
  (setq tapa (entlast))
  
  (command "cylinder" puntoCorte radioCorte alturaCorte)
  (setq corteCil (entlast))
  
  ;Corte en tapa
  (command "subtract" tapa "" corteCil "")
  
  ;Dibujo de manija
  (command "box" puntoManija "L" largoManija anchoManija alturaManija)
  (setq manija (entlast))
  
  (command "union" mayor cuello "")
  
  (command "union" tapa manija "")
  
  ;Ultimando detalles
  (setq puntoVista (list 1 -1 1))
  (command "vpoint" puntoVista "")
  
  (setvar "osmode" snp)
  
)