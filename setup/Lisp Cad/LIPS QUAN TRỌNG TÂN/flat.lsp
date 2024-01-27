;; free lisp from cadviet.com
;;; this lisp was downloaded from http://www.cadviet.com/forum/topic/54646-yeu-cau-chuyen-cao-do-z-cua-cac-loai-doi-tuong-ve-z-0/
(defun c:flat ( / acsel elv ) (vl-load-com)
  (if (ssget "_X" (list (cons 410 (getvar 'CTAB))))
	(progn
  	(vlax-for obj
    	(setq acsel
      	(vla-get-ActiveSelectionSet
        	(vla-get-ActiveDocument (vlax-get-acad-object))
      	)
    	)
    	(foreach elv '(1e99 -1e99)
      	(vl-catch-all-apply 'vla-move
        	(list obj (vlax-3D-point '(0. 0. 0.)) (vlax-3D-point (list 0. 0. elv)))
      	)
    	)
  	)
  	(vla-delete acsel)
	)
  )
  (princ)
)
