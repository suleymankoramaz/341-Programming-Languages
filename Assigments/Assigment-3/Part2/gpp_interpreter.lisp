(load "gpp_lexer.lisp")

;LIST DEFINITIONS
;---------------------------------
(defparameter variables    (list))
(defparameter values       (list))
(defparameter functions    (list))
(defparameter f_parameters (list))
(defparameter f_values     (list))
(defparameter f_values_2   (list))
;---------------------------------

;EXIT AND ERROR CONTROL VARIABLES
;---------------------------------
(setq exit0 0)
(setq error 0)
;---------------------------------

;MAIN FUNCTION
;------------------------------------------ 
(defun gppinterpreter (&optional filename)
    (loop
        ;STRING PARSE BY LEXER AND RETURNE LIST
        ;--------------------------------------
        ;define empty lists for lexer
        (setq myList (list))  ;list for tokens
        (setq valList (list)) ;list for token values
        
        ;CALL LEXER
        (gpplexer myList valList)

        ;return values must be reversed because of my algoritm
        (setq myList (reverse myList))
        (setq valList (reverse valList))
        
        ;convert lists to required input for interpreter (converting nested parentheses to list etc.)
        (list_converter myList valList)

        ;control syntax
        (if (explist_control myList)
            (progn
                ;if there is no error
                (if (equal error 0)
                    (progn
                        ;generate input and set result
                        (setq result (exp_maker myList valList))
                        ;write result
                        (if (not (equal result nil))
                            (progn
                                (write-line "Syntax OK.")
                                (write-string "Result: ")
                                (write result)
                            )
                        )
                        (setq error 0)
                    )
                    (return)
                )
            )
            
            ;if it is not expression control if is function
            (if (func_control myList)
                ;if it is function definition
                (if (equal error 0)
                    (progn
                        (write-line "Syntax OK.")
                        (write-string "Result: ")
                        (write (func_maker myList valList))
                        (setq error 0)
                    )
                    (return)
                )
                ;if if is not neither expression and function so it is invalid input
                (progn
                    (write-line "SYNTAX_ERROR Expression not recognized")
                )
            )
            
        )
        
        (write-line "")

        ;EXIT CONTROL AFTER THAT LINE
        (if (equal exit0 1)
            (progn
                (setq exit0 0)
                (return)
            )
        ) 
    )
)
;------------------------------------------ 

;SYNTAX CONTROL FUNCTION FOR EXPRESSION
;------------------------------------------ 
(defun exp_control     (myList)
    (or 
        ;exit
        (and
            (equal (length myList) 1)
            (string= (nth 0 myList) "KW_EXIT")
        )
        ;id
        (and
            (equal (length myList) 1)
            (string= (nth 0 myList) "ID")
        )
        ;valuef
        (and
            (equal (length myList) 1)
            (string= (nth 0 myList) "VALUEF")
        )
        (and 
            (equal (length myList) 2)
            (string= (nth 0 myList)  "ID")
            (explist_control (nth 1 myList))
        )
        ;fcall2
        (and 
            (equal (length myList) 3)
            (string= (nth 0 myList)  "ID")
            (explist_control (nth 1 myList))
        )
        ;fcall3
        (and 
            (equal (length myList) 4)
            (string= (nth 0 myList)  "ID")
            (explist_control (nth 1 myList))
        )
        ;plus expression
        (and 
            (equal (length myList) 3)
            (string= (nth 0 myList)  "OP_PLUS")
            (exp_control_helper (nth 1 myList)) (exp_control_helper (nth 2 myList))
        )
        ;minus expression
        (and 
            (equal (length myList) 3)
            (string= (nth 0 myList) "OP_MINUS")
            (exp_control_helper (nth 1 myList))(exp_control_helper (nth 2 myList))
        )
        ;mult expression
        (and
            (equal (length myList) 3)
            (string= (nth 0 myList) "OP_MULT")
            (exp_control_helper (nth 1 myList))(exp_control_helper (nth 2 myList))
        )
        ;div expression
        (and
            (equal (length myList) 3)
            (string= (nth 0 myList) "OP_DIV")
            (exp_control_helper (nth 1 myList))(exp_control_helper (nth 2 myList))
        )
        ;declaring expression
        (and 
            (equal (length myList) 3)
            (string= (nth 0 myList) "DEFV")(string= (nth 1 myList) "ID")
            (exp_control_helper (nth 2 myList))
        )
        ;set expression
        (and 
            (equal (length myList) 3)
            (string= (nth 0 myList) "KW_SET")(string= (nth 1 myList) "ID")
            (exp_control_helper (nth 2 myList))
        )
        ;if expression
        (and 
            (equal (length myList) 4)
            (string= (nth 0 myList) "KW_IF")
            (expb_control_helper    (nth 1 myList))
            (or (explist_control (nth 2 myList)) (exp_control (nth 2 myList)))
            (or (explist_control (nth 3 myList)) (exp_control (nth 3 myList)))
        )
        ;if expression with just one explist
        (and 
            (equal (length myList) 3)
            (string= (nth 0 myList) "KW_IF")
            (expb_control_helper    (nth 1 myList))
            (or (explist_control (nth 2 myList)) (exp_control (nth 2 myList)))
        )
        ;while expression
        (and 
            (equal (length myList) 3)
            (string= (nth 0 myList) "KW_WHILE")
            (expb_control_helper (nth 1 myList))
            (or (explist_control (nth 2 myList)) (exp_control (nth 2 myList)))
        )
    )
) 
;------------------------------------------ 

