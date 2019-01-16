;get the fact-address of damaged_struct_rank  with category categoria in the pos rank position
(deffunction get_rank_pos(?pos)
    (bind ?facts_to_be_sorted
        (find-all-facts ((?f damaged_structs_rank))
            (neq ?f:counter 0)
        )
    )
    (bind ?sorted_facts (sort sorting ?facts_to_be_sorted))
    (return (nth$ ?pos ?sorted_facts))
)

;funzione di ordinamento decrescente
(deffunction sorting(?a ?b)
    (return (< (fact-slot-value ?a global_rank)(fact-slot-value ?b global_rank)))
)

;check all struttura and categoria elements that matchs
(defrule check_update_rank
    (phase-rank)
    ?f <- (symptom (desease ?d)
                   (structure ?s)
                   (name ?n))
          
          (desease (name ?d)
                   (category ?c))
    =>
    (assert (update_rank ?c ?s ?n))
)

(deffunction calculate_rank (?category_belief ?structure_lifetime ?symptoms_freq ?w1 ?w2 ?w3)
    (bind ?op1 (** ?category_belief ?w1))
    (bind ?op2 (** ?structure_lifetime ?w2))
    (bind ?op3 (** (log10 (+ ?symptoms_freq 1)) ?w3))

    (return (* ?op1 ?op2 ?op3))
)

(deffunction get_structure_lifetime (?structure ?lifetime)
    (bind ?lifetime (moment-defuzzify ?lifetime))
    ;if structure is (tralcio,radice or ceppo) decrement by 0.66 the contribution
    ;since these structure are always present
    (if (member$ ?structure (create$ tralcio radice ceppo)) 
        then (bind ?lifetime (* ?lifetime 0.66)))
    
    (return ?lifetime)
)


;update increasing by 1 damaged_structs_rank elements
;most damaged plant parts grouped by category
(defrule update_rank
    ?update_rank_fact <- (update_rank ?c ?s ?n)
    ?f1 <- (damaged_structs_rank (categoria ?c)
                                 (struttura ?s)
                                 (counter ?cnt)
                                 (asserted_slots $?as))
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
    (modify ?f1 (counter ?freq)
                (asserted_slots ?as)
                (global_rank ?rank))
)



;;TODO maybe is useless?? (is counter != 0 when glob =0?)
(defrule clean_rank_counter
    (phase-clean)
    ?f <- (damaged_structs_rank (counter ?c&:(eq ?c 0)))   
    =>
    (retract ?f)
)

(defrule clean_rank_global
    (phase-clean)
    ?f <- (damaged_structs_rank (global_rank ?gr&:(eq ?gr 0)))   
    =>
    (retract ?f)
)

(defrule reset_rank
    (phase-reset)
    ?f <- (damaged_structs_rank (counter ?c&:(neq ?c 0))
                                (global_rank ?gr&:(neq ?gr 0)))
    =>
    (modify ?f (counter 0) (global_rank 0) (asserted_slots))
)


; Retract symptoms related with with question
(defrule clean_sintomi_by_evidence
    ?ph <- (phase-question)
    ?f  <- (QandA (struttura ?s)
                 (sintomo ?smo)
                 (risposta ?risp))
    ?fs  <- (symptom (structure ?s)
                     (name ?smo))

    =>
    (retract ?fs)
    (retract ?f)
) 




