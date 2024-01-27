;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;  http://facebuild.blogspot.com  ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun add_mline ()
(foreach e_record_sub	e_record
(cond ((= 10 (car e_record_sub))
(setq pt1 (cdr e_record_sub) mline_len 0.0)) ((= 11 (car e_record_sub))
(setq pt2 (cdr e_record_sub) mline_len (+ mline_len (distance pt2 pt1))
	  pt1 pt2))))
(setq tot_len (+ tot_len mline_len))
(ssdel e_name ss))

(defun c:td (/ tot_len ss e_name e_record e_type)
(setq tot_len 0.0)
(setq ss (ssget))
(if (null ss)(exit))
(while (> (sslength ss) 0)
(setq e_name (ssname ss 0))
(setq e_record (entget e_name))
(setq e_type (cdr (assoc '0 e_record)))
(cond ((wcmatch e_type "LINE,ARC,CIRCLE,POLYLINE,LWPOLYLINE,ELLIPSE,SPLINE")
(command "lengthen" e_name "")
(setq tot_len (+ tot_len (getvar "PERIMETER")))
(ssdel e_name ss))
((wcmatch e_type "MLINE") (add_mline))(e_type (ssdel e_name ss))))
(prompt (strcat "\nTotal length is: " (rtos tot_len 2 2)))
(princ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;