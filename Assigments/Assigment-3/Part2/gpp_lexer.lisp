; Check list for control possible errors
(setq possible_error (list "(" ")" "\""))

; Check value to control if it is first or second quotes 
(setq op_c 0)

; exit control value for program
(setq exit1 0)

; exit control value for word_control function
(setq exit2 0)

; check lists
;keyword list for control
(setq keywords (list "and" "or" "not" "eq" "gt" "nil" "list" "set" "defvar" "deffun" "while" "if" "exit" "load" "disp" "true" "false"))
;keyword list for print 
(setq kw (list "KW_AND" "KW_OR" "KW_NOT" "KW_EQUAL" "KW_GT" "KW_NIL" "KW_LIST" "KW_SET" "DEFV" "DEFF" "KW_WHILE" "KW_IF" "KW_EXIT" "KW_LOAD" "KW_DISP" "KW_TRUE" "KW_FALSE"))

;operator list for control
(setq operators (list "+" "-" "/" "**" "*" "(" ")" "\"" "\"" ","))
;operator list for print
(setq op (list "OP_PLUS" "OP_MINUS" "OP_DIV" "OP_DBLMULT" "OP_MULT" "OP_OP" "OP_CP" "OP_OC" "OP_CC" "OP_COMMA"))
;comment control
(setq comment ";")

;Main program
(defun gpplexer(myList valList)
    ;program work until user enter (exit)       
        ;read line
        (defparameter str (read-line)) 

        ;sprit line to words
        (let 
            ;word list
            ((words (list)))
           
            ;sprit line to words and returun that word list with split_string function
            (setq words (split_string str))

            ;control all words in the line
            (loop for word in words
			    do

                ;control exit
                (if (string= word "exit")
                    (progn
                        (setq exit1 1)
                        (return)
                    )
                )

                ;end line 
                (if (equal (word_control word myList valList) 2)
                    (progn 
                        (return)    
                    )
		        )  
                     
            )
        )          
)

