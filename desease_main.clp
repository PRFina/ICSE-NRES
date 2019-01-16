;(defmodule CALC (export ?ALL))
;(defmodule MAIN (import CALC ?ALL))
(load "diagnosis_templates.clp")
(load "desease_templates.clp")
(load "environment_templates.clp")

(load "test_deffacts.clp")

(load "utility_func.clp")
(load "desease_rules.clp")
(load "question_rules_functions.clp")
(load "environment_rules.clp")



(reset)
(init_rank)

