
(Defun c:rdt (/ ss doituong dsl dc ddd chondd chieudaicuver diemdau diemcuoi krai chieudaidoan slc sl index d2 p2 d5 p5 d3 p3 dt l m)
(vl-load-com)
(command "undo" "be")
(command "ucs" "")
(chonnhomdoituong)
(choncuver)

(setq diemchuan (vlax-curve-getPointAtDist chondd 0))
(setq diemdinhhuong (vlax-curve-getPointAtDist chondd chieudaicuver))

(setq chieudaitinh chieudaicuver) 
(setq dautinh +)        

(setq thuchienrai raikieukhongtext)
(hoikieuraicd)
(command "ucs" "p")
(command "undo" "end")
  (princ)
)
;;;;;;;;;;;;;;;;;
(Defun c:dtd (/ ss doituong dsl dc ddd chondd chieudaicuver diemdau diemcuoi krai chieudaidoan slc sl index d2 p2 d5 p5 d3 p3 dt l m daidendiem)
(vl-load-com)
(command "undo" "be")
(command "ucs" "")
(choncuver)
(cdxuatphatdo)
(cdketthucdo)
(Cond
((< daidendiemdo daidenhuongdo) (setq chieudaidoan (- daidenhuongdo daidendiemdo)))           
((> daidendiemdo daidenhuongdo) (setq chieudaidoan (- daidendiemdo daidenhuongdo)))
) 
(command "undo" "end")
(princ (strcat "\nChieu dai doan do la: " (rtos chieudaidoan 2 4))) 
  (princ)
)
;;;;;;;;;;;;;;;;;
(Defun c:rt (/ ss doituong dsl dc ddd chondd chieudaicuver diemdau diemcuoi krai chieudaidoan slc sl index d2 p2 d5 p5 d3 p3 dt l m daidendiem)
(vl-load-com)
(command "undo" "be")
(command "ucs" "")
(chonnhomdoituongtext)

  (princ "\nChon doi tuong rai kem theo text <ko can thi enter^_^>:")
  (setq ss (ssget))
 (cond 
      ((= ss nil) (setq thuchienrai raikieutextkokem))
      ((/= ss nil) (setq thuchienrai raikieutextcokem))) 

(choncuver)
(chondiemxuatphat)
;(setq thuchienrai raikieutext)
(hoikieuraicd)
(command "ucs" "p")
(command "undo" "end")
  (princ)
)
;;;;;;;;;;;;;;;;;
(Defun c:rtd (/ ss doituong dsl dc ddd chondd chieudaicuver diemdau diemcuoi krai chieudaidoan slc sl index d2 p2 d5 p5 d3 p3 dt l m daidendiem)
(vl-load-com)
(command "undo" "be")
(command "ucs" "")
(chonnhomdoituong)
(choncuver)
(chondiemxuatphat)
(setq thuchienrai raikieukhongtext)
(hoikieuraicd)
(command "ucs" "p")
(command "undo" "end")
  (princ)
)
;;;;;;;;;;;;;;;;;
(Defun chondiemchuandoituong ()
(setq dc (getpoint "\nChon diem goc: "))
 (cond 
      ((= dc nil) (princ "\nChua chon duoc diem goc:") (chondiemchuandoituong))
      ((/= ss nil))) 
  (princ)
)
;;;;;;;;;;;;;;;;;
(Defun chonnhomdoituongtext ()
  (if (null congthem)(setq congthem "1"))
(setq ddd (entsel "\nChon text mau"))
(while
 (or
   (null ddd)
   (/= "TEXT" (cdr (assoc 0 (entget (car ddd)))))
)
(princ "\nDoi tuong khong phai la text! Chon lai")
(setq ddd (entsel "\nChon text mau"))
)
  (setq sst (car ddd))
  (setq DTTT (entget sst))
  (setq NDTTT (cdr (assoc 1 DTTT)))
 (Setq temp T)
(While temp
 (setq dc (strcat "\nDon vi cong them la(" congthem ")<Chon diem chuan>: "))  
 (Initget "D")
 (setq str (getpoint dc))
 (Cond
  ((= str "D") (setq congthem (getstring (strcat"\nDon vi cong them la <" congthem "> :"))))
   (Progn
  (Setq dc str)
   (setq temp nil)
  )
 )
)
  (princ)
)

