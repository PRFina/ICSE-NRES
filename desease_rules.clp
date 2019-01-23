

;; check if there are no more symptoms in the wm,
;; if so ask to the user if he wants 
;; to proceed to the learning phase
;; otherwise restart the system.
(defrule PROC::no_more_symptoms
    ?f <- (system_status (phase ?x) ;TODO maybe replace ?x with PROC and remove focus SYS
                         (mode diagnosys))
    (not (symptom))
    =>
    (bind ?ans (binary_question "Non abbiamo trovato nessuna patologia per le informazioni acquisite, vuoi memorizzarle per una futura diagnosi? (yes y|no n)"))
    (if (eq ?ans TRUE) then 
        (modify ?f (phase LEARN) (sequence LEARN)) ; change phase
    else 
        (modify ?f (phase START) (sequence))
    )
    (focus SYS)
)

;; implements the rank equation formula (see @documentazione.pdf for additional details)
(deffunction PROC::calculate_rank (?category_belief ?structure_lifetime ?symptoms_freq ?w1 ?w2 ?w3)
    (bind ?op1 (** ?category_belief ?w1))
    (bind ?op2 (** ?structure_lifetime ?w2))
    (bind ?op3 (** (log10 (+ ?symptoms_freq 1)) ?w3))

    (return (* ?op1 ?op2 ?op3))
)

;; get the the defuzzyfied ?lifetime value of the ?structure
(deffunction PROC::get_structure_lifetime (?structure ?lifetime)
    (bind ?lifetime (moment-defuzzify ?lifetime))
    ;if structure is (tralcio,radice or ceppo) decrement by 0.66 the contribution
    ;since these structure are always present
    (if (member$ ?structure (create$ tralcio radice ceppo)) 
        then (bind ?lifetime (* ?lifetime 0.66)))
    
    (return ?lifetime)
)

;; 1st part of the rank update process. This rule triggers the update
;; update_rank rule asserting a update_rank ordered "control fact" 
;; This rule is needed to avoid infinite loop due to the same 
;; LHS pattern matched and modified in the RHS.
(defrule PROC::check_update_rank
    (system_status (phase PROC)
                   (mode diagnosys))
    ?f <- (symptom (desease ?d)
                   (structure ?s)
                   (name ?n))
          
    (desease (name ?d)
             (category ?c))
    =>
    (assert (update_rank ?c ?s ?n))
)


;; 2nd part of the rank update process. This rule modify the
;; damaged_struct fact to reflect changes to the working memory
;; due to the RAD cycle.
(defrule PROC::update_rank
    ?update_rank_fact <- (update_rank ?c ?s ?n)
    ?f1 <- (damaged_struct (category ?c)
                           (structure ?s)
                           (symptoms_freq ?cnt)
                           (symptoms $?as))
    (category (name ?c) 
              (membership ?cat_belief))

    (grapevine (structure ?s)
               (value ?lifetime))
    =>
    (retract ?update_rank_fact)
    (bind ?freq (+ ?cnt 1))
    (bind ?rank (calculate_rank (moment-defuzzify ?cat_belief) (get_structure_lifetime ?s ?lifetime) ?freq 0.8 1 1))
    (if (not(member ?n ?as)) ; check if symptom is already added to the simptoms list
        then (bind ?as (insert$ ?as 1 ?n)))
    (modify ?f1 (symptoms_freq ?freq)
                (symptoms ?as)
                (rank ?rank))
)


;; remove damaged_struct facts that have a ranking value of 0
;; since they will not be used in next RAD iterations 
;; and represent working memory's garbage
(defrule PROC::clean_rank_global
    (system_status (phase PROC-clean)
                   (mode diagnosys))
    ?f <- (damaged_struct (rank ?gr&:(eq ?gr 0)))   
    =>
    (retract ?f)
)
;; reset damaged_struct facts, symptoms multifield 
;; is emptied and ranking value and symptoms_fre slots
;; are setted to 0 value
(defrule CLEAN::reset_rank
    (system_status (phase CLEAN)
                   (mode diagnosys))
    ?f <- (damaged_struct (symptoms_freq ?c&:(neq ?c 0))
                          (rank ?gr&:(neq ?gr 0)))
    =>
    (modify ?f (symptoms_freq 0) (rank 0) (symptoms))
)

;; check if rank update phase is complete, then assert
;; "control fact" to proceed to clean the rank
(defrule PROC::from_rank_to_clean
    ?fp <- (system_status (phase PROC)
                          (mode diagnosys))
    (not (update_rank))
    =>
    (modify ?fp (phase PROC-clean))

)






