(defrule from_rank_to_clean
    ?fp <- (phase-rank)
    (not (update_rank))
    =>
    (retract ?fp)
    (assert (phase-clean))
    (printout t "Fase rank finita, starting cleaning" crlf)
)

