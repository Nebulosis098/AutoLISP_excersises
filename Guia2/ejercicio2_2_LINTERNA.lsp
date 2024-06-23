(defun c:LINTERNA ()
  ;Desactivamos OSNAP
  (setq snp(getvar "osmode"))
  (setvar "osmode" 0)

  ;prender osnap
  (setvar "osmode" 1)

  ;setear variable isolines
  (setvar "isolines" 20)
  
  ;Establecer punto de vista y viewports
  (command "vpoint" "1" "," "-1" "," "1" "")
  ;(command "-vports" "2" "" )
  
  ;Solicitud de punto central de insercion
  (setq centroPrincipal (getpoint "Indique el centro de inserción de la linterna: "))
  ;Solicitud de altura de la linterna
  (setq altura (getreal "Indique la altura deseada de la linterna: "))

  ;Calculo de demas variables y parametros para la construccion de la linterna
  (setq radioPtaIlum (* altura 0.2))
  (setq alturaPtaIlum (* altura 0.2)) ;Este se podria suprimir porque es lo mismo que radioPtaIlum
  (setq centroEsferGra (list (nth 0 centroPrincipal) (nth 1 centroPrincipal) (+ (nth 2 centroPrincipal) alturaPtaIlum)))
  (setq radioEsferGra (* altura 0.2)) ;Este se podria suprimir porque es lo mismo que radioPtaIlum
  (setq centroFinal (list (nth 0 centroPrincipal) (nth 1 centroPrincipal) (+ (nth 2 centroPrincipal) altura)))
  (setq radioPulsador (* altura 0.02))
  (setq alturaPulsador (* altura -0.1))
  (setq centroEsferMen (list (nth 0 centroPrincipal) (nth 1 centroPrincipal) (+ (nth 2 centroPrincipal) (* altura 0.8)))) ; 0,0,(0.8*altura)
  (setq radioEsferMen (* altura 0.1))
  (setq alturaCilCentral (* altura -0.428))
  (setq alturaCilCentralSub (* altura -0.43))  
  (setq ptoCentralAcc1 (list (+ (nth 0 centroEsferMen) (* altura 0.02)) (- (nth 1 centroEsferMen) (* altura 0.02)) (- (nth 2 centroEsferMen) (* altura 0.04))))
  (setq largoAccesorio (* altura 0.16))  
  (setq anchoAccesorio (* altura 0.04))
  (setq alturaAccesorio (* altura 0.025))    
  (setq ptoCentralAcc2 (list (+ (nth 0 centroEsferMen) (* altura 0.15)) (- (nth 1 centroEsferMen) (* altura 0.02)) (- (nth 2 centroEsferMen) (* altura 0.04))))
  (setq largoAccesorio2 (* altura 0.03))  
  (setq anchoAccesorio2 (* altura 0.04))
  (setq alturaAccesorio2 (* altura -0.2)) 
  
  ;Dibujo de extremo de iluminacion
  (command "cylinder" centroPrincipal radioPtaIlum alturaPtaIlum)
  (setq c0 (entlast))
  (command "cylinder" centroPrincipal radioPtaIlum alturaPtaIlum)
  (setq c1 (entlast))
  (command "sphere" centroEsferGra radioEsferGra)
  (setq esferaSub1 (entlast))
  (command "subtract" esferaSub1 "" c1 "")
  
  ;Dibujo de extremo inferior 
  (command "cylinder" centroFinal radioPulsador alturaPulsador)
  (setq pulsador (entlast))
  (command "sphere" centroEsferMen radioEsferMen)
  (setq esferaSub2(entlast))

  
  ;Dibujo de parte central
  (command "cylinder" centroEsferMen radioEsferMen alturaCilCentral)
  (setq ciliCentral (entlast))
  (command "cylinder" centroEsferMen radioEsferMen alturaCilCentralSub)
  (setq c2 (entlast))
  (command "cylinder" centroEsferMen radioEsferMen alturaCilCentralSub)
  (setq c3 (entlast))
  (command "subtract" esferaSub2 "" c2 "")
  (command "subtract" esferaSub1 "" c3 "")
  
  ;Dibujo de accesorio lateral
  (command "box" ptoCentralAcc1 "L" largoAccesorio anchoAccesorio alturaAccesorio)
  (setq acc1 (entlast))
  (command "box" ptoCentralAcc2 "L" largoAccesorio2 anchoAccesorio2 alturaAccesorio2)
  (setq acc2 (entlast))
  
  ;Dibujo de cilindros detalle punta iluminacion
  (command "layer" "m" "DETALLE" "c" "2" "" "") ; Queda en esta capa, y se hace en esta a partir de aca
  
  ;RoadMap: Dibujar un cilindro
          ; Darle nombre con entlast
          ; Array polar
          ; Seleccionar todos los elementos de la capa
          ; Darle nombre con setq y ssget
          ; Hacer el subtract correspondiente
  (setq ptoCilDet (list (nth 0 centroPrincipal) (+ (nth 1 centroPrincipal) radioPtaIlum) (nth 2 centroPrincipal)))
  (setq radioCilDet (* altura 0.03))
  (command "cylinder" ptoCilDet radioCilDet alturaPtaIlum)
  (setq cilDet1 (entlast))
  (command "-array" cilDet1 "" "P" centroPrincipal "15" "360" "N" "")
  (setq cilindritos (ssget "x" '((8 . "DETALLE"))))
  (command "subtract" c0 "" cilindritos "")
  
  (command "union" c0 esferaSub1 esferaSub2 acc1 acc2 ciliCentral pulsador"")
  
)
