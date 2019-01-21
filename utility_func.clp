
; To use in dev
(deffunction MAIN::real_to_system_calendar(?day)
    (bind ?r (+ 1 (mod (- ?day 15) 365)))
    (if (< ?r 0) 
        then (return (+ ?r 365))
        else (return ?r))  
)

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
        then (printout t "quale?")
             (bind ?answer (read)))
    (if (lexemep ?answer) 
        then (bind ?answer (lowcase ?answer))) 
   ?answer
)

(deffunction MAIN::binary_question (?question)
   (bind ?response (ask_question ?question yes no y n))
   (if (or (eq ?response yes) (eq ?response y))
        then TRUE 
    else FALSE)
)

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

;; Needed because restart clear the focus stack and return the focus to the main module
(defrule MAIN::init 
    =>
    (focus SYS)
)
 
;Function to star app

; To use in production
;(deffunction real_to_system_calendar()
;    (bind ?day (nth$ 8 (create$ (local-time))))
;    (bind ?day (+ 1 ?day)) ;; local-time return day passed in range 0-365 http://www.agr.unideb.hu/~agocs/informatics/11_e_unix/unixhelp/unixhelp.ed.ac.uk/CGI/man-cgi3ccc.html?localtime+3
;    (bind ?r (+ 1 (mod (- ?day 15) 365)))
;    (if (< ?r 0) 
;        then (return (+ ?r 365))
;        else (return ?r))  
;)