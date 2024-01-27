;********************************************************************************
;*                                                                           	*
;* 	FILENAME : thay doi cao do tu dong.lsp                                                 *
;*                                                                              *
;* 	FUNCTION : Tro giup thuc hien tinh toan cao do va bang tinh tren ban ve	*
;*									        *
;* 	MODIFIED : TRAN VO DAT-GTVT	        *
;*                                                                              *
;********************************************************************************

;==================== CHANGE OBJECT'S COLOR ==============================

(defun c:1()
  (setq s (ssget))
  (command "chprop" "p" "" "c" 1 "")
)

(defun c:2()
  (setq s (ssget))
  (command "chprop" "p" "" "c" 2 "")
)

(defun c:3()
  (setq s (ssget))
  (command "chprop" "p" "" "c" 3 "")
)

(defun c:4()
  (setq s (ssget))
  (command "chprop" "p" "" "c" 4 "")
)

(defun c:5()
  (setq s (ssget))
  (command "chprop" "p" "" "c" 5 "")
)

(defun c:6()
  (setq s (ssget))
  (command "chprop" "p" "" "c" 6 "")
)

(defun c:7()
  (setq s (ssget))
  (command "chprop" "p" "" "c" 7 "")
)

(defun c:8()
  (setq s (ssget))
  (command "chprop" "p" "" "c" 8 "")
)

(defun c:9()
  (setq s (ssget))
  (command "chprop" "p" "" "c" 9 "")
)

(defun c:10()
  (setq s (ssget))
  (command "chprop" "p" "" "c" 10 "")
)


;;============== Fast command to Zoom  ===========================

(defun c:za() (command "zoom" "a"))
(defun c:ze() (command "zoom" "e"))
(defun c:zz() (command "zoom" "p"))
(defun c:zd() (command "zoom" "d"))
(defun c:xz() (command "zoom" "2x"))
(defun c:zx() (command "zoom" "0.9x"))
(defun c:T0() (command "tilemode" "0"))
(defun c:T1() (command "tilemode" "1"))
(defun c:Ea() (command "Erase" "All" ""))
(defun c:Mn() (command "Move" "All" "" "0,0,0" "-42,0,0"))
(Defun c:Bl1() (Command "Blipmode" "ON" ""))
(Defun c:Bl2() (Command "Blipmode" "OFF" ""))

(defun c:Aa()
   (command "Redraw" "")
   (command "Area")
)

;;================= Cong(tru) mot gia tri vao cac so =======================

(defun c:Congso()
  (setvar "CMDECHO" 0)
  (command "luprec" 0)  
  (setq co (getreal "\n Gia tri de cong vao:"))
  (SETQ SET (SSGET))
  (SETQ QUANT (SSLENGTH SET))
  (SETQ INDEX 0)
  (WHILE (< INDEX QUANT)
  (IF 
	  (AND(= "TEXT" (CDR (ASSOC 0 (SETQ A (ENTGET (SSNAME SET INDEX)))))))      
     (PROGN
		 (setq s (entget (SSNAME SET INDEX)))
		   (setq otext (assoc 1 s))
		   (setq ot (cdr otext))
		   (setq ot (read (substr ot 1 )))
		   (setq nt (cons 1 (rtos (+ ot co))))  
		   (setq s (subst nt otext s))
		   (entmod s)
     )
  	)
  (setq index (+ index 1))
 )
)

;;====================== Nhan cac so voi mot gia tri so ==========================
(defun c:nhanso()
  (setvar "CMDECHO" 0)
  (setq pre (getint "\n Primary units?"))
  (command "luprec" pre)  
  (setq co (getreal "\n Type value to multiply:"))
  (SETQ SET (SSGET))
  (SETQ QUANT (SSLENGTH SET))
  (SETQ INDEX 0)
  (WHILE (< INDEX QUANT)
  (IF 
	  (AND(= "TEXT" (CDR (ASSOC 0 (SETQ A (ENTGET (SSNAME SET INDEX)))))))      
     (PROGN
		 (setq s (entget (SSNAME SET INDEX)))
		   (setq otext (assoc 1 s))
		   (setq ot (cdr otext))
		   (setq ot (read (substr ot 1 )))
		   (setq nt (cons 1 (rtos (* ot co))))  
		   (setq s (subst nt otext s))
		   (entmod s)
     )
  	)
  (setq index (+ index 1))
 )
)

