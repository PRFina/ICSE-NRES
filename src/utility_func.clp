
;; Map a day expressed in the real calendar into
;; a day expressed in the system calendar
;; (look @ pdf file for more info)
(deffunction MAIN::real_to_system_calendar(?day)
    (bind ?r (+ 1 (mod (- ?day 15) 365)))
    (if (< ?r 0) 
        then (return (+ ?r 365))
        else (return ?r))  
)

;; Function to ask a question to user
;; return the answer from user input
(deffunction MAIN::ask_question (?question $?allowed-values)
    (printout t ?question crlf)
    (bind ?answer (read))
    (if (lexemep ?answer) 
        then (bind ?answer (lowcase ?answer)))
    (while (not (member$ ?answer ?allowed-values)) do
        (printout t ?question)
        (bind ?answer (read))
        (if (lexemep ?answer) 
            then (bind ?answer (lowcase ?answer)))
    )
    (if (eq ?answer altro) 
        then (printout t "quale? ")
             (bind ?answer (read)))
        (if (lexemep ?answer) 
            then (bind ?answer (lowcase ?answer))) 
    ?answer
)

;; Binary question to get yes or no from user
;; return true if yes, false otherwise
(deffunction MAIN::binary_question (?question)
   (bind ?response (ask_question ?question yes no y n))
   (if (or (eq ?response yes) (eq ?response y))
        then TRUE 
    else FALSE)
)

;; Generate a multifield with each value from first to second argument
;; return multifield
(deffunction MAIN::range_two_val(?first ?second)
    (bind $?value (create$))
    (if (< ?first ?second)
    then
        (loop-for-count (?i ?first ?second) do
            (bind $?value (insert$ ?value 1 ?i))
        )
    )
$?value
)

;; Dummy Rule. Needed because restart clear the focus stack
;; and return the focus to the main module
(defrule MAIN::init 
    =>
    (focus SYS)
)
 
(deffunction MAIN::check_date(?date)
    (bind ?flag false)
    (if (neq ?date x)
    then
        (bind ?day (integer (string-to-field (sub-string 1 2 (str-cat ?date)))))
        (bind ?month (integer (string-to-field (sub-string 4 5 (str-cat ?date)))))
        (bind ?year (integer (string-to-field (sub-string 7 10 (str-cat ?date))))) 
        (if (and (< ?day 32)
                (> ?day 0)
            (< ?month 13)
                (> ?month 0)
            (< ?year 2100)
                (> ?year 420))
            then (bind ?flag true)
        )
        ?flag
    )
    ?flag
)

(deffunction MAIN::str_replace (?string ?char ?replace)
    (bind ?new_string "")
    (loop-for-count (?i 1 (length$ ?string)) do
        (bind ?c (sub-string ?i ?i ?string))
        (if (eq ?c ?char) then (bind ?c ?replace))
        (bind ?new_string (str-cat ?new_string ?c))
    )
    ?new_string
)