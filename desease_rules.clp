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
    ?f <- (sintomo (struttura ?s)(nome ?x))
    (patologia (nome ?x)(categoria ?c))
    =>
    (assert (update_rank ?c ?s ?f))
)


;update increasing by 1 damaged_structs_rank elements
;most damaged plant parts grouped by category
(defrule update_rank
    ?update_rank_fact <- (update_rank ?c ?s ?f)
    ?f1 <- (damaged_structs_rank (categoria ?c)(struttura ?s)(counter ?cnt)(asserted_slots $?as)(global_rank ?gr))
    (categoria (nome ?c) (punteggio ?val))
    =>
    (retract ?update_rank_fact)
    (bind ?count (+ ?cnt 1))
    (bind ?glob (* ?val ?count))
    (modify ?f1 (counter ?count)
                (asserted_slots (get_asserted_slot_names_from_sintomo ?f ?as))
                (global_rank ?glob))
)

;;TODO maybe is useless?? (is counter != 0 when glob =0?)
(defrule clean_rank_counter
    (phase-delete)
    ?f <- (damaged_structs_rank (counter ?c&:(eq ?c 0)))   
    =>
    (retract ?f)
)

(defrule clean_rank_global
    (phase-delete)
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


(defrule check_fine_update
    (not (update_rank))
    =>
    (printout t "Fase update_rank finita" crlf)
)
; Retract symptoms that doesn't matchwith user anser
(defrule clean_sintomi
    ?f <- (QandA (struttura ?s)
                 (sintomo ?smo)
                 (risposta ?risp))
    =>
    (retract ?f)
    (do-for-all-facts ((?fs sintomo))
                      (and (eq ?fs:struttura ?s)
                           (neq (fact-slot-value ?fs ?smo) ?risp)
                           (neq (fact-slot-value ?fs ?smo) nil)
                      )  
                      (retract ?fs)
    )
)         

(deffunction calculate_rank (?category_belief ?structure_lifetime ?symptoms_freq ?w1 ?w2 ?w3)
    (bind ?op1 (** ?category_belief ?w1))
    (bind ?op2 (** ?structure_lifetime ?w2))
    (bind ?op3 (** (log10 (+ ?symptoms_freq 1)) ?w3))

    (return (* ?op1 ?op2 ?op3))
)




