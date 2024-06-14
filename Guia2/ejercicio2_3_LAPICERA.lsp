(defun c:LAPICERA()
  ;Solicitud de punto inicial
  (defun get-point-with-prompt(prompt)
    (getpoint prompt)
  )
  
  (setq p1 (get-point-with-prompt "/nIngrese el punto inicial de la lapicera: "))
  
  ;Calculo de variables y demas puntos
  (setq altura 78)
  (setq radioPrincipal 3.5)
  (setq radioPuntaSuperior 2)
  (setq radioEsferaSup 2)
  (setq alturaPuntaInferior -13)
  (setq alturaPuntaSuperior 7)
  (setq p2 (list (nth 0 p1) (nth 1 p1) (+ (nth 2 p1) altura)))
  (setq p3 (list (nth 0 p2) (nth 1 p2) (+ (nth 2 p2) alturaPuntaSuperior)))
  
  ;Dibujo del cuerpo de la lapicera
  ;Dibujo de la punta inferior
  (command "CONE" p1 radioPrincipal alturaPuntaInferior)
  (setq ConoInferior (entlast))
  ;Dibujo de cilindros
  (command "CYLINDER" p1 radioPrincipal altura )
  (setq CilindroPrincipal (entlast))
  
  ;Dibujo punta superior
  (command "CYLINDER" p2 radioPuntaSuperior alturaPuntaSuperior)
  (setq CilindroPuntaSup (entlast))
  (command "SPHERE" p3 radioEsferaSup)
  (setq EsferaSustraer (entlast))
  (command "SUBTRACT" EsferaSustraer "" CilindroPuntaSup "")
  (command "CYLINDER" p2 radioPuntaSuperior alturaPuntaSuperior)
  (setq CilindroPuntaSup2 (entlast))
  
  (command "UNION" ConoInferior CilindroPrincipal EsferaSustraer CilindroPuntaSup2 "")
  
  (command "VPOINT" 1 "," -1 "," 1 "" )
  
  ;Dibujo de manijita
  
  ;Dibujo de detalle 
)