(defun c:foo_lapicera()
  ;configuración de cad  
  (command "osmode" 0)
  (command "surftab1" 20)
  (command "surftab2" 20)
  (command "isolines" 20)
  (command "-layer" "n" "Agarradera" "c" "1" "Agarradera" "") ;creación de layer
  (command "-layer" "set" "0" "") ;seteo layer 0
  ;inicio del ejercicio
  (setq puntobase (getpoint "hacé click donde va la lapicera."))
  (setq p1 (list(nth 0 puntobase)(nth 1 puntobase)(+ 13 (nth 2 puntobase))))
  ;
  (setq conoBase(entnext))
  	(command "cone" p1 3.5 -13)
  ;
  (setq cuerpoLapicera(entnext))
  	(command "cylinder" p1 3.5 78)
  ;
  (setq p2 (list(nth 0 p1)(nth 1 p1)(+ 78 (nth 2 p1))))
  (command "cylinder" p2 2 7)
  (setq cilindroDelClick(entlast))  	
  ;
  (setq p3 (list(nth 0 p2)(nth 1 p2)(+ 7 (nth 2 p2))))
  (command "sphere" p3 2)
  (setq esferaDelClick(entlast))  	
  ;
  (command "subtract" esferaDelClick "" cilindroDelClick "")
  (command "cylinder" p2 2 7)
  (setq cilindroDelClick(entlast))
  ;
  (setq p4 (list (nth 0 p2) (- (nth 1 p2) 0.5) (nth 2 p2) ))
  (setq p5 (list (+ 5(nth 0 p2)) (+ (nth 1 p2) 0.5) (- (nth 2 p2) 0.5) ))
  (command "box" p4 p5)
  (setq enganche1(entlast))
  ;
  (setq p6 (list (- (nth 0 p5) 0.5) (- (nth 1 p5) 1) (- (nth 2 p5) 19) ))
  (command "box" p5 p6)
  (setq enganche2(entlast))
  ;
  (command "-layer" "set" "Agarradera" "") ;seteo layer agarradera
   (command "cylinder" p1 4 30)
  (setq cilindro1(entlast))
  (command "cylinder" p1 3.5 30)
  (setq cilindro2(entlast))
  (command "subtract" cilindro1 "" cilindro2 "")
  ;
  (setq p7 (list (+ 4 (nth 0 p1))(nth 1 p1)(nth 2 p1) ))
  (command "cylinder" p7 0.5 30)
  (setq aux(entlast))
  (command "arraypolar" aux "" p1 "i" 10 "" "exit" "")
  (setq aux2(entlast))
  (command "explode" aux2)  
  (setq aux3(ssget "p"))
  (command "subtract" cilindro1 "" aux3 "" "")
)