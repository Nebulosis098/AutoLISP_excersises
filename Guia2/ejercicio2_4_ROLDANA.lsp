(defun c:ROLDANA ()
  ;Preparando Autocad
  (setq snp(getvar "osmode"))
  (setvar "osmode" 0)
  
  (setvar "isolines" 20)
  
  (command "-vpoint" "1" "-1" "1" "")
  
  ;Solicitud de punto de inseerción y diametro
  (setq puntoInsercion (getpoint "Ingrese el punto de insercion vertice inf izquierdo:"))
  (setq diametroPolea (getreal "Ingrese el diametro de la polea:"))
  
  ;Creacion de capas
  
  ;Calculo de variables para dibujo
  (setq puntoOpInser (list (+ (nth 0 puntoInsercion) (* diametroPolea 1.5)) (+ (nth 1 puntoInsercion) diametroPolea) (nth 2 puntoInsercion)))
  (setq inicioBase (list (+ (nth 0 puntoInsercion) (* diametroPolea 0.5)) (nth 1 puntoInsercion) (+ (nth 2 puntoInsercion) (* diametroPolea 0.1))))
  (setq finBase (list (+ (nth 0 puntoInsercion) (* diametroPolea 0.6)) (+ (nth 1 puntoInsercion) diametroPolea) (+ (nth 2 puntoInsercion) (* diametroPolea 0.1))))
  (setq firstMirror (list (+ (nth 0 puntoInsercion) (* diametroPolea 0.75)) (nth 1 puntoInsercion) (nth 2 puntoInsercion)))
  (setq secondMirror (list (nth 0 firstMirror) (+ (nth 1 firstMirror) diametroPolea) (nth 2 firstMirror) ))
  (setq p0LineUCS (list (+ (nth 0 puntoInsercion) (* diametroPolea 0.5)) (+ (nth 1 firstMirror) (* diametroPolea 0.5)) (+ (nth 2 firstMirror) (* diametroPolea 0.85))))
  (setq p1LineUCS (list (+ (nth 0 p0LineUCS) (* diametroPolea 0.5)) (nth 1 p0LineUCS) (nth 2 p0LineUCS)))
  (setq radioMenPol (* diametroPolea 0.1))
  (setq largoCilMenPol (* diametroPolea 0.5))
        
  ;Dibujo de base
  (command "rectang" puntoInsercion puntoOpInser)  
  (setq rect (entlast))
  (command "extrude" rect "" (* diametroPolea 0.1) "")
  
  ;Dibujo sosten de polea
  (command "rectang" inicioBase finBase)
  (setq recBase (entlast))
  (command "mirror" recBase "" firstMirror secondMirror "")
  (setq recBase2 (entlast))
  (command "extrude" recBase recBase2 "" diametroPolea "")
  (setq basePolea (entlast))
  
  ;Dibujo de polea :(
  (command "-layer" "m" "POLEA" "c" "4" "" "")
  (command "line" p0LineUCS p1LineUCS "")
  (command "ucs" "ZA" p0LineUCS p1LineUCS)
  (command "cylinder" puntoInsercion radioMenPol largoCilMenPol)
  (setq cilMenPol (entlast))
  (command "subtract" basePolea "" cilMenPol "")
  ;(command)
  
  (command "ucs" "W" "")
  
  
  
)