;;====================== Chia cac so cho mot gia tri so ==========================
(defun c:chiaso()
  (setvar "CMDECHO" 0)
  (setq pre (getint "\n Primary units?"))
  (command "luprec" pre)  
  (setq co (getreal "\n Type value to divide:"))
  (SETQ SET (SSGET))
  (SETQ QUANT (SSLENGTH SET))
  (SETQ INDEX 0)
  (WHILE (< INDEX QUANT)
  (IF 
	  (AND(= "TEXT" (CDR (ASSOC 0 (SETQ A (ENTGET (SSNAME SET INDEX)))))))      
     (PROGN
		 (setq s (entget (SSNAME SET INDEX)))
		   (setq otext (assoc 1 s))
		   (setq ot (cdr otext))
		   (setq ot (read (substr ot 1 )))
		   (setq nt (cons 1 (rtos (/ ot co))))  
		   (setq s (subst nt otext s))
		   (entmod s)
     )
  	)
  (setq index (+ index 1))
 )
)

;;====================== Thay cac so bang mot gia tri so ========================
(defun c:thayso()
(setvar "CMDECHO" 0)
 (command "luprec" "3") 
 (SETQ SET (SSGET))
 (setq co (getreal "\n Gia tri thay the:"))
 (SETQ QUANT (SSLENGTH SET))
 (SETQ INDEX 0)
 (WHILE (< INDEX QUANT)
  (IF 
	(AND(= "TEXT" (CDR (ASSOC 0 (SETQ A (ENTGET (SSNAME SET INDEX)))))))      
     (PROGN
		 (setq s (entget (SSNAME SET INDEX)))
		   (setq otext (assoc 1 s))
		   (setq ot (cdr otext))
		   (setq ot (read (substr ot 1 )))
                   (setq nt (cons 1 (rtos co)))  
		   (setq s (subst nt otext s))
		   (entmod s)
     )
  	)
  (setq index (+ index 1))
 )
)


;;=============== Tru mot so cho mot so tren ban ve =========================

(defun c:tru() 
(setvar "CMDECHO" 0)
(setq s (entget (car (entsel "\n Chon vi tri ghi so bi tru: "))))
 (setq otext (assoc 1 s)) 
 (setq ot (cdr otext))
 (setq ot (read (substr ot 1 )))
 (setq s1 (entget (car (entsel "\n Chon vi tri ghi so tru: "))))
 (setq otext1 (assoc 1 s1))
 (setq ot1 (cdr otext1))   
 (setq ot1 (read (substr ot1 1)))
 (setq giatri (entget (car (entsel "\n Chon text de ghi ket qua: "))))
 (command "luprec" "2")
 (setq gia (assoc 1 giatri))
 (setq nt1 (cons 1 (rtos (- ot ot1) )))
   (setq giatri (subst nt1 gia giatri))
   (entmod giatri)
(princ)
)

;;================= Cong mot so them mot so tren ban ve =================

(defun c:cong() 
(setvar "CMDECHO" 0)

;Lay gia tri cua text thu nhat:
 (setq s (entget (car (entsel "\n Chon vi tri ghi so thu nhat: "))))
 (setq otext (assoc 1 s)) 
 (setq ot (cdr otext))
 (setq ot (read (substr ot 1 )))

;Lay gia tri cua text thu hai:
 (setq s1 (entget (car (entsel "\n Chon vi tri ghi so thu hai: "))))
 (setq otext1 (assoc 1 s1))
 (setq ot1 (cdr otext1))   
 (setq ot1 (read (substr ot1 1)))

 (setq giatri (entget (car (entsel "\n Chon text de ghi ket qua: "))))
 (command "luprec" "2")
  (setq gia (assoc 1 giatri))
 (setq nt1 (cons 1 (rtos (+ ot ot1) )))
   (setq giatri (subst nt1 gia giatri))
   (entmod giatri)
(princ)
)
;;================= Nhan mot so voi mot so tren ban ve =================

(defun c:Nhan() 
(setvar "CMDECHO" 0)

;Lay gia tri cua text thu nhat:
 (setq s (entget (car (entsel "\n Chon vi tri ghi so thu nhat: "))))
 (setq otext (assoc 1 s)) 
 (setq ot (cdr otext))
 (setq ot (read (substr ot 1 )))

;Lay gia tri cua text thu hai:
 (setq s1 (entget (car (entsel "\n Chon vi tri ghi so thu hai: "))))
 (setq otext1 (assoc 1 s1))
 (setq ot1 (cdr otext1))   
 (setq ot1 (read (substr ot1 1)))

 (setq giatri (entget (car (entsel "\n Chon text de ghi ket qua: "))))
 (command "luprec" "3")
  (setq gia (assoc 1 giatri))
 (setq nt1 (cons 1 (rtos (* ot ot1) )))
   (setq giatri (subst nt1 gia giatri))
   (entmod giatri)
(princ)
)

