;; free lisp from cadviet.com
;;; this lisp was downloaded from http://www.cadviet.com/forum/topic/13677-yeu-cau-lisp-chuyen-cac-doi-tuong-ve-1-layer/
(defun CHANGE-LAYER (_TYPE LAYER / OBJS)

 (setq OBJS (ssget "X" (list (cons 0 _TYPE))))

 (if (not (tblsearch "layer" LAYER))

  (command ".layer" "m" LAYER "")

 );_ end if

 (command ".chprop" OBJS "" "la" LAYER "")

 (princ)

);_ end defun

(defun C:D2D (/ OBJS) (CHANGE-LAYER "DIMENSION" "DIM"))

(defun C:H2H (/ OBJS) (CHANGE-LAYER "HATCH" "HATCH"))

(defun C:B2B (/ OBJS) (CHANGE-LAYER "INSERT" "BLOCK"))

(defun C:T2T (/ OBJS) (CHANGE-LAYER "*TEXT" "TEXT"))
