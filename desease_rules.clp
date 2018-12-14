;get the fact-address of damaged_struct_rank  with category categoria in the pos rank position
(deffunction get_rank_pos(?categoria ?pos)
    (bind ?facts_to_be_sorted
        (find-all-facts ((?f damaged_structs_rank)) 
            (and (neq ?f:counter 0)
                 (eq (fact-slot-value ?f categoria) ?categoria)
            )
        )
    )
    (bind ?sorted_facts (sort sorting ?facts_to_be_sorted))
    (return (nth$ ?pos ?sorted_facts))
)

;funzione di ordinamento decrescente
(deffunction sorting(?a ?b)
    (return (< (fact-slot-value ?a counter)(fact-slot-value ?b counter)))
)


;check all struttura and categoria elements that matchs
(defrule check_update_rank
    (sintomo (struttura ?s)(nome ?x))
    (patologia (nome ?x)(categoria ?c))
    =>
    (assert (update_rank ?c ?s))
)

;update increasing by 1 damaged_structs_rank elements
;most damaged plant parts grouped by category
(defrule update_rank
    ?update_rank_fact <- (update_rank ?c ?s)
    ?f1 <- (damaged_structs_rank (categoria ?c)(struttura ?s)(counter ?cnt))
    =>
    (retract ?update_rank_fact)
    (bind ?count (+ ?cnt 1))
    (modify ?f1 (counter ?count))
)