
; To use in dev
(deffunction real_to_system_calendar(?day)
    (bind ?r (+ 1 (mod (- ?day 15) 365)))
    (if (< ?r 0) 
        then (return (+ ?r 365))
        else (return ?r))  
)

(deffunction init_rank_assertions()

(bind ?categorie (deftemplate-slot-allowed-values patologia categoria))
(bind ?strutture (deftemplate-slot-allowed-values sintomo struttura))

   (loop-for-count (?i 1 (- (length$ ?categorie) 1))
       do
       (bind ?categoria (nth$ ?i ?categorie))
       (loop-for-count (?j 1 (- (length$ ?strutture) 1))
           do
           (bind ?struttura (nth$ ?j ?strutture))
           (assert (damaged_structs_rank (categoria ?categoria) (struttura ?struttura) (counter 0)))
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