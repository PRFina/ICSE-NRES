
; To use in dev
(deffunction real_to_system_calendar(?day)
    (bind ?r (+ 1 (mod (- ?day 15) 365)))
    (if (< ?r 0) 
        then (return (+ ?r 365))
        else (return ?r))  
)

(deffunction init_rank()
(bind ?categories (deftemplate-slot-allowed-values desease category))
(bind ?structures (deftemplate-slot-allowed-values symptom structure))

   (loop-for-count (?i 1 (length$ ?categories))
       do
       (bind ?category (nth$ ?i ?categories))
       
       (loop-for-count (?j 1 (length$ ?structures))
           do
           (bind ?structure (nth$ ?j ?structures))
           (assert (damaged_structs_rank (categoria ?category)
                                         (struttura ?structure)
                                         (counter 0)
                                         (asserted_slots (create$))
                                         (global_rank 0)))
       )
   )
)

; To use in production
;(deffunction real_to_system_calendar()
;    (bind ?day (nth$ 8 (create$ (local-time))))
;    (bind ?day (+ 1 ?day)) ;; local-time return day passed in range 0-365 http://www.agr.unideb.hu/~agocs/informatics/11_e_unix/unixhelp/unixhelp.ed.ac.uk/CGI/man-cgi3ccc.html?localtime+3
;    (bind ?r (+ 1 (mod (- ?day 15) 365)))
;    (if (< ?r 0) 
;        then (return (+ ?r 365))
;        else (return ?r))  
;)