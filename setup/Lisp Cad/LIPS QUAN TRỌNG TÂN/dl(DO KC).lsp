;; free lisp from cadviet.com
;;; this lisp was downloaded from http://www.cadviet.com/forum/topic/76109-nho-viet-them-xuat-ra-text-cho-lisp/
(defun c:dl()
(setq po1 (getpoint "\n Pick diem A :"))
(setq po2 (getpoint po1 "\n Pick diem B :"))
(setq S (+ (distance po1 po2)))
(while 
(setq po4 (getpoint po2 "\n Pick diem tiep theo de tinh khoang cach/ Enter de ket thuc :"))
(setq S (+ S (distance po1 po2)))
)
(alert (strcat "Tong S = " (rtos S)))
(setq txt (car (entsel "\n Chon text muon thay the"))
         elst (entget txt)
         elst (subst (cons 1 (rtos S 2 2)) (assoc 1 elst) elst)
)
(entmod elst)
(princ)
)
