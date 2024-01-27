;; free lisp from cadviet.com
;;; this lisp was downloaded from http://www.cadviet.com/forum/topic/26622-lisp-tao-mat-cat/
 (Defun c:nc(/ p1 p2 p3 p4 p5 p6 p11 p12 l ang)

	(setq x (getvar "osmode"))

	(setq p1 (getpoint "Diem dau: ")

	      p2 (getpoint p1 "Diem cuoi : "))

	(setq l (distance p1 p2))

	(setq p11 (polar p1 (angle p2 p1) (/ l 5))

	      p12 (polar p2 (angle p1 p2) (/ l 5)))

	(setq ang (angle p1 p2))

	(setq p3 (polar p1 ang (/ l 2.5))

	      p4 (polar p3 (+ (/ pi 2) ang) (/ l 5))

	      p5 (polar p3 ang (/ l 5))

		p6 (polar p5 (- ang (/ pi 2)) (/ l 5)))

	(setvar "osmode" 0)

 (command "pline" p11 p3 p4 p6 p5 p12 "")

 (setvar "osmode" x)

)
