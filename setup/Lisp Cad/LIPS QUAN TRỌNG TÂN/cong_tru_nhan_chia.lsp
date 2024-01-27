;; free lisp from cadviet.com

(defun c:cong()
(setq i 0 s1 0)
(setq n (getreal "\nnhap so muon cong them: "))
  (prompt "\nchon cac so can sua ...")
	(setq txt (ssget '((0 . "TEXT"))))
 	(repeat (sslength txt)
		(setq txt_name (ssname txt i))
	  	(setq txt_ent (entget txt_name))
		(setq cont (cdr(assoc 1 txt_ent)))
		(setq cont (atof cont))
		(setq s (+ cont n))	  
	  (setq txt_ent  (subst (cons 1 (rtos s)) (assoc 1 txt_ent) txt_ent))
		(entmod txt_ent)
		(setq i (+ i 1))
	);repeat
);defun	
;------------------------------------------------------
(defun c:tru()
(setq i 0 s1 0)
(setq n (getreal "\nnhap so tru: "))
  (prompt "\nchon cac so can sua ...")
	(setq txt (ssget '((0 . "TEXT"))))
 	(repeat (sslength txt)
		(setq txt_name (ssname txt i))
	  	(setq txt_ent (entget txt_name))
		(setq cont (cdr(assoc 1 txt_ent)))
		(setq cont (atof cont))
		(setq s (- cont n))	  
	  (setq txt_ent  (subst (cons 1 (rtos s)) (assoc 1 txt_ent) txt_ent))
		(entmod txt_ent)
		(setq i (+ i 1))
	);repeat
);defun	
;------------------------------------------------------
(defun c:nhan()
(setq i 0 s1 0)
(setq n (getreal "\nnhap so muon nhan: "))
  (prompt "\nchon cac so can sua ...")
	(setq txt (ssget '((0 . "TEXT"))))
 	(repeat (sslength txt)
		(setq txt_name (ssname txt i))
	  	(setq txt_ent (entget txt_name))
		(setq cont (cdr(assoc 1 txt_ent)))
		(setq cont (atof cont))
		(setq s (* cont n))	  
	  (setq txt_ent  (subst (cons 1 (rtos s)) (assoc 1 txt_ent) txt_ent))
		(entmod txt_ent)
		(setq i (+ i 1))
	);repeat
);defun	
;------------------------------------------------------
(defun c:chia()
(setq i 0 s1 0)
(setq n (getreal "\nnhap mau so: "))
  (prompt "\nchon cac so can sua ...")
	(setq txt (ssget '((0 . "TEXT"))))
 	(repeat (sslength txt)
		(setq txt_name (ssname txt i))
	  	(setq txt_ent (entget txt_name))
		(setq cont (cdr(assoc 1 txt_ent)))
		(setq cont (atof cont))
		(setq s (/ cont n))	  
	  (setq txt_ent  (subst (cons 1 (rtos s)) (assoc 1 txt_ent) txt_ent))
		(entmod txt_ent)
		(setq i (+ i 1))
	);repeat
);defun	
;------------------------------------------------------