;SYNTAX CONTROL FUNCTION FOR BOOLEAN EXPRESSION
;------------------------------------------ 
(defun expb_control    (myList)
    (or
        ;equal
        (and
            (equal (length myList) 3)
            (string= (nth 0 myList)  "KW_EQUAL")
            (exp_control_helper (nth 1 myList)) (exp_control_helper (nth 2 myList))
        )
        ;greater than
        (and
            (equal (length myList) 3)
            (string= (nth 0 myList)  "KW_GT")
            (exp_control_helper (nth 1 myList)) (exp_control_helper (nth 2 myList))
        )
        ;true
        (and
            (equal (length myList) 1)(string= (nth 0 myList) "KW_TRUE")
        )
        ;false
        (and
            (equal (length myList) 1)(string= (nth 0 myList) "KW_FALSE")
        )
        ;and
        (and
            (equal (length myList) 3)
            (string= (nth 0 myList)  "KW_AND")
            (expb_control_helper (nth 1 myList)) (expb_control_helper (nth 2 myList))
        )
        ;or
        (and
            (equal (length myList) 3)
            (string= (nth 0 myList)  "KW_OR")
            (expb_control_helper (nth 1 myList)) (expb_control_helper (nth 2 myList))
        )
        ;not
        (and
            (equal (length myList) 2)
            (string= (nth 0 myList)  "KW_NOT")
            (expb_control_helper (nth 1 myList))
        )
    )
)
;------------------------------------------ 

;SYNTAX CONTROL FUNCTION FOR EXPRESSION LIST
;------------------------------------------ 
(defun explist_control (myList)
    (or
        ;explist with 1 expressiont
        (and
            (equal (length myList) 1)
            (exp_control_helper (list (nth 0 myList)))
        )
        ;explist with 2 expressiont
        (and
            (equal (length myList) 2)
            (exp_control_helper (nth 0 myList))
            (exp_control_helper (nth 1 myList))
        )
        ;explist with 3 expressiont
        (and
            (equal (length myList) 3)
            (exp_control_helper (nth 0 myList))
            (exp_control_helper (nth 1 myList))
            (exp_control_helper (nth 2 myList))
        )
        ;explist with 4 expressiont
        (and
            (equal (length myList) 4)
            (exp_control_helper (nth 0 myList))
            (exp_control_helper (nth 1 myList))
            (exp_control_helper (nth 2 myList))
            (exp_control_helper (nth 3 myList))
        )
        ;explist with 5 expressiont
        (and
            (equal (length myList) 5)
            (exp_control_helper (nth 0 myList))
            (exp_control_helper (nth 1 myList))
            (exp_control_helper (nth 2 myList))
            (exp_control_helper (nth 3 myList))
            (exp_control_helper (nth 4 myList))
        )
        ;explist with 6 expressiont
        (and
            (equal (length myList) 6)
            (exp_control_helper (nth 0 myList))
            (exp_control_helper (nth 1 myList))
            (exp_control_helper (nth 2 myList))
            (exp_control_helper (nth 3 myList))
            (exp_control_helper (nth 4 myList))
            (exp_control_helper (nth 5 myList))
        )
        ;control if it is just one expression and don't have explist parantheses
        (exp_control myList)
    )
)
;------------------------------------------ 

;SYNTAX CONTROL FUNCTION FOR IDLIST (FOR FUNCTION PARAMETERS)
;------------------------------------------ 
(defun idlist_control (myList)
    (or 
        ;1 parameter
        (and
            (equal (length myList)1)
            (string= (nth 0 myList) "ID")
        )
        ;2 parameter
        (and
            (equal (length myList)2)
            (string= (nth 0 myList) "ID")
            (string= (nth 1 myList) "ID")
        )
        ;3 parameter
        (and
            (equal (length myList)3)
            (string= (nth 0 myList) "ID")
            (string= (nth 1 myList) "ID")
            (string= (nth 2 myList) "ID")
        )
    )
)
;------------------------------------------ 

;SYNTAX CONTROL FUNCTION FOR FUNCTION
;------------------------------------------ 
(defun func_control (myList)
    (or 
        ;deffun without parameters
        (and 
            (equal (length myList) 3)
            (string= (nth 0 myList) "DEFF")
            (string= (nth 1 myList) "ID")
            (explist_control (nth 2 myList))
        )
        ;deffun with parameters
        (and 
            (equal (length myList) 4)
            (string= (nth 0 myList) "DEFF")
            (string= (nth 1 myList) "ID")
            (idlist_control  (nth 2 myList))
            (explist_control (nth 3 myList))
        )
    )
)
;------------------------------------------ 

;HELPER FUNCTION FOR POSSIBLE ERRORS (for ex: (nth: x is not list))
;------------------------------------------ 
(defun expb_control_helper (x)
    ;if it is not list (valuef, id etc.)
    (if (equal (stringp x) t)
        (return-from expb_control_helper (expb_control (list x))) ;convert list because function using lists
    )
    ;if it is list (valuef, id etc.)
    (if (not (equal (stringp x) t))
        (return-from expb_control_helper (expb_control x))
    )
)
;------------------------------------------ 

;HELPER FUNCTION FOR POSSIBLE ERRORS (for ex: (nth: x is not list))
;------------------------------------------ 
(defun exp_control_helper  (x)
    ;if it is not list (valuef, id etc.)
    (if (equal (stringp x) t)
        (return-from exp_control_helper (exp_control (list x))) ;convert list because function using lists
    )
    ;if it is list
    (if (not (equal (stringp x) t))
        (return-from exp_control_helper (exp_control x))
    )
)
;------------------------------------------ 