;;======== Thay mot so bang mot so khac tren ban ve =================
(defun c:thay() 
(setvar "CMDECHO" 0)
(Setq ot 0)
(While
 (setq s1 (entget (car (entsel "\n Chon gia tri de thay:"))))
 (setq otext1 (assoc 1 s1))
 (setq ot1 (cdr otext1))   
 (setq ot1 (read (substr ot1 1)))
(setq giatri (entget (car (entsel "\n Chon so duoc thay: "))))
  (setq gia (assoc 1 giatri))
  (setq nt1 (cons 1 (rtos ot1)))
  (setq giatri (subst nt1 gia giatri))
  (entmod giatri)
)

(princ)
)

;;======== Thay nhieu so bang cung oan thang =================

(defun c:Dodoc() 
(setvar "CMDECHO" 0)

(Setq P1 (Getpoint "\n Pick first point:")
      P2 (Getpoint P1 "\n Pick second point:\n")
      Ds1 (abs (- (Car P2) (Car P1)))
      Ds2 (abs (- (Cadr P2) (Cadr P1)))
      Doc (* (/ Ds2 Ds1) 100)
 )
(prompt "\n Gradient of line (%):") Doc 
)


;;================== Noi suy cao do ==================================
(Defun c:NsCD() 
(setvar "CMDECHO" 0)

  (if (= tl nil) 
    (progn
     (setq tl (getreal "\n Chon ti le ban ve : "))
     (setq tl1 (/ 100 tl))
    )
  )

;Lay khoang cach giua 2 diem tren ban ve:
(Setq P1 (Getpoint "\n Chon diem thu nhat:")
      P2 (Getpoint P1 "\n Chon diem thu hai:")
      Ds1 (/ (abs (- (Car P2) (Car P1))) tl1)
      Ds2 (/ (- (Cadr P2) (Cadr P1)) tl1)
 )

;;Gan khoang cach tren cho Text:
  (setq giatri (entget (car (entsel "\n Chon text tren ban ve de ghi gia tri khoang cach 2 diem vua chon: "))))
  (setq gia (assoc 1 giatri))
  (setq nt1 (cons 1 (rtos Ds1)))
  (setq giatri (subst nt1 gia giatri))
  (entmod giatri)


;;Lay gia tri cua text cao do tren ban ve:
 (setq s1 (entget (car (entsel "\n Chon Text lam gia tri co so: "))))
 (setq otext1 (assoc 1 s1))
 (setq ot1 (cdr otext1))   
 (setq ot1 (read (substr ot1 1)))

; (setq pre (getint "\nSo chu so sau dau phay?"))
  (command "luprec" "3")

;Gan gia tri cao do noi suy duoc cho text tren ban ve: 
  (setq giatri (entget (car (entsel "\n Chon Text de gan gia tri moi: "))))
  (setq gia (assoc 1 giatri))
;---------------------------------------------------------------------------------
  (Setq TextValue (+ ot1 Ds2))		;(Cong thuc xac dinh gia tri text)
;---------------------------------------------------------------------------------
  (setq nt1 (cons 1 (rtos TextValue)))
  (setq giatri (subst nt1 gia giatri))
  (entmod giatri)

 (princ)
 )

;;================= Tick cao do theo cao do da biet tren ban ve =================
(Defun c:e1() 
(setvar "CMDECHO" 0)
  (if (= tl nil) 
    (progn
     (setq tl (getreal "\n Drawing scale : "))
     (setq tl1 (/ 100 tl))
    )
  )

(Setq P1 (Getpoint "\n chon diem co cao do da biet:"))
 (setq s1 (entget (car (entsel "\n chon text cao do da biet:"))))
 (setq otext1 (assoc 1 s1))
 (setq ot1 (cdr otext1))   
 (setq ot1 (read (substr ot1 1)))

(while
(Setq P2 (Getpoint "\n chon diem can lay cao do:")
      Ds (/ (- (Cadr P2) (Cadr P1)) tl1)
 )

(command "luprec" "2")

;Gan gia tri cao do noi suy duoc cho text tren ban ve: 
  (setq giatri (entget (car (entsel "\n chon text hien thi cao do:"))))
  (setq gia (assoc 1 giatri))
;---------------------------------------------------------------------------------
  (Setq TextValue (+ ot1 Ds))		;(Cong thuc xac ®inh gia tri text)
;---------------------------------------------------------------------------------
  (setq nt1 (cons 1 (rtos TextValue)))
  (setq giatri (subst nt1 gia giatri))
  (entmod giatri)
)
 (princ)
 )

