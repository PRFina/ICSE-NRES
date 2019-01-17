

;check all struttura and category elements that matchs
(defrule PROC::check_update_rank
    (phase-rank)
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



;;TODO maybe is useless?? (is counter != 0 when glob =0?)
(defrule PROC::clean_rank_counter
    (phase-clean)
    ?f <- (damaged_struct (symptoms_freq ?c&:(eq ?c 0)))   
    =>
    (retract ?f)
)

(defrule PROC::clean_rank_global
    (phase-clean)
    ?f <- (damaged_struct (rank ?gr&:(eq ?gr 0)))   
    =>
    (retract ?f)
)

(defrule PROC::reset_rank
    (phase-reset)
    ?f <- (damaged_struct (symptoms_freq ?c&:(neq ?c 0))
                          (rank ?gr&:(neq ?gr 0)))
    =>
    (modify ?f (symptoms_freq 0) (rank 0) (symptoms))
)


; Retract symptoms related with with question
(defrule PROC::clean_sintomi_by_evidence
    ?ph <- (phase-question)
    ?f  <- (QandA (structure ?s)
                  (symptom ?smo)
                  (answer ?risp))
    ?fs  <- (symptom (structure ?s)
                     (name ?smo))

    =>
    (retract ?fs)
    (retract ?f)
) 

(defrule PROC::from_rank_to_clean
    ?fp <- (phase-rank)
    (not (update_rank))
    =>
    (retract ?fp)
    (assert (phase-clean))
    (printout t "Fase rank finita, starting cleaning" crlf)
)

(deffunction PROC::init_rank()
    (bind ?categories (deftemplate-slot-allowed-values desease category))
    (bind ?structures (deftemplate-slot-allowed-values symptom structure))

    (loop-for-count (?i 1 (length$ ?categories))
        do
        (bind ?category (nth$ ?i ?categories))
        
        (loop-for-count (?j 1 (length$ ?structures))
            do
            (bind ?structure (nth$ ?j ?structures))
            (assert (damaged_struct (category ?category)
                                    (structure ?structure)
                                    (symptoms_freq 0)
                                    (symptoms (create$))
                                    (rank 0)))
        )
    )
)