;function that splits line to words 
;parameters: string 
;optional: nl (return string)
(defun split_string(str &optional nl)   
    (let 
        ((i 
            (position " " str
		    :from-end t
		    :test #'
            (lambda (a b) (find b a :test #'string=)))
        ))      
        (if i
	        (split_string (subseq str 0 i) (cons (subseq str (1+ i)) nl))
            (cons str nl)
        )
    )
)

;function that control and analyze words
(defun word_control(word myList valList)
    ; len: lenght of the word  
    ; word1: subword of word (fragmentation of the word)
    (let ((len (length word)) (word1) (j 0) (index) (temporary) (nm 0))
        (setq exit2 0)
        (setq list_rtn (list))
        (loop for i from 1 to len
            do
            ; check for possible error of exit value
            (if (equal exit2 1) (setq exit2 0))
            (setq word1 (string-downcase (subseq word j i)))

            ; comment control
            (if (and (equal exit2 0) (>= len 2) (string= (subseq word 0 1) comment)) 
                (if (string= (subseq word 1 2) comment)
                    (progn  
                        (setq myList (cons '"COMMENT" myList))
                        (setq exit2 2)
                    )
                )
            )
            
            ; is word a operator?
            ; operator_control_v is return value of operator control function
            ; if operator_control_v is 1, than word is operator
            (if (not (equal (setq myList(operator_control word word1 myList valList)) nil ))
                (progn
                    (setq j i) 
                    (setq exit2 1)
                )         
            )             
            
            ; value_control_v is return value of value control function
            ; if value_control_v is 1, than word is value
            (setq value_control_v (value_control word word1 i j len myList valList))
            (if (and (equal exit2 0) (not (equal value_control_v nil)) )
                (progn 
                    (setq i value_control_v)
                    (setq j i)
                    (setq exit2 1)
                )
            )
            
            ; is word a keyword?
            (setq keyword_control_v (keyword_control word word1 i len myList valList))

            ; keyword_control_v is return value of keyword control function
            ; if keyword_control_v is 1, than word is keyword
            (if (and (equal exit2 0) (not (equal keyword_control_v nil)) )
                (progn 
                    (if (equal keyword_control_v 1)
                        (setq j i)
                    )
                    (setq exit2 1)
                )
            )

            ; is word a identifier?
            (if (equal exit2 0)
                (progn
                    ; identifier_control_v is return value of identifier control function
                    ; if identifier_control_v is 1, than word is identifier
                    (setq identifier_control_v (identifier_control word word1 i j len myList valList))
                    (if (not (equal identifier_control_v nil)) 
                        (progn 
                            (if (equal identifier_control_v 1)
                                (setq j i)  
                            )
                            (setq exit2 1)
                        )
                    )
                )   
            )

            ; exit control
            (if (or (= exit2 -1) (= exit2 2)) (return exit2))
            
        )
    )
)

;function that control word is operator or not
;parameters: word and subword of word
(defun operator_control (x x2 'myList 'valList)
    ;index = return value of searchList function
    (setq index (searchList x2 operators))

    ;if it is not NULL
    (if (not (equal index nil))
        (progn

            ;if it is "
            (if (equal index 7) 
                (progn 
                    ;if it is first "
                    (if (equal op_c 0)
                        (progn
                            (setq op_c 1)
                        )
                    ;if it is second "
                        (progn
                            (setq op_c 0)
                        )
                    )
                    (setq index (+ index (mod op_c 2))) 
                )
            )

            ;print operator analyze
            ;x2 = value
            (setq myList (cons (nth index op) myList))
            (setq valList (cons x2 valList))
        )
    )
    index
)

;function that control word is keyword or not
;parameters: word,subword of word,index of word,length of word
(defun keyword_control (x x2 i len 'myList 'valList)
    ;rtn = return value
    (setq rtn nil)
    ;return value of searchList function
    (setq index (searchList x2 keywords))
    ;if it is not NULL
    (if (not (equal index nil)) 
        ;control length
        (if (>= i len)
            (progn
                ;x = value
                (setq myList (cons (nth index kw) myList))
                (setq valList (cons x2 valList))
                (setq rtn 0)
            )
            
            (progn
                ;possible error control
                (setq temporary (subseq x i (+ i 1)))
                (if (equal (searchList temporary possible_error) nil)
                    (if (equal (identifier_control_helper (concatenate 'string x2 temporary)) nil)
                        (progn
                            (format t "SYNTAX_ERROR ~S can not be tokenized.~%" (subseq x2 j len))
                            (setq exit2 -1)
                        )
                    )
                    ;if there is no error
                    (progn
                        ;x = value
                        (setq myList (cons (nth index kw) myList))
                        (setq valList (cons x2 valList))
                        (setq rtn 1)                     
                    )
                )
            )        
        )        
    )
    rtn
)

;function that control word is identifier or not
;parameters: word,subword of word,index of word,length of word
(defun identifier_control (x x2 i j len 'myList 'valList)
    ;rtn = return value
    (setq rtn nil)
    ;return value of identifier control help function
    (setq index (identifier_control_helper x2))

    (if (and (equal exit2 0) (equal index t) )
                    (if (= i len)
                        (progn
                            ;x = value
                            (setq myList (cons '"ID" myList))
                            (setq valList (cons x2 valList))
                            (setq rtn 0)
                        )             

                        (progn
                            ;temporary for control possible errors
                            (setq temporary(subseq x j (+ i 1)))
                            (setq nm (identifier_control_helper temporary))
                            ;possible error control
                            (if (not (equal index nm))
                                (progn
                                    ;check temporary word indexes in possible error list
                                    (setq temporary (subseq x i (+ i 1)))
                                    (if (equal (searchList temporary possible_error) nil)
                                        (progn 
                                            (setq exit2 -1) 
                                            (write-line "ident icinde")
                                        )
                                        (progn 
                                            ;x = value
                                            (setq myList (cons '"ID" myList))
                                            (setq valList (cons x2 valList))
                                            (setq rtn 1) 
                                        )
                                    )
                                )
                            )
                        )
                    )
                    (progn
                        (setq exit2 -1)
                    )
                )   
    rtn
)

;function that control word is value or not
;parameters: word,subword of word,index1 of word,index2 of word,length of word
(defun value_control (x x2 i j len 'myList 'valList)

    ;rtn = return value
    (setq rtn nil)
    ; return value of value control helper function
    (setq index (value_control_helper x2))

    (if (not (equal index nil))
            (progn
                (loop
                    (setq i (+ i 1))
                    (when (or (equal (value_control_helper (subseq x j (- i 1))) nil) (> i len)) 
                    (return))
                )
                (setq i (- i 1))
                ;possible error control 
                (if (equal (value_control_helper (subseq x j i)) nil) 
                    (progn
                        (setq i (- i 1))
                        (if (equal (searchList (subseq x i (+ i 1)) possible_error) nil)
                            (progn
                                (if (string= (subseq x i (+ i 1)) "f")
                                    (progn
                                        (setq myList (cons '"VALUEF" myList))
                                        (setq temp x)
                                        (setq i2 0)

                                        (loop for i from 0 to (length x)
                                            do
                                            (if (string= (subseq temp 0 1) "(")
                                                (setq temp (subseq temp 1))
                                            )
                                        )
                                        
                                        (loop for i from 0 to (length x)
                                            do
                                            (if (string= (subseq (reverse temp) 0 1) ")")
                                                (setq temp (reverse (subseq (reverse temp) 1)))
                                            )
                                        )

                                        (setq valList(cons temp valList))
                                        (loop 
                                            (if (or (equal (subseq temp i) "") (equal (subseq temp i) ")")) (return))
                                            (setq i (+ i 1))
                                        )
                                    )
                                )
                            )
                            (progn
                                (setq exit2 -1)
                            )
                        )
                    )
                    (progn
                        (setq exit2 -1)
                    )
                )	
                (setq rtn i)							     
            )	
        )

    
    rtn
)

;function that search and check if word in the list
;parameters: word, list for check
;recursive function
(defun searchList (x control_list &optional (i 0))
	(if (null control_list)
		nil
        ;if value in the list
		(if (string= x (car control_list))
			i
            ;return this otherwise return nil
			(searchList x (cdr control_list) (+ i 1))
		)
	)
)

;function that help the main idenifier control function
;parameters: word
(defun identifier_control_helper (x)
    (let ((len (- (length x) 1)) (lett "") (index t))
        (loop for i from 0 to len
            do
            (progn
                (setq lett (char x i))
                (if (= i 0)
					(if (or (alpha-char-p lett) (char= lett #\_)) 
                        (setq index t) 
                        (setq index nil)
                    )
					(if (or (alpha-char-p lett) (digit-char-p lett) (char= lett #\_)) 
                        (setq index t) 
                        (setq index nil)
                    )
				)
                (if (equal index nil) (return index))           
            )       
        )
        index    
    )
)

;function that help the main value control function
;parameters: word
(defun value_control_helper (x)
	(let ((lett "") (index t))
		(if (equal (every #'digit-char-p x) nil)
			(setq index nil) 
			(setq index t) 
		)
		index	
	)
)