;FUNCTION THAT CONVERTS LEXER OUTPUT TO INPUT LIST FOR INTERPRETER
;------------------------------------------ 
(defun list_converter ('myList 'valList)

    ;define empty lists
    ;lists for token list
    (setq listParser (list))  ;list with first parenthesis
    (setq tempList (list))    ;list with second parenthesis
    (setq tempList0 (list))   ;list with third parenthesis
    (setq tempList00 (list))  ;list with fourth parenthesis
    
    ;lists for token value list
    (setq listParser2 (list)) ;list with first parenthesis
    (setq tempList2 (list))   ;list with second parenthesis
    (setq tempList3 (list))   ;list with third parenthesis
    (setq tempList4 (list))   ;list with fourth parenthesis
    
    ;control values for token list parantheses
    (setq c  0)
    (setq c2 0)
    (setq c3 0)

    ;control values for token value list parantheses
    (setq c4 0)
    (setq c5 0)
    (setq c6 0)


    (if (string= (nth 0 myList) "OP_OP")
        
        (loop for x in (cdr myList)
            do
            ;--------------------------------------------------------------------
            (if (and (not (string= x "OP_OP"))(not (string= x "OP_CP"))(equal c 0)(equal c2 0))
                (setq listParser(cons x listParser))
                (if (and (not (string= x "OP_OP"))(not (string= x "OP_CP"))(equal c 1)(equal c2 0))
                    (setq tempList (cons x tempList))
                    (if (and (not (string= x "OP_OP"))(not (string= x "OP_CP"))(equal c2 1)(equal c3 0))
                        (setq tempList0 (cons x tempList0))
                        (if (and (not (string= x "OP_OP"))(not (string= x "OP_CP"))(equal c3 1))
                            (setq tempList00 (cons x tempList00))
                        )
                    )
                )
            )
            
            
            
            ;--------------------------------------------------------------------

            ; - - - - - - - - - - - - - - - 

            ;--------------------------------------------------------------------
            (if (and (string= x "OP_OP")(equal c2 1))
                (setq c3 1)
                (if (and (string= x "OP_OP")(equal c 1))
                    (setq c2 1)
                    (if (and (string= x "OP_OP")(equal c 0))
                        (setq c 1)
                    )
                )
            )
              
            ;--------------------------------------------------------------------

            ; - - - - - - - - - - - - - - - 

            ;--------------------------------------------------------------------

            (if (and (string= x "OP_CP")(equal c2 0)(equal c 1))
            (progn
                (if (equal c 1)
                    (progn
                        (setq tempList (reverse tempList))
                        (setq listParser (push tempList listParser))
                        (setq tempList (list))
                    )
                )
                (setq c 0)
            )
            (progn
                (if (and (string= x "OP_CP")(equal c2 1)(equal c3 0))
                    (progn
                        (if (equal c 1)
                            (progn
                                (setq tempList0 (reverse tempList0))
                                (setq tempList (push tempList0 tempList))
                                (setq tempList0 (list))
                            )
                        )
                        (setq c2 0)
                    )
                    (progn
                        (if (and (string= x "OP_CP")(equal c3 1))
                        (progn
                            (if (equal c 1)
                                (progn
                                    (setq tempList00 (reverse tempList00))
                                    (setq tempList0 (push tempList00 tempList0))
                                    (setq tempList00 (list))
                                )
                            )
                            (setq c3 0)
                        )
                        )
                    )
                )
            )
            ) 
             
            
            ;--------------------------------------------------------------------
        )
    )
    (if (string= (nth 0 valList) "(")
        
        (loop for x in (cdr valList)
            do
            ;--------------------------------------------------------------------
            (if (and (not (string= x "("))(not (string= x ")"))(equal c4 0)(equal c5 0))
                (setq listParser2(cons x listParser2))
            )
            (if (and (not (string= x "("))(not (string= x ")"))(equal c4 1)(equal c5 0))
                (setq tempList2 (cons x tempList2))
            )
            (if (and (not (string= x "("))(not (string= x ")"))(equal c5 1)(equal c6 0))
                (setq tempList3 (cons x tempList3))
            )
            (if (and (not (string= x "("))(not (string= x ")"))(equal c6 1))
                (setq tempList4 (cons x tempList4))
            )
            ;--------------------------------------------------------------------

            ; - - - - - - - - - - - - - - - 

            ;--------------------------------------------------------------------
            (if (and (string= x "(")(equal c5 1))
                    (setq c6 1)
            )
            (if (and (string= x "(")(equal c4 1))
                    (setq c5 1)
            )
            (if (and (string= x "(")(equal c4 0))
                    (setq c4 1)
            )
            ;--------------------------------------------------------------------

            ; - - - - - - - - - - - - - - - 

            ;--------------------------------------------------------------------

            (if (and (string= x ")")(equal c5 0)(equal c4 1))
            (progn
                (if (equal c4 1)
                    (progn
                        (setq tempList2 (reverse tempList2))
                        (setq listParser2 (push tempList2 listParser2))
                        (setq tempList2 (list))
                    )
                )
                (setq c4 0)
            )
            ) 
            (if (and (string= x ")")(equal c5 1)(equal c6 0))
            (progn
                (if (equal c4 1)
                    (progn
                        (setq tempList3 (reverse tempList3))
                        (setq tempList2 (push tempList3 tempList2))
                        (setq tempList3 (list))
                    )
                )
                (setq c5 0)
            )
            ) 
            (if (and (string= x ")")(equal c6 1))
            (progn
                (if (equal c4 1)
                    (progn
                        (setq tempList4 (reverse tempList4))
                        (setq tempList3 (push tempList4 tempList3))
                        (setq tempList4 (list))
                    )
                )
                (setq c6 0)
            )
            )
            ;--------------------------------------------------------------------
        )
    )
    (setq listParser (reverse listParser))
    (setq listParser2 (reverse listParser2))
    (setq myList listParser)
    (setq valList listParser2)
)
;------------------------------------------ 

