
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
           (assert (damaged_structs_rank (categoria ?categoria)
                                         (struttura ?struttura)
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

; Function to return a multifield filled with asserted slots (not nil) from deftemplate sintomo facts
(deffunction get_asserted_slot_names_from_sintomo (?fact ?old_asserted_slots)  
    (bind ?slot_names (fact-slot-names ?fact)) ;get sintomo slots from a fact
    (bind ?attributes (subseq$ ?slot_names 2 (- (length ?slot_names) 1))) ; filter slot_names removing struttura and nome slots
   
    ;;(bind ?asserted_attributes (create$))
    ;create a multifield adding the slot name only if its value is different from nil
    (progn$ (?field ?attributes)  
            (if
                (and (neq (fact-slot-value ?fact ?field) nil)
                     (not (and (deftemplate-slot-multip sintomo ?field) ; check if ?field is a multislot and it's empty
                               (eq (nth$ 1 (fact-slot-value ?fact ?field)) nil))
                     )
                     (not (member$ ?field ?old_asserted_slots))
                )
            then 
                (bind ?old_asserted_slots (insert$ ?old_asserted_slots 1 ?field))
            )
    )
    (return ?old_asserted_slots)
)


(deffunction set_update_false()
    (do-for-all-facts ((?f sintomo))
                      (eq ?f:update_flag TRUE)
                      (modify ?f (update_flag FALSE)))
)

(deffunction set_update_true()
    (do-for-all-facts ((?f sintomo))
                      (eq ?f:update_flag FALSE)
                      (modify ?f (update_flag TRUE)))
)
