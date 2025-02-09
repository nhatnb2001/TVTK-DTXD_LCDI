;;;;        Design by  : VVA <Vladimir Azarko>
;;;;        Posted     : http://forum.dwg.ru/showthread.php?t=20509

;;;RUSSIAN
;;; ������� ��������� ��������� �����, ��������� ��������: �����, ������, ���������, �������� � ��������� ����, ����� � ������������ �������
;;; ��������� ���� � ���� txt, ���� csv.
;;; ==================================================================================================
;;; ����� !!!
;;; ������ ����� �������������� ������� �� ������� ����, ������� ������, ������� ������� ( TEXTSIZE )
;;; ���������� ��������� � ������������ � �������� ����������� ������� _UNITS (���������� LUPREC !!!)
;;;!!!!!!!!!!!!!
;;; ������� � ��������� ������ LUPREC � ���������� ������ �������� ����������.
;;;!!!!!!!!!!
;;; ===================================================================================================
;;; ���������� 4 �������
;;; COOR - ������� ���������
;;; COORN -������� ��������� � ����������. ������ ����� ������� ������� �� ������� ����, ������� ������, ������� ������� ( TEXTSIZE )
;;; COORT -������� ��������� � ����������, ��� ������� ��������� ��������� � ����� �����
;;; COOR-GEO - ������� ��������� � ����������, ��� ������� ��������� ��������� � ����� �����. ����������� ������������ ���� � ����������



;;;; Commands 
;;Export of coordinates of the specified points, the chosen objects: points, blocks, polylines, splines in a text file, Excel.
;;   Text file � txt, or csv. A rounding off of coordinates according to current adjustments of a command _UNITS (LUPREC !!!)
;;; 4 commands Are certain
;;; COOR - export of coordinates
;;; COORN-export of coordinates with numbering. Numbers of points are drawn by the text on the current layer, the current style, current height (TEXTSIZE)
;;; COORT-export of coordinates with numbering where number considers the text nearest to a point
;;; COOR-GEO - export of coordinates with numbering where number considers the text nearest to a point. It is calculated ������������ a corner and distance


;;http://www.caduser.ru/cgi-bin/f1/board.cgi?t=39175jU
;|=============== ������� COORN ===============================================

EN:
   Export of coordinates of the specified points, the chosen objects: points, blocks, polylines, splines in a text file, Excel.
   Text file � txt, or csv. A rounding off of coordinates according to current adjustments of a command _UNITS (LUPREC !!!)
RUS:
������� ��������� ��������� �����, ��������� ��������: �����, ������, ���������, �������� � ��������� ����, ����� � ������������ �������
��������� ���� � ���� txt, ���� csv.
������ ����� �������������� ������� �� ������� ����, ������� ������, ������� �������
���������� ��������� � ������������ � �������� ����������� ������� _UNITS (���������� LUPREC !!!)

|;