;FUNCTION THAT GENERATES EXPRESSION
;------------------------------------------ 
(defun exp_maker (myList valList)
    ;generate exit
    (if (string= (nth 0 myList)  "KW_EXIT")
        (progn
            (setq exit0 1)
            (return-from exp_maker nil)
        )
    )
    ;generate plus operator
    (if (string= (nth 0 myList)  "OP_PLUS")
        ;temporary variables:
        ;temp1 = first valuef
        ;temp2 = second valuef
        ;temp3 = first value (converted to float)
        ;temp4 = second value (converted to float)
        (let ((temp1)(temp2)(temp3)(temp4)(rtn))
            ;first expression
            (if (equal (stringp (nth 1 myList)) t )
                ;if is valuef
                (if (string= (nth 1 myList) "VALUEF")
                    (setq temp1 (frac_to_list (nth 1 valList)))
                    (progn
                        ;if is id (variable)
                        (if (string= (nth 1 myList) "ID")
                            (progn
                                (setq index (searchList (nth 1 valList) variables))
                                (if (not (equal index nil))
                                    (progn
                                        (setq temp1 (frac_to_list (nth index values)))
                                    )
                                )
                            )
                            ;if is not neither valuef or id
                            (progn
                                (setq error 1)
                                (return)
                            )
                        )
                    )
                )
                ;if is expression
                (setq temp1 (frac_to_list (exp_maker (nth 1 myList)(nth 1 valList))))
            )

            ;second expression
            (if (equal (stringp (nth 2 myList)) t )
                ;if is valuef 
                (if (string= (nth 2 myList) "VALUEF")
                    (setq temp2 (frac_to_list (nth 2 valList)))
                    ;if is id
                    (progn
                        (if (string= (nth 2 myList) "ID")
                            (progn
                                (setq index (searchList (nth 2 valList) variables))
                                (if (not (equal index nil))
                                    (progn
                                        (setq temp2 (frac_to_list (nth index values)))
                                    )
                                )
                            )
                            ;if is not neither valuef or id
                            (progn
                                (setq error 1)
                                (return)
                            )
                        )
                    )
                )
                ;if is expression
                (setq temp2 (frac_to_list (exp_maker (nth 2 myList)(nth 2 valList))))
            )  
            ;if there is no problem
            (if (equal error 0)
                (progn
                    (setq temp3 (+ (* (parse-integer (nth 0 temp1))(parse-integer (nth 1 temp2)))(* (parse-integer (nth 0 temp2))(parse-integer (nth 1 temp1)))))
                    (setq temp4 (* (parse-integer (nth 1 temp1))(parse-integer (nth 1 temp2))))
                    (setq temp3 (write-to-string temp3))
                    (setq temp4 (write-to-string temp4))
                    (return-from exp_maker (concatenate 'string temp3 "f" temp4))
                )
                (return-from exp_maker "error")
            )
        )
    )
    ;generate minus operator
    (if (string= (nth 0 myList)  "OP_MINUS")
        ;temporary variables:
        ;temp1 = first valuef
        ;temp2 = second valuef
        ;temp3 = first value (converted to float)
        ;temp4 = second value (converted to float)
        (let ((temp1)(temp2)(temp3)(temp4)(rtn))
            ;first expression
            (if (equal (stringp (nth 1 myList)) t )
                ;if is valuef
                (if (string= (nth 1 myList) "VALUEF")
                    (setq temp1 (frac_to_list (nth 1 valList)))
                    ;if is id
                    (progn
                        (if (string= (nth 1 myList) "ID")
                            (progn
                                (setq index (searchList (nth 1 valList) variables))
                                (if (not (equal index nil))
                                    (progn
                                        (setq temp1 (frac_to_list (nth index values)))
                                    )
                                )
                            )
                            ;if is not neither valuef or id
                            (progn
                                (setq error 1)
                                (return)
                            )
                        )
                    )
                )
                ;if is expression
                (setq temp1 (frac_to_list (exp_maker (nth 1 myList)(nth 1 valList))))
            )

            ;second expression
            (if (equal (stringp (nth 2 myList)) t )
                ;if is valuef
                (if (string= (nth 2 myList) "VALUEF")
                    (setq temp2 (frac_to_list (nth 2 valList)))
                    ;if is id
                    (progn
                        (if (string= (nth 2 myList) "ID")
                            (progn
                                (setq index (searchList (nth 2 valList) variables))
                                (if (not (equal index nil))
                                    (progn
                                        (setq temp2 (frac_to_list (nth index values)))
                                    )
                                )
                            )
                            ;if is not neither valuef or id
                            (progn
                                (setq error 1)
                                (return)
                            )
                        )
                    ) 
                )
                ;if is expression
                (setq temp2 (frac_to_list (exp_maker (nth 2 myList)(nth 2 valList))))
            )  
            ;if there is no problem
            (if (equal error 0)
                (progn
                    (setq temp3 (- (* (parse-integer (nth 0 temp1))(parse-integer (nth 1 temp2)))(* (parse-integer (nth 0 temp2))(parse-integer (nth 1 temp1)))))
                    (setq temp4 (* (parse-integer (nth 1 temp1))(parse-integer (nth 1 temp2))))
                    (setq temp3 (write-to-string temp3))
                    (setq temp4 (write-to-string temp4))
                    (return-from exp_maker (concatenate 'string temp3 "f" temp4))
                )
                (return-from exp_maker "error")
            )
        )    
    )               
    ;generate mult operator
    (if (string= (nth 0 myList)  "OP_MULT")
        ;temporary variables:
        ;temp1 = first valuef
        ;temp2 = second valuef
        ;temp3 = first value (converted to float)
        ;temp4 = second value (converted to float)
        (let ((temp1)(temp2)(temp3)(temp4)(rtn))
            ;first expression
            (if (equal (stringp (nth 1 myList)) t )
                ;if is valuef
                (if (string= (nth 1 myList) "VALUEF")
                    (setq temp1 (frac_to_list (nth 1 valList)))
                    ;if is id
                    (progn
                        (if (string= (nth 1 myList) "ID")
                            (progn
                                (setq index (searchList (nth 1 valList) variables))
                                (if (not (equal index nil))
                                    (progn
                                        (setq temp1 (frac_to_list (nth index values)))
                                    )
                                )
                            )
                            ;if is not neither valuef or id
                            (progn
                                (setq error 1)
                                (return)
                            )
                        )
                    )
                )
                ;if is expression
                (setq temp1 (frac_to_list (exp_maker (nth 1 myList)(nth 1 valList))))
            )

            ;second expression
            (if (equal (stringp (nth 2 myList)) t )
                ;if is valuef
                (if (string= (nth 2 myList) "VALUEF")
                    (setq temp2 (frac_to_list (nth 2 valList)))
                    ;if is id
                    (progn
                        (if (string= (nth 2 myList) "ID")
                            (progn
                                (setq index (searchList (nth 2 valList) variables))
                                (if (not (equal index nil))
                                    (progn
                                        (setq temp2 (frac_to_list (nth index values)))
                                    )
                                )
                            )
                            ;if is not neither valuef or id
                            (progn
                                (setq error 1)
                                (return)
                            )
                        )
                    )
                )
                ;if is expression
                (setq temp2 (frac_to_list (exp_maker (nth 2 myList)(nth 2 valList))))
            )  
            ;if there is no problem
            (if (equal error 0)
                (progn
                    (setq temp3 (* (parse-integer (nth 0 temp1))(parse-integer (nth 0 temp2))))
                    (setq temp4 (* (parse-integer (nth 1 temp1))(parse-integer (nth 1 temp2))))
                    (setq temp3 (write-to-string temp3))
                    (setq temp4 (write-to-string temp4))
                    (return-from exp_maker (concatenate 'string temp3 "f" temp4))
                )
                (return-from exp_maker "error")
            )
        )
    )
    ;generate div operator
    (if (string= (nth 0 myList)  "OP_DIV")
        ;temporary variables:
        ;temp1 = first valuef
        ;temp2 = second valuef
        ;temp3 = first value (converted to float)
        ;temp4 = second value (converted to float)
        (let ((temp1)(temp2)(temp3)(temp4)(rtn))
            ;first expression
            (if (equal (stringp (nth 1 myList)) t )
                ;if is valuef
                (if (string= (nth 1 myList) "VALUEF")
                    (setq temp1 (frac_to_list (nth 1 valList)))
                    ;if is id
                    (progn
                        (if (string= (nth 1 myList) "ID")
                            (progn
                                (setq index (searchList (nth 1 valList) variables))
                                (if (not (equal index nil))
                                    (progn
                                        (setq temp1 (frac_to_list (nth index values)))
                                    )
                                )
                            )
                            ;if is not neither valuef or id
                            (progn
                                (setq error 1)
                                (return)
                            )
                        )
                    )
                )
                ;if is expression
                (setq temp1 (frac_to_list (exp_maker (nth 1 myList)(nth 1 valList))))
            )

            ;second expression
            (if (equal (stringp (nth 2 myList)) t )
                ;if is valuef
                (if (string= (nth 2 myList) "VALUEF")
                    (setq temp2 (frac_to_list (nth 2 valList)))
                    ;if is id
                    (progn
                        (if (string= (nth 2 myList) "ID")
                            (progn
                                (setq index (searchList (nth 2 valList) variables))
                                (if (not (equal index nil))
                                    (progn
                                        (setq temp2 (frac_to_list (nth index values)))
                                    )
                                )
                            )
                            ;if is not neither valuef or id
                            (progn
                                (setq error 1)
                                (return)
                            )
                        )
                    )
                )
                ;if is expression
                (setq temp2 (frac_to_list (exp_maker (nth 2 myList)(nth 2 valList))))
            )  
            ;if there is no problem
            (if (equal error 0)
                (progn
                    (setq temp3 (* (parse-integer (nth 0 temp1))(parse-integer (nth 1 temp2))))
                    (setq temp4 (* (parse-integer (nth 1 temp1))(parse-integer (nth 0 temp2))))
                    (setq temp3 (write-to-string temp3))
                    (setq temp4 (write-to-string temp4))
                    (return-from exp_maker (concatenate 'string temp3 "f" temp4))
                )
                (return-from exp_maker "error")
            )
        )
    )
    ;generate valuef
    (if (string= (nth 0 myList)  "VALUEF")
        (return-from exp_maker (nth 0 valList))
    )
    ;generate id of call function with function id
    (if (and (string= (nth 0 myList)  "ID")(equal (length myList) 1))
        (if (not (equal (searchList (nth 0 valList) functions) nil))
            ;if is function call
            (progn
                (setq index (searchList (nth 0 valList) functions))
                (return-from exp_maker (explist_maker (nth index f_values_2)(nth index f_values)))
            )
            ;if is just id
            (return-from exp_maker (nth 0 valList))
        )
    )
    ;generate id with parameters
    (if (and (string= (nth 0 myList)  "ID")(equal (length myList) 2))
        (if (not (equal (searchList (nth 0 valList) functions) nil))
            ;if is function call
            (progn
                (setq index (searchList (nth 0 valList) functions))
                (set_parameters (nth 1 valList) index)
                (return-from exp_maker (explist_maker (nth index f_values_2)(nth index f_values)))
            )
            ;if is just id
            (return-from exp_maker (nth 0 myList)(nth 0 valList))
        )   
    )
    ;generate deffine variable
    (if (string= (nth 0 myList)  "DEFV")
        (if (equal (searchList (nth 1 valList) variables) nil)
            ;if there is no variable that has same id
            (progn
                (setq variables (cons (nth 1 valList) variables))
                (if (equal (stringp (nth 2 myList)) t)
                    ;if value is string
                    (progn
                        (setq values (cons (exp_maker (list (nth 2 myList))(list (nth 2 valList))) values))
                    )
                    ;if value is expression
                    (progn
                        (setq values (cons (exp_maker (nth 2 myList)(nth 2 valList)) values))
                    )
                )
                (return-from exp_maker "0f1")
            )
            ;if there is already variable that has same id
            (progn
                (write-line "error variable already defined")
                (setq error 1)
                (return-from exp_maker nil)
            )
        )   
    )
    ;generate set variable
    (if (string= (nth 0 myList)  "KW_SET")
        (if (not(equal (searchList (nth 1 valList) variables) nil))
            ;if there is a variable that has thit id
            (progn
                ;index of that variable in variables list
                (setq index (searchList (nth 1 valList) variables))
                (setq temp (list))

                (loop for i from 0 to ( -(length values) 1) 
                    do
                    (if (equal i index)
                        (progn
                            (if (equal (stringp (nth 2 myList)) t) 
                                ;if is string
                                (setq temp (cons (exp_maker (list (nth 2 myList))(list (nth 2 valList))) temp))
                                ;if is expression
                                (setq temp (cons (exp_maker (nth 2 myList)(nth 2 valList)) temp))
                            )
                        )
                        (setq temp (cons (nth i values) temp))
                    )
                )
                (setq values (reverse temp))
            )
            ;if there is no variable that has this id
            (progn
                (write-line "error there is no variable with that name")
                (setq error 1)
                (return-from exp_maker nil)
            )
        )
    )   
    ;generate if statement
    (if (string= (nth 0 myList)  "KW_IF")
        ;if it is if-else
        (if (equal (length myList) 4)
            (progn
                ;control boolean expression
                (if (expb_maker (nth 1 myList)(nth 1 valList))
                    ;if it is true
                    (progn
                        (if (explist_control (nth 2 myList))
                            (return-from exp_maker (explist_maker (nth 2 myList)(nth 2 valList)))
                            (return-from exp_maker (exp_maker (nth 2 myList)(nth 2 valList)))
                        )
                    )
                    ;if it is false
                    (progn
                        (if (explist_control (nth 3 myList))
                            (return-from exp_maker (explist_maker (nth 3 myList)(nth 3 valList)))
                            (return-from exp_maker (exp_maker (nth 3 myList)(nth 3 valList)))
                        )
                    )  
                )
            )
            ;if there is no else
            (progn
                (if (expb_maker (nth 1 myList)(nth 1 valList))
                    (progn
                        (if (explist_control (nth 2 myList))
                            (return-from exp_maker (explist_maker (nth 2 myList)(nth 2 valList)))
                            (return-from exp_maker (exp_maker (nth 2 myList)(nth 2 valList)))
                        )
                    )
                )
            )
        )    
    ) 
    ;generate while statement
    (if (string= (nth 0 myList)  "KW_WHILE")
        (loop
            (if (not (expb_maker (nth 1 myList)(nth 1 valList)))
                (return)
                (progn
                    (if (explist_control (nth 2 myList))
                        (progn
                            (write (explist_maker (nth 2 myList)(nth 2 valList)))
                            (write-line "")
                        )
                        (progn
                            (write (exp_maker (nth 2 myList)(nth 2 valList)))
                            (write-line "")
                        )
                    )
                )
            )
        )     
    )
)
;------------------------------------------ 

;FUNCTION THAT GENERATES BOOLEAN EXPRESSION
;------------------------------------------ 
(defun expb_maker (myList valList)
    ;equal expression
    (if (string= (nth 0 myList)  "KW_EQUAL")
        ;temporary variables
        ;temp1 = first value
        ;temp2 = second value
        (let ((temp1)(temp2))
            ;first expression
            (if (equal (stringp (nth 1 myList)) t)
                ;if is valuef
                (if (string= (nth 1 myList) "VALUEF")
                    (setq temp1 (frac_to_list (nth 1 valList)))
                    ;if is id
                    (progn
                        (if (string= (nth 1 myList) "ID")
                            (progn
                                (setq index (searchList (nth 1 valList) variables))
                                (if (not (equal index nil))
                                    (progn
                                        (setq temp1 (frac_to_list(nth index values)))
                                    )
                                )
                            )
                            ;if is not neither valuef or id
                            (progn
                                (setq error 1)
                                (return)
                            )
                        )
                    )
                )
                ;if is expression
                (setq temp1 (exp_maker (nth 1 myList)(nth 1 valList)))
            )

            ;second expression
            (if (equal (stringp (nth 2 myList)) t)
                ;if is valuef
                (if (string= (nth 2 myList) "VALUEF")
                    (setq temp2 (frac_to_list (nth 2 valList)))
                    ;if is id
                    (progn
                        (if (string= (nth 2 myList) "ID")
                            (progn
                                (setq index (searchList (nth 2 valList) variables))
                                (if (not (equal index nil))
                                    (progn
                                        (setq temp2 (frac_to_list(nth index values)))
                                    )
                                )
                            )
                            ;if is not neither valuef or id
                            (progn
                                (setq error 1)
                                (return)
                            )
                        )
                    )
                )
                ;if is expression
                (setq temp2 (exp_maker (nth 2 myList)(nth 2 valList)))
            )
            ;return value
            (return-from expb_maker (equal (/ (parse-integer (nth 0 temp1)) (parse-integer (nth 1 temp1))) (/ (parse-integer (nth 0 temp2)) (parse-integer (nth 1 temp2)))))
        )
    )
    (if (string= (nth 0 myList)  "KW_GT")
        ;temporary variables
        ;temp1 = first value
        ;temp2 = second value
        (let ((temp1)(temp2))
            ;first expression
            (if (equal (stringp (nth 1 myList)) t)
                ;if is valuef
                (if (string= (nth 1 myList) "VALUEF")
                    (setq temp1 (frac_to_list (nth 1 valList)))
                    ;if is id
                    (progn
                        (if (string= (nth 1 myList) "ID")
                            (progn
                                (setq index (searchList (nth 1 valList) variables))
                                (if (not (equal index nil))
                                    (progn
                                        (setq temp1 (frac_to_list(nth index values)))
                                    )
                                )
                            )
                            ;if is not neither valuef or id
                            (progn
                                (setq error 1)
                                (return)
                            )
                        )
                    )
                )   
                ;if is expression
                (setq temp1 (exp_maker (nth 1 myList)(nth 1 valList)))
            )

            ;second expression
            (if (equal (stringp (nth 2 myList)) t)
                ;if is valuef
                (if (string= (nth 2 myList) "VALUEF")
                    (setq temp2 (frac_to_list (nth 2 valList)))
                    ;if is id
                    (progn
                        (if (string= (nth 2 myList) "ID")
                            (progn
                                (setq index (searchList (nth 2 valList) variables))
                                (if (not (equal index nil))
                                    (progn
                                        (setq temp2 (frac_to_list(nth index values)))
                                    )
                                )
                            )
                            ;if is not neither valuef or id
                            (progn
                                (setq error 1)
                                (return)
                            )
                        )
                    )
                )
                ;if is expression
                (setq temp2 (exp_maker (nth 2 myList)(nth 2 valList)))
            )
            (return-from expb_maker (> (/ (parse-integer (nth 0 temp1)) (parse-integer (nth 1 temp1))) (/ (parse-integer (nth 0 temp2)) (parse-integer (nth 1 temp2)))))
        )
    )
    (if (string= (nth 0 myList)  "KW_AND")
        (progn 
            ;first expression
            (if (equal (stringp (nth 1 myList)) t)
                (progn
                    ;if is true
                    (if (string= (nth 1 myList) "KW_TRUE") 
                        (setq first_s t)
                        ;if is false
                        (if (string= (nth 1 myList) "KW_FALSE") 
                            (setq first_s nil)
                            ;if is neither true or false
                            (progn 
                                (setq error 1)
                                (write-line "error")
                                (return)
                            )
                        )
                    )
                )
                ;if is expression
                (setq first_s (expb_maker (nth 1 myList)(nth 1 valList)))
            )

            ;second expression
            (if (equal (stringp (nth 2 myList)) t)
                (progn
                    ;if is true
                    (if (string= (nth 2 myList) "KW_TRUE") 
                        (setq second_s t)
                        ;if is false
                        (if (string= (nth 2 myList) "KW_FALSE") 
                            (setq second_s nil)
                            ;if is not neiher true or false
                            (progn 
                                (setq error 1)
                                (write-line "error")
                                (return)
                            )
                        )
                    )
                )
                ;if is expression
                (setq second_s (expb_maker (nth 2 myList)(nth 2 valList)))
            )
            (return-from expb_maker (and first_s second_s))
        )
    )
    (if (string= (nth 0 myList)  "KW_OR")
        (progn 
            ;first expression
            (if (equal (stringp (nth 1 myList)) t)
                ;if is true
                (progn
                    (if (string= (nth 1 myList) "KW_TRUE") 
                        (setq first_s t)
                        ;if is faluse
                        (if (string= (nth 1 myList) "KW_FALSE") 
                            (setq first_s nil)
                            ;if is neither true or false
                            (progn 
                                (setq error 1)
                                (write-line "error")
                                (return)
                            )
                        )
                    )
                )
                ;if is expression
                (setq first_s (expb_maker (nth 1 myList)(nth 1 valList)))
            )

            ;second expression
            (if (equal (stringp (nth 2 myList)) t)
                (progn
                    ;if is true
                    (if (string= (nth 2 myList) "KW_TRUE") 
                        (setq second_s t)
                        ;if is false
                        (if (string= (nth 2 myList) "KW_FALSE") 
                            (setq second_s nil)
                            ;if is not neither true or false
                            (progn 
                                (setq error 1)
                                (write-line "error")
                                (return)
                            )
                        )
                    )
                )
                ;if is expression
                (setq second_s (expb_maker (nth 2 myList)(nth 2 valList)))
            )
            (return-from expb_maker (or first_s second_s))
        )
    )
    (if (string= (nth 0 myList)  "KW_TRUE")
        (return-from expb_maker t)
    )
    (if (string= (nth 0 myList)  "KW_FALSE")
        (return-from expb_maker nil)
    )
    (if (string= (nth 0 myList)  "KW_NOT")
        (progn 
            (if (equal (stringp (nth 1 myList)) t)
                (progn
                    ;if is true
                    (if (string= (nth 1 myList) "KW_TRUE") 
                        (setq first_s t)
                        ;if is false
                        (if (string= (nth 1 myList) "KW_FALSE") 
                            (setq first_s nil)
                            ;if is not neither true or false
                            (progn 
                                (setq error 1)
                                (write-line "error")
                                (return)
                            )
                        )
                    )
                )
                ;if is expression
                (setq first_s (expb_maker (nth 1 myList)(nth 1 valList)))
            )
            (return-from expb_maker (not first_s))
        )
    )
)
;------------------------------------------ 

;FUNCTION THAT GENERATES EXPRESSION LIST
;------------------------------------------ 
(defun explist_maker (myList valList)
    ;if there is 1 expression
    (if (equal (stringp (nth 0 myList)) t)
        (setq rtn (exp_maker myList valList))
        
        (progn
            ;if there is 2 expression
            (if (equal (length myList) 2)
                (progn
                    (if (equal (stringp (nth 0 myList)) t)
                        (setq rtn (exp_maker (list (nth 0 myList))(list (nth 0 valList))))
                        (setq rtn (exp_maker (nth 0 myList)(nth 0 valList)))
                    )
                    (if (equal (stringp (nth 1 myList)) t)
                        (setq rtn (exp_maker (list (nth 1 myList))(list (nth 1 valList))))
                        (setq rtn (exp_maker (nth 1 myList)(nth 1 valList)))
                    )
                )
            )
            ;if there is 3 expression)
            (if (equal (length myList) 3)
                (progn
                    (if (equal (stringp (nth 0 myList)) t)
                        (exp_maker (list (nth 0 myList))(list (nth 0 valList)))
                        (exp_maker (nth 0 myList)(nth 0 valList))
                    )
                    (if (equal (stringp (nth 1 myList)) t)
                        (exp_maker (list (nth 1 myList))(list (nth 1 valList)))
                        (exp_maker (nth 1 myList)(nth 1 valList))
                    )
                    (if (equal (stringp (nth 2 myList)) t)
                        (setq rtn (exp_maker (list (nth 2 myList))(list (nth 2 valList))))
                        (setq rtn (exp_maker (nth 2 myList)(nth 2 valList)))
                    )
                )
            )
            ;if there is 4 expression
            (if (equal (length myList) 4)
                (progn
                    (if (equal (stringp (nth 0 myList)) t)
                        (exp_maker (list (nth 0 myList))(list (nth 0 valList)))
                        (exp_maker (nth 0 myList)(nth 0 valList))
                    )
                    (if (equal (stringp (nth 1 myList)) t)
                        (exp_maker (list (nth 1 myList))(list (nth 1 valList)))
                        (exp_maker (nth 1 myList)(nth 1 valList))
                    )
                    (if (equal (stringp (nth 2 myList)) t)
                        (exp_maker (list (nth 2 myList))(list (nth 2 valList)))
                        (exp_maker (nth 2 myList)(nth 2 valList))
                    )
                    (if (equal (stringp (nth 3 myList)) t)
                        (setq rtn (exp_maker (list (nth 3 myList))(list (nth 3 valList))))
                        (setq rtn (exp_maker (nth 3 myList)(nth 3 valList)))
                    )
                )
            )
            ;if there is 5 expression
            (if (equal (length myList) 5)
                (progn
                    (if (equal (stringp (nth 0 myList)) t)
                        (exp_maker (list (nth 0 myList))(list (nth 0 valList)))
                        (exp_maker (nth 0 myList)(nth 0 valList))
                    )
                    (if (equal (stringp (nth 1 myList)) t)
                        (exp_maker (list (nth 1 myList))(list (nth 1 valList)))
                        (exp_maker (nth 1 myList)(nth 1 valList))
                    )
                    (if (equal (stringp (nth 2 myList)) t)
                        (exp_maker (list (nth 2 myList))(list (nth 2 valList)))
                        (exp_maker (nth 2 myList)(nth 2 valList))
                    )
                    (if (equal (stringp (nth 3 myList)) t)
                        (exp_maker (list (nth 3 myList))(list (nth 3 valList)))
                        (exp_maker (nth 3 myList)(nth 3 valList))
                    )
                    (if (equal (stringp (nth 4 myList)) t)
                        (setq rtn (exp_maker (list (nth 4 myList))(list (nth 4 valList))))
                        (setq rtn (exp_maker (nth 4 myList)(nth 4 valList)))
                    )
                )
            )
            ;if there is 6 expression
            (if (equal (length myList) 6)
                (progn
                    (if (equal (stringp (nth 0 myList)) t)
                        (exp_maker (list (nth 0 myList))(list (nth 0 valList)))
                        (exp_maker (nth 0 myList)(nth 0 valList))
                    )
                    (if (equal (stringp (nth 0 myList)) t)
                        (exp_maker (list (nth 0 myList))(list (nth 0 valList)))
                        (exp_maker (nth 0 myList)(nth 0 valList))
                    )
                    (if (equal (stringp (nth 0 myList)) t)
                        (exp_maker (list (nth 0 myList))(list (nth 0 valList)))
                        (exp_maker (nth 0 myList)(nth 0 valList))
                    )
                    (if (equal (stringp (nth 0 myList)) t)
                        (exp_maker (list (nth 0 myList))(list (nth 0 valList)))
                        (exp_maker (nth 0 myList)(nth 0 valList))
                    )
                    (if (equal (stringp (nth 0 myList)) t)
                        (exp_maker (list (nth 0 myList))(list (nth 0 valList)))
                        (exp_maker (nth 0 myList)(nth 0 valList))
                    )
                    (if (equal (stringp (nth 0 myList)) t)
                        (setq rtn  (exp_maker (list (nth 0 myList))(list (nth 0 valList))))
                        (setq rtn  (exp_maker (nth 0 myList)(nth 0 valList)))
                    )
                )
            )
        )
    )
    ;rtn is generated value of last expression in expression list
    rtn
)
;------------------------------------------ 

;FUNCTION THAT DEFINES FUNCTION
;------------------------------------------ 
(defun func_maker (myList valList)
    (progn
        ;if there is not a function that has same id
        (if (equal (searchList (nth 1 valList) functions) nil)
            (progn
                ;if there is no parameter list
                (if (equal (length myList) 3)
                    (progn
                        (setq functions (cons (nth 1 valList) functions))
                        (setq f_values  (cons (nth 2 valList) f_values))
                        (setq f_values_2(cons (nth 2 myList)  f_values_2))
                    )
                )
                ;if there is parameter list
                (if (equal (length myList) 4)
                    (progn
                        (setq functions    (cons (nth 1 valList) functions))
                        (setq f_parameters (cons (nth 2 valList) f_parameters))
                        (set_func_variables (nth 2 valList))
                        (setq f_values     (cons (nth 3 valList) f_values))
                        (setq f_values_2   (cons (nth 3 myList)  f_values_2))
                    )
                )
            )
            ;if there is a function that has same id
            (progn
                (write-line "error function already defined")
                (setq error 1)
                (return)
            )
        )
        ;function definition returns 0f1
        (return-from func_maker "0f1")
    )
)
;------------------------------------------ 

;FUNCTION THAT CONVERTS VALUEF TO VALUEI FOR OPERATIONS
;------------------------------------------ 
(defun frac_to_list (f)
    ;temporary variables
    ;temp = temporary string
    ;temp1 = numerator
    ;temp2 = denominator
    (let ((temp "") (i 0)(temp1)(temp2))
        (loop   
            ;loop until 'f'
            (when (string= (subseq f i (+ 1 i)) "f") 
                (return)
            )
            ;ignore '(' and ')'
            (if (and (not (string= (subseq f i (+ 1 i)) ")"))(not (string= (subseq f i (+ 1 i)) "(")))
                (setq temp (concatenate 'string temp (subseq f i (+ 1 i))))
            )
            (setq i (+ 1 i))
        )
        ;set numerator 
        (setq temp1 temp)
        ;clean temp 
        (setq temp (list))
        ;jump next char
        (setq i (+ 1 i))
        (loop
            ;loop until 'f'
            (when (equal (length f) i) 
                (return)
            )
            ;ignore '(' and ')'
            (if (and (not (string= (subseq f i (+ 1 i)) ")"))(not (string= (subseq f i (+ 1 i)) "(")))
                (setq temp (concatenate 'string temp (subseq f i (+ 1 i))))
            )
            (setq i (+ 1 i))
        )
        ;set denominator
        (setq temp2 temp)
        (return-from frac_to_list (list temp1 temp2))
    )
)
;------------------------------------------ 

;FUNCTION THAT DEFINE FUNCTION PARAMETERS AS VARIABLE
;------------------------------------------ 
(defun set_func_variables (parameters)
    (let ((i (length parameters)))
        (loop 
            ;loop up to the length of parameters
            (when (equal i 0) (return))
            ;if there is no variable that has same id
            (if (equal (searchList (nth (- i 1) parameters) variables) nil)
                (progn
                    (setq variables (cons (nth (- i 1) parameters) variables))
                    (setq values    (cons "0f1" values))
                )
            )
            (setq i (- i 1))
        )
    )
)
;------------------------------------------ 

;FUNCTION THAT SET FUNCTION PARAMETERS WITH GIVEN PARAMETER VALUES
;------------------------------------------ 
(defun set_parameters (valList index)

    (setq len (length valList))
    (loop for j from 0 to len
        ;loop for control number of parameters
        do

        ;index of parameter in variables list
        (setq index2 (searchList (nth j (nth index f_parameters)) variables))
        (setq temp (list))

        (loop for i from 0 to ( -(length values) 1) 
            do
            ;loop up to the length of values
            ;search for parameter index and change values list
            (if (equal i index2)
                (setq temp (cons (nth j valList) temp))
                (setq temp (cons (nth i values) temp))
            )
        )
        ;set values with new list
        (setq values (reverse temp))   
    )
)
;------------------------------------------ 

;CALL INTERPRETER
;----------------
(gppinterpreter)
;----------------