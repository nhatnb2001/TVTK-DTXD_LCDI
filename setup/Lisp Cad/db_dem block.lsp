;; free lisp from cadviet.com
;;; this lisp was downloaded from http://www.cadviet.com/forum/topic/8097-xin-lisp-ve-dem-block/

;;;------------------------------------------------
(defun ss2ent(ss / sodt index ent lstent)
(setq
sodt (if ss (sslength ss) 0)
index 0
)
(repeat sodt
(setq
ent (ssname ss index)
index (1+ index)
lstent (cons ent lstent)
)
)
(reverse lstent)
)
;;;------------------------------------------------
(defun C:DB( / ss Le fn f e Le Ln Bn old X Res) ;;;Dem so luong Blocks
(setq
ss (ssget '((0 . "INSERT")))
Le (ss2ent ss)
fn (getfiled "Save As" "" "txt" 1)
f (open fn "w")
)
(foreach e Le (setq Ln (append Ln (list (cdr (assoc 2 (entget e)))))))
(foreach Bn Ln
(if (setq old (assoc Bn Res))
(setq Res (subst (cons bn (1+ (cdr old))) old Res))
(setq Res (append Res (list (cons Bn 1))))
)
)
(princ "KET QUA:\n\n" f)
(foreach X Res (princ (strcat (car X) " = " (itoa (cdr X)) "\n") f))
(close f)
(startapp "notepad" fn)
(princ)
)
;;;------------------------------------------------

