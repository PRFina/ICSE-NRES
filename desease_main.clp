(defmodule CALC (export ?ALL))
(defmodule MAIN (import CALC ?ALL))

(load "desease_templates.clp")

(load "desease_facts.clp")

(load "utility_func.clp")
;(load "question_rules_functions.clp")
(load "desease_rules.clp")


(reset)
(init_rank_assertions)

(assert (categoria (nome funghi) (punteggio 0.7))
        (categoria (nome fitoplasmi) (punteggio 0.5))
        (categoria (nome batteri) (punteggio 0.4))
        (categoria (nome virus) (punteggio 0.3))
        (categoria (nome insetti) (punteggio 0.2))
        (categoria (nome nematodi) (punteggio 0.1)))

