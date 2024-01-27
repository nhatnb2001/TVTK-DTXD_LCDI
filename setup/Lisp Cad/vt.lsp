;; free lisp from cadviet.com
;;; this lisp was downloaded from https://www.cadviet.com/forum/topic/2403-lisp-v%E1%BA%BD-m%E1%BA%B7t-c%E1%BA%AFt-c%E1%BA%A7u-thang/#entry9799
(defun c:vt( / p c r sb oldos)
 (setq
   p (getpoint "\nVao diem dau tien: ")
   c (getdist p "\nVao chieu cao bac: ")
   r (getdist p "\nVao chieu rong bac: ")
   sb (getint "\nVao so bac: ")
   oldos (getvar "osmode")
 )
 (setvar "osmode" 0)  
 (command ".pline")
 (command p)  
 (repeat sb
   (command (strcat "@0," (rtos c)))
   (command (strcat "@" (rtos r) ",0"))
 )
 (command "")
 (setvar "osmode" oldos)
 (princ)
)
