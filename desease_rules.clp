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


;update increasing by 1 damaged_structs_rank elements
;most damaged plant parts grouped by category
;TODO add plant structure scoring (fulll, growing, absent,ecc..)
(defrule update_rank
    ?update_rank_fact <- (update_rank ?c ?s ?n)
    ?f1 <- (damaged_structs_rank (categoria ?c)
                                 (struttura ?s)
                                 (counter ?cnt)
                                 (asserted_slots $?as))
    (categoria (nome ?c) (punteggio ?cat_belief))
    =>
    (retract ?update_rank_fact)
    (bind ?freq (+ ?cnt 1))
    (bind ?rank (calculate_rank ?cat_belief 0.6 ?freq 1 1 1))
    (if (not(member ?n ?as)) 
        then (bind ?as (insert$ ?as 1 ?n)))
    (modify ?f1 (counter ?freq)
                (asserted_slots ?as)
                (global_rank ?rank))
)

(defrule check_fine_update
    (phase-rank)
    (not (update_rank))
    =>
    (printout t "Fase update_rank finita" crlf)
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

;; TODO maybe reset also asserted slot to reflect sintomo retraction changes?
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
    (assert (aov (struttura ?s) (sintomo ?smo) (valore ?risp)))
    (retract ?fs)
    (retract ?f)
) 




