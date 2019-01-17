





(defmodule MAIN (export ?ALL))
(load "utility_func.clp")

(defmodule DGNSYS 
    (export deftemplate oav))
(load "diagnosis_templates.clp")
(load "diagnosis_rule.clp")

(defmodule ENV 
    (export deftemplate category lifetime grapevine memb))
(load "environment_templates.clp")
(load "environment_rules.clp")

(defmodule PROC 
    (export deftemplate symptom damaged_struct QandA desease)
    (import ENV deftemplate category lifetime grapevine memb))
(load "desease_templates.clp")
(load "desease_rules.clp")

(defmodule QGEN 
    (import PROC deftemplate symptom damaged_struct QandA)
    (import DGNSYS deftemplate oav)
    (import MAIN ?ALL))
(load "question_rules_functions.clp")

(defmodule LEARN 
    (import DGNSYS deftemplate oav)
    (import PROC deftemplate desease)
    (import MAIN ?ALL))

(load "learning_func.clp")

(load "test_deffacts.clp")








(reset)
(init_rank)

(select_option_system)
