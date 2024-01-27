;; free lisp from cadviet.com
;;; this lisp was downloaded from http://www.cadviet.com/forum/index.php?showtopic=6249
 (defun C:CT (/ name_op num_op_chon point_base_st point_new_st num_ op_tang 
                  op_tang_new last_ch cong_val)
(setq old_ts_err *error*)
(setvar "Cmdecho" 0)
(if(= cong_vao NIL)(setq cong_vao 1))
(Prompt "\n Neu tham so < 0  --> ket qua giam ! ")
(setq cong_val(getint(strcat "\n Tham so tang /<" (itoa cong_vao)">: ") ))
      (if(= cong_val NIL)(setq cong_val cong_vao)(setq cong_vao cong_val))
(Prompt "\n Chon doi tuong tang: ") 
(if(and cong_vao (setq op_tang(ssget)))
   (progn
    (setq num_op_chon(sslength op_tang)
          num_ 0 
          op_tang_new NIL)
    (if(setq point_base_st(getpoint "\n > Diem goc: "))
       (while 
       (setq point_new_st(getpoint "\n >> Diem dat tiep theo: " point_base_st)) 
          (if op_tang_new (setq op_tang op_tang_new op_tang_new NIL))
          (setq num_op_chon(sslength op_tang) op_tang_new(ssadd))
          (if(and point_base_st point_new_st)
             (progn
              (repeat num_op_chon
                (progn
                   (setq name_op(ssname op_tang num_))
                   (command "_.Copy" name_op "" point_base_st point_new_st)
		   (setq last_ch(entlast)
                         op_tang_new(ssadd last_ch op_tang_new))
                   (process)
                   (setq num_ (+ 1 num_))
                     (if(= num_ num_op_chon)(setq num_ 0))
                )
              ) 
             )
          );if
          (setq point_base_st point_new_st)
       ));if while
   );progn
);if  
(setq *error* old_ts_err)
(princ)
);End Tang.
(defun process (/ name_check text_value dat_up dat_style num_value new_value)
(progn
              (setq name_check(assoc 0 (setq dat_up (entget last_ch))) )
              (if(or(= (cdr name_check) "TEXT")
                    (= (cdr name_check) "MTEXT"))
                 (progn
                   (setq text_value(assoc 1 dat_up))
                   (if(= (distof (cdr text_value) 2) NIL)
                      (setq dat_style "Text")
                      (setq dat_style "Num" num_value (atof (cdr text_value)) )
                   )
                   (cond
                      ((= dat_style "Num")
                       (setq new_value (itoa (fix(+ num_value cong_vao))) ))
                      ((= dat_style "Text")
                       (setq new_value(chr (+ (ascii (cdr text_value)) cong_vao))) )
                   )
                   (setq dat_up(subst (cons '1 new_value) text_value dat_up) )
                   (entmod dat_up)
                 );progn 
              );if
              (setq name_op NIL)
);progn
);Process.
 
