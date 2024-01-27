;; free lisp from cadviet.com
;;; this lisp was downloaded from http://www.cadviet.com/forum/index.php?showtopic=33112
(defun Length1(e) (vlax-curve-getDistAtParam e (vlax-curve-getEndParam e)))
;;;--------------------------------------------------------------------
(defun C:TL( / ss L e)
(setq
ss (ssget (list (cons 0 "LINE,ARC,CIRCLE,POLYLINE,LWPOLYLINE,ELLIPSE,SPLINE")))
L 0.0
)
(vl-load-com)
(while (setq e (ssname ss 0))
(setq L (+ L (length1 e)))
(ssdel e ss)
)
(alert (strcat "Total length = " (rtos L)))
)
