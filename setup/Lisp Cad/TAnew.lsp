;**********************************************************************
;ZOOM
(defun c:zz ()  (command "'.zoom" "p"))
(defun c:za ()  (command "'.zoom" "a"))

;********************

(defun c:c()
(princ  "\nMultiple Copy:")
(setq dt (ssget))
(command "copy" dt "" "m")
)
(princ)


;************cat dim**********************************

(DEFUN C:CD (/ CMD SS LTH DEM PT DS KDL N70 GOCX GOCY PT13 PT14 PTI PT13I PT14I
                PT13N PT14N O13 O14 N13 N14 OSM OLDERR PT10 PT11)
(SETQ CMD (GETVAR "CMDECHO"))
(SETQ OSM (GETVAR "OSMODE"))
(SETQ OLDERR *error*
      *error* myerror)
(PRINC "Please select dimension object!")
(SETQ SS (SSGET))
(SETVAR "CMDECHO" 0)
(SETQ PT (GETPOINT "Point to trim or extend:"))
(SETQ PT (TRANS PT 1 0))
(COMMAND "UCS" "W")
(SETQ LTH (SSLENGTH SS))
(SETQ DEM 0)
(WHILE (< DEM LTH)
    (PROGN
	(SETQ DS (ENTGET (SSNAME SS DEM)))
	(SETQ KDL (CDR (ASSOC 0 DS)))
	(IF (= "DIMENSION" KDL)
	   (PROGN
		(SETQ PT10 (CDR (ASSOC 10 DS)))
		(SETQ PT11 (CDR (ASSOC 11 DS)))
		(SETQ PT13 (CDR (ASSOC 13 DS)))
		(SETQ PT14 (CDR (ASSOC 14 DS)))
		(SETQ N70 (CDR (ASSOC 70 DS)))
		(IF (OR (= N70 32) (= N70 33) (= N70 160) (= N70 161))
		   (PROGN
			(SETQ GOCY (ANGLE PT10 PT14))
			(SETQ GOCX (+ GOCY (/ PI 2)))
		   )
		)
		(SETVAR "OSMODE" 0)
		(SETQ PTI (POLAR PT GOCX 2))
		(SETQ PT13I (POLAR PT13 GOCY 2))
		(SETQ PT14I (POLAR PT14 GOCY 2))
		(SETQ PT13N (INTERS PT PTI PT13 PT13I NIL))
		(SETQ PT14N (INTERS PT PTI PT14 PT14I NIL))
		(SETQ O13 (ASSOC 13 DS))
		(SETQ O14 (ASSOC 14 DS))
		(SETQ N13 (CONS 13 PT13N))
		(SETQ N14 (CONS 14 PT14N))
		(SETQ DS (SUBST N13 O13 DS))
		(SETQ DS (SUBST N14 O14 DS))
		(ENTMOD DS)
	   )
	)
	(SETQ DEM (+ DEM 1))
    )
)
(COMMAND "UCS" "P")
(SETVAR "CMDECHO" CMD)
(SETVAR "OSMODE" OSM)
(setq *error* OLDERR)               ; Restore old *error* handler
(PRINC)
)
;*****************Dich dim********************************************