;******************
(defun c:e2() 
(setvar "CMDECHO" 0)

;LÊy kho¶ng c¸ch gi÷a 2 ®iÓm trªn b¶n vÏ:
(Setq P1 (Getpoint "\n Chon diem 1:")
      P2 (Getpoint P1 "\n Chon diem 2:")
      Ds1 (abs (- (Car P2) (Car P1))) 
)
(command "luprec" "2")
;G¸n kho¶ng c¸ch trªn cho Text:
  (setq giatri (entget (car (entsel "\n Chon text thay gia tri: "))))
  (setq gia (assoc 1 giatri))
  (setq nt1 (cons 1 (rtos Ds1 )))
  (setq giatri (subst nt1 gia giatri))
  (entmod giatri)
(command "luprec" "2")

)
(Setq P1 (Getpoint "\n Chon diem 1:")
      P2 (Getpoint P1 "\n Chon diem 2:")
      Ds1 (abs (- (Car P2) (Car P1))) 
)
(command "luprec" "2")
;G¸n kho¶ng c¸ch trªn cho Text:
  (setq giatri (entget (car (entsel "\n Chon text thay gia tri: "))))
  (setq gia (assoc 1 giatri))
  (setq nt1 (cons 1 (rtos Ds1 )))
  (setq giatri (subst nt1 gia giatri))
  (entmod giatri)
(command "luprec" "2")

)
(Setq P1 (Getpoint "\n Chon diem 1:")
      P2 (Getpoint P1 "\n Chon diem 2:")
      Ds1 (abs (- (Car P2) (Car P1))) 
)
(command "luprec" "2")
;G¸n kho¶ng c¸ch trªn cho Text:
  (setq giatri (entget (car (entsel "\n Chon text thay gia tri: "))))
  (setq gia (assoc 1 giatri))
  (setq nt1 (cons 1 (rtos Ds1 )))
  (setq giatri (subst nt1 gia giatri))
  (entmod giatri)
(command "luprec" "2")

)
(Setq P1 (Getpoint "\n Chon diem 1:")
      P2 (Getpoint P1 "\n Chon diem 2:")
      Ds1 (abs (- (Car P2) (Car P1))) 
)
(command "luprec" "2")
;G¸n kho¶ng c¸ch trªn cho Text:
  (setq giatri (entget (car (entsel "\n Chon text thay gia tri: "))))
  (setq gia (assoc 1 giatri))
  (setq nt1 (cons 1 (rtos Ds1 )))
  (setq giatri (subst nt1 gia giatri))
  (entmod giatri)
(command "luprec" "2")

)
(Setq P1 (Getpoint "\n Chon diem 1:")
      P2 (Getpoint P1 "\n Chon diem 2:")
      Ds1 (abs (- (Car P2) (Car P1))) 
)
(command "luprec" "2")
;G¸n kho¶ng c¸ch trªn cho Text:
  (setq giatri (entget (car (entsel "\n Chon text thay gia tri: "))))
  (setq gia (assoc 1 giatri))
  (setq nt1 (cons 1 (rtos Ds1 )))
  (setq giatri (subst nt1 gia giatri))
  (entmod giatri)
(command "luprec" "2")

)		
;DÊu kÕt thóc file

  ;;;;********************** LÖnh dãng hµng TEXT *********************
(defun c:dht (/ thop dtmau dt p1 i p delta dong)
 (setq thop (ssget)) 
 (setq dtmau (car (entsel "\nChon doi tuong lam mau:")))
 (setq dchuan (cdr (assoc 10 (entget dtmau))))
 (initget 1 "N D")
 (setq dong (strcase (getkword "\nBan muon dong theo phuong Ngang hay Doc?/(N, D):")))
 (setq i 0)
 (repeat (sslength thop)
   (setq dt (ssname thop i))
   (setq p (cdr (assoc 10 (entget dt))))
   (cond
    (
        (= dong "D")
     (progn
     (setq delta (- (car p) (car dchuan)) )
     (setq p1 (mapcar '- p (list delta 0.0 0.0)))
      )
   )
   
   (T 
(progn
     (setq delta (- (cadr p) (cadr dchuan)) )
     (setq p1 (mapcar '- p (list 0.0 delta 0.0)))
   ))
   );;; end cond
   (command "move" dt "" p p1)
   (setq i (1+ i))
 );;; end repeat
 (princ)
)