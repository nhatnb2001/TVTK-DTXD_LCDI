(Defun c:ss()
	(setvar "cmdecho" 0)
	(command "osnap" "none")
	(initget "Heso Do")
	(command "style" "ss" "vn-abch.shx" "" "0.8" "15" "" "" "")

;;;   (ALERT "
;;;	  Cac he so tuong ung voi ty le
;;;  ((= tl 1/2000) 0.4))
;;;  ((= tl 1/1000) 0.1))
;;;  ((= tl 1/500)  0.25))
;;;  ((= tl 1/250)  0.0625))
;;;  ((= tl 1/200)  0.04))
;;;  ((= tl 1/100)  0.01))
;;;  ((= tl 1/50)   0.0025))
;;;  ((= tl 1/25)   0.000625))
;;;  ((= tl 1/10)   0.1))
;;;  ")
 
	(setq pt (getpoint "\n He so / <Chon diem>:"))
   	(if (= pt "Heso")
	    	(progn	
			(setq am (getreal "\n Cho he so : "))
			(if (and (null am) (/= ac 0))
				(setq am ac)
			)
		(setq pt (getpoint "\n Chon diem: "))	
		)
		(setq ac am))
			
	(if (or (= am 0) (null am)) (setq am 1))
	(setq s 0)
	(progn 
;		(setq pt (getpoint "\n Chon diem: "))	
	      (while pt
			(setq entold (cdr (assoc 5 (entget (entlast)))))
			(command "boundary" pt "")
			(setq entnew (cdr (assoc 5 (entget (entlast)))))
			(if (/= entold entnew)    
				(progn 
                        	(setq entnew (entget (entlast)))
                        	(if (assoc 62 entnew)
                          		(setq entnew (subst (cons 62 (+ 3 (cdr (assoc 62 entnew)))) (assoc 62 entnew) entnew))
                          		(setq entnew (append entnew (list (cons 62 (+ 3 (cdr (assoc 62 (tblsearch "layer" (cdr (assoc 8 entnew))))))))))
                          	)
				
                          
                        	(entmod entnew)
                        	(Command "area" "o" (entlast))
					(setq s (+ s (getvar "area")))
   					(setq pt (getpoint "\n Chon diem: "))
					(entdel (entlast))
	        		)
				(progn
					(princ "chon diem sai")
					(setq pt (getpoint "\n Chon diem: "))
				)
			)
		  )

            )
	
	(command "osnap" "intersection")

	(princ (* s am))
         (princ)
(command "style" "ss" "vn-abch.shx" "" "0.8" "15" "" "" "")
(setq pt1 (getpoint "Chon vi tri ghi dien tich: "))
(setq dt (* s am ))
(setq dt (strcat (rtos dt 2 2) " m2"))
 (command "text" pt1 1.8 0 (strcat "S= " dt))
)