(DEFUN C:DF (/ CMD SS LTH DEM PT DS KDL N70 GOCX GOCY PT13 PT14 PTI
                PT10 PT10I PT10N O10 N10 PT11 PT11N O11 N11 KC OSM OLDERR)
(SETQ CMD (GETVAR "CMDECHO"))
(SETQ OSM (GETVAR "OSMODE"))
(SETQ OLDERR *error*
      *error* myerror)
(PRINC "Please select dimension object!")
(SETQ SS (SSGET))
(SETVAR "CMDECHO" 0)
(SETQ PT (GETPOINT "Point to trim or extend:"))
(SETQ PT (TRANS PT 1 0))
(COMMAND "UCS" "W")
(SETQ LTH (SSLENGTH SS))
(SETQ DEM 0)
(WHILE (< DEM LTH)
    (PROGN
	(SETQ DS (ENTGET (SSNAME SS DEM)))
	(SETQ KDL (CDR (ASSOC 0 DS)))
	(IF (= "DIMENSION" KDL)
	   (PROGN
		(SETQ PT13 (CDR (ASSOC 13 DS)))
		(SETQ PT14 (CDR (ASSOC 14 DS)))
		(SETQ PT10 (CDR (ASSOC 10 DS)))
		(SETQ PT11 (CDR (ASSOC 11 DS)))
		(SETQ N70 (CDR (ASSOC 70 DS)))
		(IF (OR (= N70 32) (= N70 33) (= N70 160) (= N70 161))
		   (PROGN
			(SETQ GOCY (ANGLE PT10 PT14))
			(SETQ GOCX (+ GOCY (/ PI 2)))
		   )
		)
		(SETVAR "OSMODE" 0)
		(SETQ PTI (POLAR PT GOCX 2))
		(SETQ PT10I (POLAR PT10 GOCY 2))
		(SETQ PT10N (INTERS PT PTI PT10 PT10I NIL))
		(SETQ KC (DISTANCE PT10 PT10N))
		(SETQ O10 (ASSOC 10 DS))
		(SETQ N10 (CONS 10 PT10N))
		(SETQ DS (SUBST N10 O10 DS))
		(SETQ PT11N (POLAR PT11 (ANGLE PT10 PT10N) KC))
		(SETQ O11 (ASSOC 11 DS))
		(SETQ N11 (CONS 11 PT11N))
		(SETQ DS (SUBST N11 O11 DS))
		(ENTMOD DS)
	   )
	)
	(SETQ DEM (+ DEM 1))
    )
)
(COMMAND "UCS" "P")
(SETVAR "CMDECHO" CMD)
(SETVAR "OSMODE" OSM)
(setq *error* OLDERR)
(PRINC)
)

;***dien tich****************

(defun c:dtt ( / tmp)
(setq 	a (getpoint "\nKich mot diem trong khu vuc: "))
(command "boundary" a "")
(command "area" "o" (entlast) )
(command "erase" (entlast) "")
(princ (strcat "\nDien tich la: " (rtos (/ (getvar "area") 1.0) 2 4) "m2"))
(princ)
);defun

(defun c:dii ( / tmp)
(setq 	a (getpoint "\nKich mot diem trong khu vuc: "))
(command "boundary" a "")
(command "area" "o" (entlast) )
(command "erase" (entlast) "")
(princ (strcat "\nDien tich la: " (rtos (getvar "area") 2 4) " m2"))
(princ)
);defun


;***Sua DIM****************
(defun c:dn () (command "dim1" "newtext"))

(defun c:de () (command "dim1" "tedit"))

;***Noi PL****************
(defun c:`` (/ tdt ssdt sodt index)
(defun ObjName (ssdt /)
(cdr (assoc '0 (entget ssdt)))
)
(defun MoPL (ssdt /)
(= (cdr (assoc '70 (entget ssdt))) 0)
)
(defun NoiPL (ssdt /)
(if (MoPL ssdt)
(command ".PEDIT" ssdt "J" "All" "" "X")
)
)
(defun NoiLC (ssdt /)
(command ".PEDIT" ssdt "Y" "J" "All" "" "X")
)
(setq
tdt (ssget)
sodt (sslength tdt)
index 0
)
(repeat sodt
(setq
ssdt (ssname tdt index)
index (1+ index)
)
(if (or (= (Objname ssdt) "LWPOLYLINE")
(= (Objname ssdt) "POLYLINE")
)
(NoiPL ssdt)
)
(if (or (= (Objname ssdt) "LINE") (= (Objname ssdt) "ARC"))
(NoiLC ssdt)
)
)
(princ)
)
;*********************