(defun c:XX (/ cFile curPt filPath objSet oFlag oldMode ptLst sFlag lw isRus Npt)
(defun group-by-num (lst num / ls ret)(if (= (rem (length lst) num ) 0)(progn (setq ls nil)
  (repeat (/ (length lst) num)(repeat num (setq ls(cons (car lst) ls)lst (cdr lst)))
  (setq ret (append ret (list (reverse ls))) ls nil)))) ret)
(defun PtCollect(SelSet)(mapcar 'cdr (mapcar '(lambda(x)(assoc 10 x))(mapcar 'entget
(vl-remove-if 'listp(mapcar 'cadr(ssnamex SelSet))))))); end of PtCollect
(defun PLCollect(SelSet / ret)
(foreach lw (mapcar 'vlax-ename->vla-object (vl-remove-if 'listp(mapcar 'cadr(ssnamex SelSet))))
  (cond ((wcmatch (vla-get-ObjectName lw) "*Polyline")
  (setq ret (append ret (group-by-num (vlax-get lw 'Coordinates)
  (if (=(vla-get-ObjectName lw) "AcDbPolyline") 2 3)))))
       ((=(vla-get-ObjectName lw) "AcDbSpline")(setq ret (append ret (group-by-num
         (vlax-safearray->list(vlax-variant-value (vla-get-controlpoints lw)))  3))))
      (t nil))) ret)
  (vl-load-com)(setq isRus(= (getvar "SysCodePage") "ANSI_1251"))(if(not ptcol:mode)(setq ptcol:mode "Pick"))
  (initget "������� ����� ����� ��������� Pick pOints Blocks poLyline _Pick pOints Blocks poLyline Pick pOints Blocks poLyline")
(setq oldMode ptcol:mode ptcol:mode
(getkword (if IsRus (strcat "\n�������� ����� [�������/�����/�����/��������� ��� ������] <"
(cadr (assoc ptcol:mode '(("Pick" "�������")("pOints" "�������")("Blocks" "�����")("poLyline" "���������")))) ">: ")
        (strcat "\nSpecify mode [Pick/pOints/Blocks/poLyline or spline] <"ptcol:mode">: "))) ptLst nil)
(if(null ptcol:mode)(setq ptcol:mode oldMode))
(cond ((= "Pick" ptcol:mode)(setq curPt T)
       (while curPt (setq curPt(getpoint (if IsRus
         "\n������� ����� ��� Enter ���������� > " "\nPick point or Enter to continue > ")))
  (if curPt (setq ptLst(append ptLst(list (trans curPt 1 0))))))); end condition #1
      ((= "pOints" ptcol:mode)(if (not(setq objSet(ssget "_I" '((0 . "POINT")))))(progn
         (if IsRus (princ "\n�������� ����� � ������� Enter ")(princ "\nSelect points and press Enter "))
   (setq objSet(ssget '((0 . "POINT"))))))(if objSet (setq ptLst(PtCollect objSet)))); end condition #2
      ((= "Blocks" ptcol:mode)(if (not(setq objSet(ssget "_I" '((0 . "INSERT")))))(progn
        (if IsRus(princ "\n�������� ����� � ������� Enter ")(princ "\nSelect blocks and press Enter "))
     (setq objSet(ssget '((0 . "INSERT"))))))(if objSet (setq ptLst(PtCollect objSet)))); end condition #3
      ((= "poLyline" ptcol:mode)(if (not(setq objSet(ssget "_I" '((0 . "*POLYLINE,SPLINE")))))(progn
        (if IsRus(princ "\n�������� ��������� � ������� Enter  ")(princ "\nSelect polyline and press Enter "))
     (setq objSet(ssget '((0 . "*POLYLINE,SPLINE"))))))(if objSet (setq ptLst(PLCollect objSet)))); end condition #4
); end cond
(if ptLst (progn (princ "\n+++++++ Coordinates list +++++++\n")(setq ptLst (mapcar '(lambda(x)(trans x 0 1)) ptLst))
(mapcar '(lambda(x)(princ(strcat "\n"(rtos(car x))","(rtos(cadr x))
(if(= 3(length x))(strcat ","(rtos(nth 2 x))) "")))) ptLst); end mapcar
(princ "\n\n+++++++++ End of list +++++++++")
(setq Npt (getint (if IsRus "\n��������� ����� ����� <�� �����������> : " "\nStart number of points <Don't mark> : " )))
(initget "���� Excel �� Text Excel Not _Text Excel Not Text Excel Not")
(setq sFlag (getkword (if IsRus "\n��������� ���������� � [����/Excel/�� ���������] <����> : "
"\nSave coordinates to [Text file/Excel/Not save] <Text> : ")))
(if(null sFlag)(setq sFlag "Text"))(setq oFlag Npt)(if (numberp Npt)
(foreach ln ptlst
  (text-draw                 ;_��������� ������
    (itoa Npt)               ;_����� �����
    (polar ln (/ pi 4) 1.)   ;_���������� �� 1 �� �� ����� 45 ��������
    (getvar "TEXTSIZE")      ;_ ������� ������� ������
    0                        ;_���� ��������
    nil
    )
  (setq Npt (1+ Npt))))
(setq Npt oFlag)    
(setq ptLst (mapcar '(lambda(x)(mapcar 'rtos x)) ptlst))
(cond ((and (= "Text" sFlag)(setq filPath
       (getfiled (if IsRus "���������� ��������� � ��������� ����" "Save Coordinates to Text File") "Coordinates.txt" "txt;csv" 33)))
       (setq cFile(open filPath "w"))(foreach ln ptLst (write-line (strcat (if (numberp Npt)(strcat (itoa Npt) ",") "")(car ln)","(cadr ln)
         (if(= 3(length ln))(strcat ","(nth 2 ln)))) cFile)(if (numberp Npt)(setq Npt (1+ Npt))))(close cFile)(initget "Yes No")
       (setq oFlag(getkword (if IsRus "\n������� ����? [Yes/No] <No> : " "\nOpen text file? [Yes/No] <No> : " )))
       (if(= oFlag "Yes")(startapp "notepad.exe" filPath))); end condition #1
     ((= "Excel" sFlag)(if (numberp Npt)(progn
      (setq ptlst (mapcar '(lambda(x)(cons (1- (setq Npt (1+ Npt))) x)) ptlst))
      (xls ptlst '("N" "X" "Y" "Z") nil "COORN"))
      (xls ptLst nil nil "COOR"))); end condition #2
     (t nil)))) (princ)); end of c:COOR
;|================== XLS ========================================
*  published http://www.autocad.ru/cgi-bin/f1/board.cgi?t=31371zf
               http://www.autocad.ru/cgi-bin/f1/board.cgi?t=31596eW
* Purpose: Export of the list of data Data-list in Excell
*             It is exported to a new leaf of the current book.
              If the book is not present, it is created
* Arguments:
              Data-list � The list of lists of data (LIST)
                            ((Value1 Value2 ... VlalueN)(Value1 Value2 ... VlalueN)...)
                            Each list of a kind (Value1 Value2... VlalueN) enters the name in
                            a separate line in corresponding columns (Value1-A Value2-B and .�.�.)
                  header �  The list (LIST) headings or nil a kind (" Signature A " " Signature B "...)
                            If header nil, is accepted ("X" "Y" "Z")
                 Colhide �  The list of alphabetic names of columns to hide or nil � to not hide ("A" "C" "D") � to hide columns A, C, D
                 Name_list � The name of a new leaf of the active book or nil � is not present
* Return: nil
* Usage
(xls '((1.1 1.2 1.3 1.4)(2.1 2.2 2.3 2.4)(3.1 3.2 3.3 3.4)) '("Col1" "Col2" "Col3"  "Col4") '("B") "test")   |;


;|================== XLS ========================================
* ������������ http://www.autocad.ru/cgi-bin/f1/board.cgi?t=19833nl&page=2
               http://www.autocad.ru/cgi-bin/f1/board.cgi?t=31371zf
               http://www.autocad.ru/cgi-bin/f1/board.cgi?t=31596eW
* �����: �������� ������ aka VVA
* ����������: ������ ������ ������ Data-list � Excell
*             ��� ������ ��������� ����� �����
              ����� �������������� � ������ �����
* ���������:
              Data-list � ������ ������� ������ (LIST) ����
                            ((Value1 Value2 ... VlalueN)(Value1 Value2 ... VlalueN)...)
                            ������ ������ ���� (Value1 Value2 ... VlalueN) ������������
                            � ��������� ������ � ��������������� ������� (Value1-A Value2-B � .�.�.)
                  header �  ������ (LIST) ���������� ��� nil ���� ("������� A" "������� B" ...)
                            ���� header nil, ����������� ("X" "Y" "Z")
                 Colhide �  ������ ��������� �������� �������� ��� ������� ��� nil � �� ��������
                            ("A" "C" "D") � ������ ������� A, C, D
                 Name_list � ��� ������ ����� �������� ����� ��� nil � ����� �����
* �������: nil
* TIPS!!! : ��� �������� ������� xls �������� ������������ ������ ��� ������������� ��������� ������� ���������
            ����������� ����� � ������� ����� ("HKEY_CURRENT_USER\\Control Panel\\International" "sDecimal")
            �������� �� ����� ������ ����������� ������������� � Excele ���������� �����������, ������������
            ����� � ������� ����� ��������������� �����. ����� ���������� �-��� ��� �����������������.
������ ������
(xls '((1.1 1.2 1.3 1.4)(2.1 2.2 2.3 2.4)(3.1 3.2 3.3 3.4)) '("�������1" "�������2" "�������3" "�������4") '("B"))|;
(vl-load-com)
(defun xls ( Data-list header Colhide Name_list / *aplexcel* *books-colection* Currsep
*excell-cells* *new-book* *sheet#1* *sheet-collection* col iz_listo row cell cols)
(defun Letter (N / Res TMP)(setq Res "")(while (> N 0)(setq TMP (rem N 26)
  TMP (if (zerop TMP)(setq N (1- N) TMP 26) TMP)
  Res (strcat (chr (+ 64 TMP)) Res)  N   (/ N 26))) Res)
(if (null Name_list)(setq Name_list ""))
  (setq  *AplExcel*     (vlax-get-or-create-object "Excel.Application"))
  (if (setq *New-Book*  (vlax-get-property *AplExcel* "ActiveWorkbook"))
    (setq *Books-Colection*  (vlax-get-property *AplExcel* "Workbooks")
          *Sheet-Collection* (vlax-get-property *New-Book* "Sheets")
               *Sheet#1*     (vlax-invoke-method *Sheet-Collection* "Add"))
(setq *Books-Colection*  (vlax-get-property *AplExcel* "Workbooks")
              *New-Book*     (vlax-invoke-method *Books-Colection* "Add")
          *Sheet-Collection* (vlax-get-property *New-Book* "Sheets")
               *Sheet#1*     (vlax-get-property *Sheet-Collection* "Item" 1)))
(setq *excell-cells*     (vlax-get-property *Sheet#1* "Cells"))
(setq Name_list (if (= Name_list "")
                  (vl-filename-base(getvar "DWGNAME"))
                  (strcat (vl-filename-base(getvar "DWGNAME")) "&" Name_list))
   col 0 cols nil)
(if (> (strlen Name_list) 26)
(setq Name_list (strcat (substr Name_list 1 10) "..." (substr Name_list (- (strlen Name_list) 13) 14))))
(vlax-for sh *Sheet-Collection* (setq cols (cons (strcase(vlax-get-property sh 'Name)) cols)))
(setq row Name_list)
(while (member (strcase row) cols)(setq row (strcat Name_list " (" (itoa(setq col (1+ col)))")")))
(setq Name_list row)
(vlax-put-property *Sheet#1* 'Name Name_list)
(setq Currsep (vlax-get-property *AplExcel* "UseSystemSeparators"))
(vlax-put-property *AplExcel* "UseSystemSeparators" :vlax-false) ;_�� ������������ ��������� ���������
(vlax-put-property *AplExcel* "DecimalSeparator" ".")            ;_����������� ������� � ����� �����
(vlax-put-property *AplExcel* "ThousandsSeparator" " ")          ;_����������� �������
(vla-put-visible *AplExcel* :vlax-true)(setq row 1 col 1)
(if (null header)(setq header '("X" "Y" "Z")))
(repeat (length header)(vlax-put-property *excell-cells* "Item" row col
(vl-princ-to-string (nth (1- col) header)))(setq col (1+ col)))(setq  row 2 col 1)
(repeat (length Data-list)(setq iz_listo (car Data-list))(repeat (length iz_listo)
(vlax-put-property *excell-cells* "Item" row col (vl-princ-to-string (car iz_listo)))
(setq iz_listo (cdr iz_listo) col (1+ col)))(setq Data-list (cdr Data-list))(setq col 1 row (1+ row)))
(setq col (1+(length header)) row (1+ row))
(setq cell (vlax-variant-value (vlax-invoke-method *Sheet#1* "Evaluate"
    (strcat "A1:" (letter col)(itoa row))))) ;_ end of setq
(setq cols (vlax-get-property cell  'Columns))
(vlax-invoke-method cols 'Autofit)
(vlax-release-object cols)(vlax-release-object cell)
(foreach item ColHide (if (numberp item)(setq item (letter item)))
(setq cell (vlax-variant-value (vlax-invoke-method *Sheet#1* "Evaluate"
    (strcat item "1:" item "1"))))
(setq cols (vlax-get-property cell  'Columns))
(vlax-put-property cols 'hidden 1)
(vlax-release-object cols)(vlax-release-object cell))
(vlax-put-property *AplExcel* "UseSystemSeparators" Currsep)
(mapcar 'vlax-release-object (list *excell-cells* *Sheet#1* *Sheet-Collection* *New-Book* *Books-Colection*
*AplExcel*))(setq *AplExcel* nil)(gc)(gc)(princ))
;;;��������� ������
;;; txt - �����
;;; pnt - ����� ��������� � ���
;;; heigtht - ������
;;; rotation - ���� ��������
;;;justification - ��� nil
;;;���������� ��� ���������
(defun text-draw (txt pnt height rotation justification)
   (if (null pnt)(command "_.-TEXT" "" txt)
   (if (= (cdr (assoc 40 (tblsearch "STYLE" (getvar "TEXTSTYLE"))))
    0.0
       ) ;_ end of =
     (progn
     ;; ������� ������ ������
       (if justification
   (command "_.-TEXT" "_J" justification "_none" pnt height rotation txt)
   (command "_.-TEXT" "_none" pnt height rotation txt)
       ) ;_ end of if
     ) ;_ end of progn
     (progn
       ;; �������������� ������
       (if justification
   (command "_.-TEXT" "_J" justification "_none" pnt rotation txt)
   (command "_.-TEXT" "_none" pnt rotation txt)
       ) ;_ end of if
     ) ;_ end of progn
   ) ;_ end of if
     )
  (entlast)
)
(defun c:COOR(/ cFile curPt filPath objSet oFlag oldMode ptLst sFlag lw isRus)
(defun group-by-num (lst num / ls ret)(if (= (rem (length lst) num ) 0)(progn (setq ls nil)
  (repeat (/ (length lst) num)(repeat num (setq ls(cons (car lst) ls)lst (cdr lst)))
  (setq ret (append ret (list (reverse ls))) ls nil)))) ret)
(defun PtCollect(SelSet)(mapcar 'cdr (mapcar '(lambda(x)(assoc 10 x))(mapcar 'entget
(vl-remove-if 'listp(mapcar 'cadr(ssnamex SelSet))))))); end of PtCollect
(defun PLCollect(SelSet / ret)
(foreach lw (mapcar 'vlax-ename->vla-object (vl-remove-if 'listp(mapcar 'cadr(ssnamex SelSet))))
  (cond ((wcmatch (vla-get-ObjectName lw) "*Polyline")
	(setq ret (append ret (group-by-num (vlax-get lw 'Coordinates)
	(if (=(vla-get-ObjectName lw) "AcDbPolyline") 2 3)))))
       ((=(vla-get-ObjectName lw) "AcDbSpline")(setq ret (append ret (group-by-num
         (vlax-safearray->list(vlax-variant-value (vla-get-controlpoints lw)))  3))))
      (t nil))) ret)
  (vl-load-com)(setq isRus(= (getvar "SysCodePage") "ANSI_1251"))(if(not ptcol:mode)(setq ptcol:mode "Pick"))
  (initget "������� ����� ����� ��������� Pick pOints Blocks poLyline _Pick pOints Blocks poLyline Pick pOints Blocks poLyline")
(setq oldMode ptcol:mode ptcol:mode
(getkword (if IsRus (strcat "\n�������� ����� [�������/�����/�����/��������� ��� ������] <"
(cadr (assoc ptcol:mode '(("Pick" "�������")("pOints" "�������")("Blocks" "�����")("poLyline" "���������")))) ">: ")
	      (strcat "\nSpecify mode [Pick/pOints/Blocks/poLyline or spline] <"ptcol:mode">: "))) ptLst nil)
(if(null ptcol:mode)(setq ptcol:mode oldMode))
(cond ((= "Pick" ptcol:mode)(setq curPt T)
       (while curPt (setq curPt(getpoint (if IsRus
         "\n������� ����� ��� Enter ���������� > " "\nPick point or Enter to continue > ")))
	(if curPt (setq ptLst(append ptLst(list (trans curPt 1 0))))))); end condition #1
      ((= "pOints" ptcol:mode)(if (not(setq objSet(ssget "_I" '((0 . "POINT")))))(progn
         (if IsRus (princ "\n�������� ����� � ������� Enter ")(princ "\nSelect points and press Enter "))
	 (setq objSet(ssget '((0 . "POINT"))))))(if objSet (setq ptLst(PtCollect objSet)))); end condition #2
      ((= "Blocks" ptcol:mode)(if (not(setq objSet(ssget "_I" '((0 . "INSERT")))))(progn
        (if IsRus(princ "\n�������� ����� � ������� Enter ")(princ "\nSelect blocks and press Enter "))
	   (setq objSet(ssget '((0 . "INSERT"))))))(if objSet (setq ptLst(PtCollect objSet)))); end condition #3
      ((= "poLyline" ptcol:mode)(if (not(setq objSet(ssget "_I" '((0 . "*POLYLINE,SPLINE")))))(progn
        (if IsRus(princ "\n�������� ��������� � ������� Enter  ")(princ "\nSelect polyline and press Enter "))
	   (setq objSet(ssget '((0 . "*POLYLINE,SPLINE"))))))(if objSet (setq ptLst(PLCollect objSet)))); end condition #4
); end cond
(if ptLst (progn (princ "\n+++++++ Coordinates list +++++++\n")(setq ptLst (mapcar '(lambda(x)(trans x 0 1)) ptLst))
(mapcar '(lambda(x)(princ(strcat "\n"(rtos(car x))","(rtos(cadr x))
(if(= 3(length x))(strcat ","(rtos(nth 2 x))) "")))) ptLst); end mapcar
(princ "\n\n+++++++++ End of list +++++++++")(initget "���� Excel �� Text Excel Not _Text Excel Not Text Excel Not")
(setq sFlag (getkword (if IsRus "\n��������� ���������� � [����/Excel/�� ���������] <����> : "
"\nSave coordinates to [Text file/Excel/Not save] <Text> : ")))
(if(null sFlag)(setq sFlag "Text"))
(cond ((and (= "Text" sFlag)(setq filPath
       (getfiled (if IsRus "���������� ��������� � ��������� ����" "Save Coordinates to Text File") "Coordinates.txt" "txt;csv" 33)))
       (setq cFile(open filPath "w"))(foreach ln ptLst (write-line (strcat (rtos(car ln))","(rtos(cadr ln))
         (if(= 3(length ln))(strcat ","(rtos(nth 2 ln))))) cFile))(close cFile)(initget "Yes No")
       (setq oFlag(getkword (if IsRus "\n������� ����? [Yes/No] <No> : " "\nOpen text file? [Yes/No] <No> : " )))
       (if(= oFlag "Yes")(startapp "notepad.exe" filPath))); end condition #1
     ((= "Excel" sFlag)(xls (mapcar '(lambda(x)(mapcar 'rtos x)) ptLst) nil nil "COOR")); end condition #2
     (t nil)))) (princ)); end of c:COOR

(defun c:COORT(/ cFile curPt filPath objSet oFlag oldMode ptLst sFlag lw isRus txtList buf pat)
(defun group-by-num (lst num / ls ret)(if (= (rem (length lst) num ) 0)(progn (setq ls nil)
  (repeat (/ (length lst) num)(repeat num (setq ls(cons (car lst) ls)lst (cdr lst)))
  (setq ret (append ret (list (reverse ls))) ls nil)))) ret)
(defun PtCollect(SelSet)(mapcar 'cdr (mapcar '(lambda(x)(assoc 10 x))(mapcar 'entget
(vl-remove-if 'listp(mapcar 'cadr(ssnamex SelSet))))))); end of PtCollect
(defun PLCollect(SelSet / ret)
(foreach lw (mapcar 'vlax-ename->vla-object (vl-remove-if 'listp(mapcar 'cadr(ssnamex SelSet))))
  (cond ((wcmatch (vla-get-ObjectName lw) "*Polyline")
	(setq ret (append ret (group-by-num (vlax-get lw 'Coordinates)
	(if (=(vla-get-ObjectName lw) "AcDbPolyline") 2 3)))))
       ((=(vla-get-ObjectName lw) "AcDbSpline")(setq ret (append ret (group-by-num
         (vlax-safearray->list(vlax-variant-value (vla-get-controlpoints lw)))  3))))
      (t nil))) ret)
  (vl-load-com)(setq isRus(= (getvar "SysCodePage") "ANSI_1251"))(if(not ptcol:mode)(setq ptcol:mode "Pick"))
  (initget "������� ����� ����� ��������� Pick pOints Blocks poLyline _Pick pOints Blocks poLyline Pick pOints Blocks poLyline")
(setq oldMode ptcol:mode ptcol:mode
(getkword (if IsRus (strcat "\n�������� ����� [�������/�����/�����/��������� ��� ������] <"
(cadr (assoc ptcol:mode '(("Pick" "�������")("pOints" "�������")("Blocks" "�����")("poLyline" "���������")))) ">: ")
	      (strcat "\nSpecify mode [Pick/pOints/Blocks/poLyline or spline] <"ptcol:mode">: "))) ptLst nil)
(if(null ptcol:mode)(setq ptcol:mode oldMode))
(cond ((= "Pick" ptcol:mode)(setq curPt T)
       (while curPt (setq curPt(getpoint (if IsRus
         "\n������� ����� ��� Enter ���������� > " "\nPick point or Enter to continue > ")))
	(if curPt (setq ptLst(append ptLst(list (trans curPt 1 0))))))); end condition #1
      ((= "pOints" ptcol:mode)(if (not(setq objSet(ssget "_I" '((0 . "POINT")))))(progn
         (if IsRus (princ "\n�������� ����� � ������� Enter ")(princ "\nSelect points and press Enter "))
	 (setq objSet(ssget '((0 . "POINT"))))))(if objSet (setq ptLst(PtCollect objSet)))); end condition #2
      ((= "Blocks" ptcol:mode)(if (not(setq objSet(ssget "_I" '((0 . "INSERT")))))(progn
        (if IsRus(princ "\n�������� ����� � ������� Enter ")(princ "\nSelect blocks and press Enter "))
	   (setq objSet(ssget '((0 . "INSERT"))))))(if objSet (setq ptLst(PtCollect objSet)))); end condition #3
      ((= "poLyline" ptcol:mode)(if (not(setq objSet(ssget "_I" '((0 . "*POLYLINE,SPLINE")))))(progn
        (if IsRus(princ "\n�������� ��������� � ������� Enter  ")(princ "\nSelect polyline and press Enter "))
	   (setq objSet(ssget '((0 . "*POLYLINE,SPLINE"))))))(if objSet (setq ptLst(PLCollect objSet)))); end condition #4
); end cond
(if ptLst
  (progn
    (setq objSet(ssget "_X" (list '(0 . "*TEXT")(cons 410 (getvar "CTAB")))))
    (setq lw (vl-remove-if 'listp(mapcar 'cadr(ssnamex objSet))))
    (setq lw (mapcar '(lambda(x)(setq x (entget x))(list (cdr(assoc 10 x))(cdr(assoc 1 x)))) lw))
    (foreach pt ptlst
      (setq buf (mapcar '(lambda(x)(list (distance pt (car x))(cadr x))) lw))
      (setq pat (car buf))
      (foreach dst buf (if (< (car dst) (car pat))(setq pat dst)))
      (setq txtList (cons (cadr pat) txtList))
      )
    (setq txtList (reverse txtList))
    (princ "\n+++++++ Coordinates list +++++++\n")
    (setq ptLst (mapcar '(lambda (x) (trans x 0 1)) ptLst))
    (setq buf
    (mapcar '(lambda (x y)
               (princ (strcat "\n" y "  "
                              (rtos (car x))
                              ","
                              (rtos (cadr x))
                              (if (= 3 (length x))
                                (strcat "," (rtos (nth 2 x)))
                                ""
                              ) ;_ end of if
                      ) ;_ end of strcat
               ) ;_ end of princ
              (list y (rtos (car x))(rtos (cadr x))
                              (if (= 3 (length x))(rtos (nth 2 x))) ;_ end of if
                      )
             ) ;_ end of lambda
            ptLst txtList
    );_ end mapcar
          )
    (princ "\n\n+++++++++ End of list +++++++++")
    (initget
      "���� Excel �� Text Excel Not _Text Excel Not Text Excel Not"
    ) ;_ end of initget
    (setq sFlag
           (getkword
             (if IsRus
               "\n��������� ���������� � [����/Excel/�� ���������] <����> : "
               "\nSave coordinates to [Text file/Excel/Not save] <Text> : "
             ) ;_ end of if
           ) ;_ end of getkword
    ) ;_ end of setq
    (if (null sFlag)
      (setq sFlag "Text")
    ) ;_ end of if
    (cond ((and (= "Text" sFlag)
                (setq filPath
                       (getfiled (if IsRus
                                   "���������� ��������� � ��������� ����"
                                   "Save Coordinates to Text File"
                                 ) ;_ end of if
                                 "Coordinates.txt"
                                 "txt;csv"
                                 33
                       ) ;_ end of getfiled
                ) ;_ end of setq
           ) ;_ end of and
           (setq cFile (open filPath "w"))
           (foreach ln buf
             (write-line
               (apply 'strcat
               (append (list(car ln))
                       (mapcar '(lambda(x)(strcat "," x))
                               (cdr ln)
                               )
                       )
                 )     
               cFile
             ) ;_ end of write-line
           ) ;_ end of foreach
           (close cFile)
           (initget "Yes No")
           (setq oFlag (getkword (if IsRus
                                   "\n������� ����? [Yes/No] <No> : "
                                   "\nOpen text file? [Yes/No] <No> : "
                                 ) ;_ end of if
                       ) ;_ end of getkword
           ) ;_ end of setq
           (if (= oFlag "Yes")
             (startapp "notepad.exe" filPath)
           ) ;_ end of if
          )                                       ; end condition #1
          ((= "Excel" sFlag)
           (xls buf
                '("����� �����" "X" "Y" "Z")
                nil
                "COORM"
           ) ;_ end of xls
          )                                       ; end condition #2
          (t nil)
    ) ;_ end of cond
  ) ;_ end of progn
) ;_ end of if
 (princ))
(defun c:COOR-GEO (/ cFile curPt filPath objSet oFlag oldMode ptLst sFlag lw isRus txtList buf pat geo txt)
(defun group-by-num (lst num / ls ret)(if (= (rem (length lst) num ) 0)(progn (setq ls nil)
  (repeat (/ (length lst) num)(repeat num (setq ls(cons (car lst) ls)lst (cdr lst)))
  (setq ret (append ret (list (reverse ls))) ls nil)))) ret)
(defun PtCollect(SelSet)(mapcar 'cdr (mapcar '(lambda(x)(assoc 10 x))(mapcar 'entget
(vl-remove-if 'listp(mapcar 'cadr(ssnamex SelSet))))))); end of PtCollect
(defun PLCollect(SelSet / ret)
(foreach lw (mapcar 'vlax-ename->vla-object (vl-remove-if 'listp(mapcar 'cadr(ssnamex SelSet))))
  (cond ((wcmatch (vla-get-ObjectName lw) "*Polyline")
	(setq ret (append ret (group-by-num (vlax-get lw 'Coordinates)
	(if (=(vla-get-ObjectName lw) "AcDbPolyline") 2 3)))))
       ((=(vla-get-ObjectName lw) "AcDbSpline")(setq ret (append ret (group-by-num
         (vlax-safearray->list(vlax-variant-value (vla-get-controlpoints lw)))  3))))
      (t nil))) ret)
  (vl-load-com)(setq isRus(= (getvar "SysCodePage") "ANSI_1251"))(if(not ptcol:mode)(setq ptcol:mode "Pick"))
  (initget "������� ����� ����� ��������� Pick pOints Blocks poLyline _Pick pOints Blocks poLyline Pick pOints Blocks poLyline")
(setq oldMode ptcol:mode ptcol:mode
(getkword (if IsRus (strcat "\n�������� ����� [�������/�����/�����/��������� ��� ������] <"
(cadr (assoc ptcol:mode '(("Pick" "�������")("pOints" "�������")("Blocks" "�����")("poLyline" "���������")))) ">: ")
	      (strcat "\nSpecify mode [Pick/pOints/Blocks/poLyline or spline] <"ptcol:mode">: "))) ptLst nil)
(if(null ptcol:mode)(setq ptcol:mode oldMode))
(cond ((= "Pick" ptcol:mode)(setq curPt T)
       (while curPt (setq curPt(getpoint (if IsRus
         "\n������� ����� ��� Enter ���������� > " "\nPick point or Enter to continue > ")))
	(if curPt (setq ptLst(append ptLst(list (trans curPt 1 0))))))); end condition #1
      ((= "pOints" ptcol:mode)(if (not(setq objSet(ssget "_I" '((0 . "POINT")))))(progn
         (if IsRus (princ "\n�������� ����� � ������� Enter ")(princ "\nSelect points and press Enter "))
	 (setq objSet(ssget '((0 . "POINT"))))))(if objSet (setq ptLst(PtCollect objSet)))); end condition #2
      ((= "Blocks" ptcol:mode)(if (not(setq objSet(ssget "_I" '((0 . "INSERT")))))(progn
        (if IsRus(princ "\n�������� ����� � ������� Enter ")(princ "\nSelect blocks and press Enter "))
	   (setq objSet(ssget '((0 . "INSERT"))))))(if objSet (setq ptLst(PtCollect objSet)))); end condition #3
      ((= "poLyline" ptcol:mode)(if (not(setq objSet(ssget "_I" '((0 . "*POLYLINE,SPLINE")))))(progn
        (if IsRus(princ "\n�������� ��������� � ������� Enter  ")(princ "\nSelect polyline and press Enter "))
	   (setq objSet(ssget '((0 . "*POLYLINE,SPLINE"))))))(if objSet (setq ptLst(PLCollect objSet)))); end condition #4
); end cond
(if ptLst
  (progn
    (if (setq objSet(ssget "_X" (list '(0 . "*TEXT")(cons 410 (getvar "CTAB")))))
      (progn
	 (setq lw (vl-remove-if 'listp(mapcar 'cadr(ssnamex objSet))))
    (setq lw (mapcar '(lambda(x)(setq x (entget x))(list (cdr(assoc 10 x))(cdr(assoc 1 x)))) lw))
    (foreach pt ptlst
      (setq buf (mapcar '(lambda(x)(list (distance pt (car x))(cadr x))) lw))
      (setq pat (car buf))
      (foreach dst buf (if (< (car dst) (car pat))(setq pat dst)))
      (setq txtList (cons (cadr pat) txtList))
      )
    (setq txtList (reverse txtList))
	)
      (setq txtList '("? 1"))
      )
    ;;; ��������� ������������� ���������� (�������������� X � Y, ��������� ���������� � ������ �����)
    (setq lw 0)
    (repeat (length ptLst)
      (setq curPt (nth lw ptLst)) ;_������� �����
      (if (setq buf (nth (1+ lw) ptLst)) ;_�����������
	(progn
	(setq txt (nth (1+ lw) txtList)) ;_����� ��������� �����
	(if (null txt)(setq txt (strcat "? "(itoa (+ 2 lw)))))
	)
	(progn
	(setq buf (car ptLst) txt (car txtList))
	(if (null txt)(setq txt "? 1"))
	)
	)
      (setq curPt (list (cadr curPt)(car curPt))) ;_ ���������� ������� ����� (��������������)
      (setq buf (list (cadr buf)(car buf))) ;_ ���������� ��������� (��������������)
      (setq geo (cons (list
			(if (nth lw txtList)(nth lw txtList)(strcat "? "(itoa (1+ lw)))) ;_ ����� �����
			curPt                                                       ;_ ����������
			                                                            ;_ ���. ����
			(vl-string-subst "' " "'"  ;_�������� ������ '(���) �� ������ '' '(c ��������)
			  (vl-string-subst "� " "d" ;_ �������� ������ d(����) �� ������ '� '
			    (angtos (angle curPt buf) 1 3)
			    )
			  )
			(distance curPt buf) ;_����������
			txt ;_ �� �����
			)
		      geo
		      )
	    )
			
      (setq lw (1+ lw))
      )
    (setq geo (reverse geo))
    (princ "\n+++++++ Coordinates list +++++++\n")
    (setq buf
    (mapcar '(lambda (x)
               (princ (strcat "\n" (nth 0 x) "  "
                              (rtos (car (nth 1 x)))
                              ","
                              (rtos (cadr (nth 1 x)))
                      ) ;_ end of strcat
               ) ;_ end of princ
	       (list
		 (nth 0 x)                  ;_ ����� �����
		 (rtos (car (nth 1 x)) 2 2) ;_ ����� X
		 (rtos (cadr (nth 1 x)) 2 2);_ ����� Y
		 (nth 2 x)                  ;_ ��� ����
		 (rtos (nth 3 x) 2 2)       ;_ ����������
		 (nth 4 x)                  ;_ �� �����
		 )
              ) ;_ end of lambda
            geo
    );_ end mapcar
	  )
    (princ "\n\n+++++++++ End of list +++++++++")
    (initget
      "���� Excel �� Text Excel Not _Text Excel Not Text Excel Not"
    ) ;_ end of initget
    (setq sFlag
           (getkword
             (if IsRus
               "\n��������� ���������� � [����/Excel/�� ���������] <����> : "
               "\nSave coordinates to [Text file/Excel/Not save] <Text> : "
             ) ;_ end of if
           ) ;_ end of getkword
    ) ;_ end of setq
    (if (null sFlag)
      (setq sFlag "Text")
    ) ;_ end of if
    (cond ((and (= "Text" sFlag)
                (setq filPath
                       (getfiled (if IsRus
                                   "���������� ��������� � ��������� ����"
                                   "Save Coordinates to Text File"
                                 ) ;_ end of if
                                 "Coordinates.txt"
                                 "txt;csv"
                                 33
                       ) ;_ end of getfiled
                ) ;_ end of setq
           ) ;_ end of and
           (setq cFile (open filPath "w"))
           (foreach ln buf
             (write-line
               (apply 'strcat
               (append (list(car ln))
                       (mapcar '(lambda(x)(strcat "," x))
                               (cdr ln)
                               )
                       )
                 )     
               cFile
             ) ;_ end of write-line
           ) ;_ end of foreach
           (close cFile)
           (initget "Yes No")
           (setq oFlag (getkword (if IsRus
                                   "\n������� ����? [Yes/No] <No> : "
                                   "\nOpen text file? [Yes/No] <No> : "
                                 ) ;_ end of if
                       ) ;_ end of getkword
           ) ;_ end of setq
           (if (= oFlag "Yes")
             (startapp "notepad.exe" filPath)
           ) ;_ end of if
          )                                       ; end condition #1
          ((= "Excel" sFlag)
           (xls buf
                '("����� �����" "X" "Y" "���. ����" "����������" "�� �����")
                nil
                "COORM"
           ) ;_ end of xls
          )                                       ; end condition #2
          (t nil)
    ) ;_ end of cond
  ) ;_ end of progn
) ;_ end of if
 (princ))

 (defun C:PTXL ( / ss lst pt dL lstp lstt ret Z)
 ;;;http://forum.dwg.ru/showthread.php?t=14353
;;;������� PTXL.
;;;Max distance from point to text - ������������ ���������� ����� � ������.
;;;���������� ������ ������� �� ���� 10 (������������ �����)
;;;���� ������� ��������� ������� � ����������� ������ Max distance, ������� ����� � ���������� �����������.

  (vl-load-com)
  (initget 1)
  (setq dL (getreal "\nMax distance from point to text: "))
  (and
  (princ "\nSelect text and Point")
  (setq ss (ssget "_:L" '((0 . "TEXT,Point"))))
  (setq lst (vl-remove-if 'listp (mapcar 'cadr (ssnamex ss))))
  (foreach en lst
    (if (= (cdr(assoc 0 (entget en))) "POINT")
      (setq lstp (cons en lstp))
      (setq lstt (cons en lstt))
      )
    )
  (foreach en lstp
    (setq pt (cdr(assoc 10 (entget en))))
    (setq pt (mapcar '+ pt '(0 0)))
    (setq lst (vl-remove-if '(lambda(txt)
          (< (distance pt
         (mapcar '+ (cdr(assoc 10 (entget txt)))
             '(0 0)))
      dL
      )
          )
  lstt
  )
   )
    (setq lst (vl-sort lst '(lambda(x y)
         (< (distance pt (mapcar '+ (cdr(assoc 10 (entget x)))  '(0 0)))
     (distance pt (mapcar '+ (cdr(assoc 10 (entget y)))  '(0 0))) 
      )
         )
         )
   )
    (setq Z (cdr(assoc 1 (entget (car lst)))))
    (setq Z (vl-string-translate "," "." (vl-string-trim  "%UuoOcC \t" Z)))
    (setq Z (atof Z))
    (setq pt (append pt (list Z)))
    (setq ret (cons pt ret))
    )
  )
    (if ret (xls ret '("X" "Y" "Z") nil nil))
    (princ)
)
(princ "\nType COOR, COORN, COORT or COOR-GEO in command line")