
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



;check all struttura and category elements that matchs
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

(deffunction PROC::calculate_rank (?category_belief ?structure_lifetime ?symptoms_freq ?w1 ?w2 ?w3)
    (bind ?op1 (** ?category_belief ?w1))
    (bind ?op2 (** ?structure_lifetime ?w2))
    (bind ?op3 (** (log10 (+ ?symptoms_freq 1)) ?w3))

    (return (* ?op1 ?op2 ?op3))
)

(deffunction PROC::get_structure_lifetime (?structure ?lifetime)
    (bind ?lifetime (moment-defuzzify ?lifetime))
    ;if structure is (tralcio,radice or ceppo) decrement by 0.66 the contribution
    ;since these structure are always present
    (if (member$ ?structure (create$ tralcio radice ceppo)) 
        then (bind ?lifetime (* ?lifetime 0.66)))
    
    (return ?lifetime)
)


;update increasing by 1 damaged_struct elements
;most damaged plant parts grouped by category
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
    (bind ?rank (calculate_rank (moment-defuzzify ?cat_belief) (get_structure_lifetime ?s ?lifetime) ?freq 1 1 1))
    (if (not(member ?n ?as)) 
        then (bind ?as (insert$ ?as 1 ?n)))
    (modify ?f1 (symptoms_freq ?freq)
                (symptoms ?as)
                (rank ?rank))
)



(defrule PROC::clean_rank_global
    (system_status (phase PROC-clean)
                   (mode diagnosys))
    ?f <- (damaged_struct (rank ?gr&:(eq ?gr 0)))   
    =>
    (retract ?f)
)

(defrule CLEAN::reset_rank
    (system_status (phase CLEAN)
                   (mode diagnosys))
    ?f <- (damaged_struct (symptoms_freq ?c&:(neq ?c 0))
                          (rank ?gr&:(neq ?gr 0)))
    =>
    (modify ?f (symptoms_freq 0) (rank 0) (symptoms))
)


(defrule PROC::from_rank_to_clean
    ?fp <- (system_status (phase PROC)
                          (mode diagnosys))
    (not (update_rank))
    =>
    (modify ?fp (phase PROC-clean))

)






