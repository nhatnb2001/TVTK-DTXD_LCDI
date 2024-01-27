;; free lisp from cadviet.com
;;; this lisp was downloaded from http://www.cadviet.com/forum/topic/8204-scale-theo-truc-x-va-y/
;XSCALE Scale the mot chieu lenhtat :XSC

(DEFUN EXCUTE()

  (setq oldvalue (getvar "CMDECHO"))

  (setvar "CMDECHO" 0)

  (princ "Chon doi tuong can scale: ")

  (setq ss (ssget))

  (setq P0 (getpoint "\nChon diem goc: "))

  (initget 1 "X Y X S")

  (setq C (getkword "\nScale theo [X,Y,Z,Scale]?<X/Y/Z/S> :"))

  (setq hs (getreal "Cho biet he so scale: "))

  (DELBLOCK "vkc_temp")

  (CREATEBLOCK ss P0)  

  (Command "-Insert" "vkc_temp" C hs P0 "")   

  (setq dt (entlast))

  (Command "Explode" dt)

  (setvar "CMDECHO" oldvalue)

  (princ)

)

(DEFUN CREATEBLOCK(ss P)

  (command "-Block" "vkc_temp" P ss "")

)



(DEFUN DELBLOCK (bname)

  (if (IsExistBlock bname)

	(Command "-Purge" "B" bname "Y" "Y")	

  )

)

(DEFUN IsExistBlock(bname / kq)

  (setq kq Nil)

  (setq n (length LiBlk))

  (setq i 0)

  (while (< i n)

	(if (= bname (nth i LiBlk))

	  (progn

	(setq i n)

	(setq kq T)

	  )	

	)

	(setq i (1+ i))

  )

  kq

)

(DEFUN CREALIBLK (/ NL)

  (setq LiBlk (List))

  (setq NL (tblnext "BLOCK" T))  

  (while NL	

	(setq LiBlk (append LiBlk (list (cdr (assoc 2 NL)))))

	(setq NL (tblnext "BLOCK"))

  )

  (setq LiBlk (Acad_strlsort LiBlk))

)

(DEFUN C:XSCALE()

  (CREALIBLK)

  (EXCUTE)

)

(DEFUN C:XSC()

  (CREALIBLK)

  (EXCUTE)

)