;;;;;;;;;;;;;;;;;
(Defun dotructiep ()
(cdxuatphatdo)
(cdketthucdo)
(Cond
((< daidendiemdo daidenhuongdo) (setq chieudaidoan (- daidenhuongdo daidendiemdo)))           
((> daidendiemdo daidenhuongdo) (setq chieudaidoan (- daidendiemdo daidenhuongdo)))
) 
  (princ)
)
;;;;;;;;;;;;;;;;;
(Defun cdxuatphatdo ()
(setq luubatdiem (getvar "osmode"))
(setvar "osmode" 545)
(setq diemchuando (getpoint "\nTu diem <tren duong dan>:"))
(setvar "osmode" 0)
(setq daidendiemdo (vlax-curve-getDistAtPoint chondd diemchuando))
(setvar "osmode"luubatdiem)
 (cond 
      ((= daidendiemdo nil) (princ "\nDiem vua chon khong nam tren duong dan, chon lai:") (cdxuatphatdo))
      ((/= daidendiemdo nil))) 
  (princ)
)
;;;;;;;;;;;;;;;;;
(Defun cdketthucdo ()
(setq luubatdiem (getvar "osmode"))
(setvar "osmode" 545)
(setq diemdinhhuongdo (getpoint diemchuando"\nDen diem <tren duong dan>:"))
(setvar "osmode" 0)
(setq daidenhuongdo (vlax-curve-getDistAtPoint chondd diemdinhhuongdo))
(setvar "osmode"luubatdiem)
 (cond 
      ((= daidenhuongdo nil) (princ "\nDiem vua chon khong nam tren duong dan, chon lai:") (cdketthucdo))
      ((/= daidenhuongdo nil))) 
  (princ)
)
;;;;;;;;;;;;;;;;;
(Defun cdxuatphat ()
(setq luubatdiem (getvar "osmode"))
(setvar "osmode" 545)
(setq diemchuan (getpoint "\nDiem bat dau rai tren duong dan:"))
(setvar "osmode" 0)
(setq daidendiem (vlax-curve-getDistAtPoint chondd diemchuan))
(setvar "osmode"luubatdiem)
 (cond 
      ((= daidendiem nil) (princ "\nDiem vua chon khong nam tren duong dan, chon lai:") (cdxuatphat))
      ((/= daidendiem nil))) 
  (princ)
)
;;;;;;;;;;;;;;;;;
(Defun cdketthuc ()
(setq luubatdiem (getvar "osmode"))
(setvar "osmode" 545)
(setq diemdinhhuong (getpoint diemchuan"\nDiem ket thuc rai tren duong dan:"))
(setvar "osmode" 0)
(setq daidenhuong (vlax-curve-getDistAtPoint chondd diemdinhhuong))
(setvar "osmode"luubatdiem)
 (cond 
      ((= daidenhuong nil) (princ "\nDiem vua chon khong nam tren duong dan, chon lai:") (cdketthuc))
      ((/= daidenhuong nil))) 
  (princ)
)
;;;;;;;;;;;;;;;;;
(Defun thongbaoketqua ()
(princ (strcat "\nChieu dai doan la: " (rtos chieudaitinh 2 4) doanhienthinoidung)) 
  (princ)
)
;;;;;;;;;;;;;;;;;
(Defun chondiemxuatphat ()
(cdxuatphat)
(cdketthuc)
(Cond
((< daidendiem daidenhuong) (setq chieudaitinh (- daidenhuong daidendiem)) (setq dautinh +))           
((> daidendiem daidenhuong) (setq chieudaitinh (- daidendiem daidenhuong)) (setq dautinh -))
) 
(setq doanxuatphat daidendiem)
  (princ)
)
;;;;;;;;;;;;;;;;;
(Defun hoikieuraicd ()
  (setq kraicd (strcase (getstring "\nKieu rai theo: Tinh /So luong/<Khoang cach>")))

(Cond
((= kraicd "T") (raisoluongtinh))
((/= kraicd "T") 
   (Cond
   ((= kraicd "S") (raisoluongcd))
   ((/= kraicd "S") (raikhoangcachcd))
   ) 
)
) 
  (princ)
)
;;;;;;;;;;;;;;
(Defun raisoluongtinh ()
   (setq slrai (getreal "\nRai them may lan khong tinh doi tuong tai diem bat dau rai:"))
   (setq chieudaidoan (GETDIST "\nKhoang cach 1 lan rai: <Nhap 0 de do tren duong dan>"))
   (Cond
   ((= chieudaidoan 0) (dotructiep)))

   (setq tongdoan (* slrai chieudaidoan))
   (Cond
   ((> tongdoan chieudaitinh) 
(princ (strcat "\nChieu dai doan la: " (rtos chieudaitinh 2 4) ", Yeu cau la: " (rtos chieudaidoan 2 4) "x" (rtos slrai 2 0) "=" (rtos tongdoan 2 4))) 
(princ "\nVuot qua chieu dai cho phep, nhap lai:") 
(raisoluongtinh))
   ((< tongdoan chieudaitinh) 
    (setq sl (fix (+ slrai 1)))
    (setq sl (fix sl))
(setq doanhienthinoidung (strcat "\nDa thuc hien rai: " (rtos slrai 2 0) " lan voi khoang cach " (rtos chieudaidoan 2 4))) 
(thuchienrai)
   )
   ) 
  (princ)
)
;;;;;;;;;;;;;;
(Defun raikhoangcachcd ()
   (setq chieudaidoan (GETDIST "\nKhoang cach 1 lan rai: <Nhap 0 de do tren duong dan>"))
   (Cond
   ((= chieudaidoan 0) (dotructiep)))
   (Cond
   ((> chieudaidoan chieudaitinh) 
(princ (strcat "\nChieu dai doan la: " (rtos chieudaitinh 2 4) ", Yeu cau la: " (rtos chieudaidoan 2 4))) 
(princ "\nVuot qua chieu dai cho phep, nhap lai:") 
(raikhoangcachcd))
   ((< chieudaidoan chieudaitinh) 
   (setq sol (+ (/ chieudaitinh chieudaidoan) 1))
    (setq sl (fix sol))
    (setq sl (fix sl))
(setq doanhienthinoidung (strcat "\nDa thuc hien rai: " (rtos sol 2 0) " lan voi khoang cach " (rtos chieudaidoan 2 4))) 
(thuchienrai)
   )
   ) 
  (princ)
)
;;;;;;;;;;;;;;
(Defun raisoluongcd ()
(setq slc (getreal "\nChia duong dan thanh may lan:"))
(setq chieudaidoan (/ chieudaitinh slc))
(setq sl (fix (+ 1 slc)))
(setq doanhienthinoidung (strcat "\nDa thuc hien rai: " (rtos slc 2 0) " lan voi khoang cach " (rtos chieudaidoan 2 4))) 
(thuchienrai)
  (princ)
)
;;;;;;;;;;;;;;
(Defun chonnhomdoituong ()
  (princ "\nChon doi tuong rai:")
  (setq ss (ssget))

 (cond 
      ((= ss nil) (princ "\nChua chon duoc doi tuong nao:") (chonnhomdoituong))
      ((/= ss nil) 
 (setq dsl (sslength ss))
            (cond 
            ((= dsl 1) 
(setq doituong (ssname SS 0))
(setq doituong (entget doituong))
(setq KIEUDOITUONG (cdr (assoc 0 doituong)))
                   (cond 
                   ((= KIEUDOITUONG "INSERT") (setq dc (cdr (assoc 10 doituong))))
                   ((/= KIEUDOITUONG "INSERT") (chondiemchuandoituong))
                   );ketthuccondxemblock
                 );kethucdsl1
            ((/= dsl 1) (chondiemchuandoituong))
            );ketthuccondnho

);ketthucsetqdsl
 );ketthuccondtong  
  (princ)
)
;;;;;;;;;;;;;;;;;
(Defun chondiemchuandoituong ()
(setq dc (getpoint "\nChon diem goc: "))
 (cond 
      ((= dc nil) (princ "\nChua chon duoc diem goc:") (chondiemchuandoituong))
      ((/= ss nil))) 
  (princ)
)
;;;;;;;;;;;;;;;;;
(Defun choncuver ()

(setq ddd (entsel "\nChon duong dan:"))
(while
(or
(null ddd)
(or (= "TEXT" (cdr (assoc 0 (entget (car ddd))))) (= "MTEXT" (cdr (assoc 0 (entget (car ddd))))) (= "HATCH" (cdr (assoc 0 (entget (car ddd))))) (= "INSERT" (cdr (assoc 0 (entget (car ddd))))) (= "REGION" (cdr (assoc 0 (entget (car ddd))))) (= "DIMENSION" (cdr (assoc 0 (entget (car ddd)))))
)
)
(setq ddd (entsel "\nDoi tuong khong the lam duong dan! Chon lai"))
)

(setq chondd (car ddd))
(setq luubatdiem (getvar "osmode"))
  (setvar "osmode" 0)
(setq chieudaicuver (vlax-curve-getDistAtParam chondd (vlax-curve-getEndParam chondd)))
(setq doanxuatphat 0)
(setvar "osmode"luubatdiem)
  (princ)
)
;;;;;;;;;;;;;;
(Defun raikieukhongtext (/ quaykhong)

  (setq quaykhong (strcase (getstring "\nCo quay doi tuong vuong goc voi duong dan khong: Khong/<Co>")))
(Cond
((= quaykhong "K") (setq copygiua copykoquay))
((/= quaykhong "K")(setq copygiua copyquay))
) 

(setq index -1)

  (repeat sl
(setq index (1+ index))
(setq d2 (dautinh doanxuatphat (* chieudaidoan index)))
(setq luubatdiem (getvar "osmode"))
  (setvar "osmode" 0)
(setq p2 (vlax-curve-getPointAtDist chondd d2))
(setvar "osmode"luubatdiem)
(copygiua)
  )
(thongbaoketqua)
  (princ)
)
;;;;;;;;;;;;;;;;;;;;;;;;
(defun copycuoiquay()
(setq luubatdiem (getvar "osmode"))
  (setvar "osmode" 0)
(setq d5 (- (dautinh doanxuatphat (* chieudaidoan index)) 0.01))
(setq p5 (vlax-curve-getPointAtDist chondd d5))
 (setq L 0)
 (setq M (sslength ss))
 (while (< L M)
   (setq DT (ssname ss L))
   (command ".copy" DT "" dc p2)
   (command ".rotate" "last" "" p2 p5)
   (command ".rotate" "last" "" p2 180)
   (setq L (1+ L))
)
(setvar "osmode"luubatdiem)
(princ)
)
;;;;;;;;;;;;;;;;;;;;;;;;
(defun COPYQUAY(/ p3)
(setq luubatdiem (getvar "osmode"))
  (setvar "osmode" 0)
(setq d3 (+ (dautinh doanxuatphat (* chieudaidoan index)) 0.001))
(setq p3 (vlax-curve-getPointAtDist chondd d3))
(setvar "osmode"luubatdiem)
(Cond
((= p3 nil) (copycuoiquay))
((/= p3 nil) 
 (setq L 0)
 (setq M (sslength ss))
(setq luubatdiem (getvar "osmode"))
  (setvar "osmode" 0)
 (while (< L M)
   (setq DT (ssname ss L))
   (command ".copy" DT "" dc p2)
   (command ".rotate" "last" "" p2 p3)
   (setq L (1+ L))
)
(setvar "osmode"luubatdiem)
)
) 


(princ)
)
;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;
(Defun raikieutextcokem (/ quaykhong)

  (setq quaykhong (strcase (getstring "\nCo quay doi tuong vuong goc voi duong dan khong: Khong/<Co>")))
(Cond
((= quaykhong "K") (setq copygiuatext copykoquaytext) (setq copygiua copykoquay))
((/= quaykhong "K")(setq copygiuatext copyquaytext) (setq copygiua copyquay))
) 

(setq index -1)

  (repeat sl
(setq index (1+ index))
(setq d2 (dautinh doanxuatphat (* chieudaidoan index)))
(setq luubatdiem (getvar "osmode"))
  (setvar "osmode" 0)
(setq p2 (vlax-curve-getPointAtDist chondd d2))
(setvar "osmode"luubatdiem)
(copygiuatext)
(copygiua)
  )
(thongbaoketqua)
  (princ)
)
;;;;;;;;;;;;;;
(Defun raikieutextkokem (/ quaykhong)

  (setq quaykhong (strcase (getstring "\nCo quay doi tuong vuong goc voi duong dan khong: Khong/<Co>")))
(Cond
((= quaykhong "K") (setq copygiuatext copykoquaytext))
((/= quaykhong "K")(setq copygiuatext copyquaytext))
) 

(setq index -1)

  (repeat sl
(setq index (1+ index))
(setq d2 (dautinh doanxuatphat (* chieudaidoan index)))
(setq luubatdiem (getvar "osmode"))
  (setvar "osmode" 0)
(setq p2 (vlax-curve-getPointAtDist chondd d2))
(setvar "osmode"luubatdiem)
(copygiuatext)
  )
(thongbaoketqua)
  (princ)
)
;;;;;;;;;;;;;;;;;;;;;;;;
(defun copycuoiquaytext ()
(setq luubatdiem (getvar "osmode"))
  (setvar "osmode" 0)
(setq d5 (- (dautinh doanxuatphat (* chieudaidoan index)) 0.01))
(setq p5 (vlax-curve-getPointAtDist chondd d5))
   (command ".copy" sst "" dc p2)
   (command ".rotate" "last" "" p2 p5)
   (command ".rotate" "last" "" p2 180)
 (setq congthems (atoi congthem)) 
  (setq DTDM (entlast))

   (if (and (>= (ascii NDTTT) 48) (<= (ascii NDTTT) 57))
       (setq NDTTT (itoa (+ (atoi NDTTT) congthems)))
       (setq NDTTT (chr (+ (ascii NDTTT) congthems)))
   )

   (setq Elist (entget DTDM)) 
   (setq Oldlist (assoc 1 Elist)) 
   (setq Oldtext (cdr Oldlist))
   (setq Oldtext (strcase Oldtext nil))
   (setq Newlist (cons '1 NDTTT))
   (setq Elist (subst Newlist Oldlist Elist))
   (entmod Elist)
(setvar "osmode"luubatdiem)
(princ)
)
;;;;;;;;;;;;;;;;;;;;;;;;
(defun COPYQUAYtext (/ p3)
(setq luubatdiem (getvar "osmode"))
  (setvar "osmode" 0)
(setq d3 (+ (dautinh doanxuatphat (* chieudaidoan index)) 0.001))
(setq p3 (vlax-curve-getPointAtDist chondd d3))
(setvar "osmode"luubatdiem)
(Cond
((= p3 nil) (copycuoiquaytext))
((/= p3 nil) 
(setq luubatdiem (getvar "osmode"))
  (setvar "osmode" 0)
   (command ".copy" sst "" dc p2)
   (command ".rotate" "last" "" p2 p3)


 (setq congthems (atoi congthem)) 
  (setq DTDM (entlast))

   (if (and (>= (ascii NDTTT) 48) (<= (ascii NDTTT) 57))
       (setq NDTTT (itoa (+ (atoi NDTTT) congthems)))
       (setq NDTTT (chr (+ (ascii NDTTT) congthems)))
   )

   (setq Elist (entget DTDM)) 
   (setq Oldlist (assoc 1 Elist)) 
   (setq Oldtext (cdr Oldlist))
   (setq Oldtext (strcase Oldtext nil))
   (setq Newlist (cons '1 NDTTT))
   (setq Elist (subst Newlist Oldlist Elist))
   (entmod Elist)
(setvar "osmode"luubatdiem)
)
) 


(princ)
)
;;;;;;;;;;;;;;;;;;;;;;;;
(defun COPYKOQUAYtext ()
(setq luubatdiem (getvar "osmode"))
  (setvar "osmode" 0)
(command ".copy" sst "" dc p2 "")
 (setq congthems (atoi congthem)) 
  (setq DTDM (entlast))

   (if (and (>= (ascii NDTTT) 48) (<= (ascii NDTTT) 57))
       (setq NDTTT (itoa (+ (atoi NDTTT) congthems)))
       (setq NDTTT (chr (+ (ascii NDTTT) congthems)))
   )

   (setq Elist (entget DTDM)) 
   (setq Oldlist (assoc 1 Elist)) 
   (setq Oldtext (cdr Oldlist))
   (setq Oldtext (strcase Oldtext nil))
   (setq Newlist (cons '1 NDTTT))
   (setq Elist (subst Newlist Oldlist Elist))
   (entmod Elist)
(setvar "osmode"luubatdiem)
(princ)
)
;;;;;;;;;;;;;;
