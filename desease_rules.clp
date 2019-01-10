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
    ?f <- (sintomo (struttura ?s)(nome ?x)(update_flag TRUE))
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


(defrule check_fine_update
    (not (update_rank))
    =>
    (printout t "Fase update_rank finita" crlf)
    (facts)
    (set_update_false)
)




