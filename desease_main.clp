(defmodule ENV 
    (export deftemplate grapevine lifetime category memb))


;(defmodule CALC (export ?ALL))
;(defmodule MAIN (import CALC ?ALL))
(load "diagnosis_templates.clp")
(load "desease_templates.clp")
(load "environment_templates.clp")
(load "utility_func.clp")

(load "test_deffacts.clp")
(load "learning_func.clp")
(load "engineering_rules.clp")
(load "desease_rules.clp")
(load "question_rules_functions.clp")
(load "environment_rules.clp")
(load "metarules.clp")



(reset)
(init_rank)

(select_option_system)
