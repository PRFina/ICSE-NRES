;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                              ;;;       
;;;           main file to call in batch mode to load the system components      ;;;
;;;                                                                              ;;;  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmodule MAIN (export ?ALL))
(load* "utility_func.clp")

(defmodule SYS (export ?ALL))
(load* "system.clp")

(defmodule DGNSYS 
    (import SYS ?ALL)
    (export deftemplate oav))
(load* "diagnosis_templates.clp")
(load* "diagnosis_rule.clp")

(defmodule ENV 
    (export deftemplate category lifetime grapevine memb)
    (import MAIN ?ALL)
    (import SYS ?ALL))
(load* "environment_templates.clp")
(load* "environment_rules.clp")
(load* "heuristic_rules.clp")

(defmodule CLEAN
    (import SYS ?ALL)
)

(defmodule PROC 
    (export deftemplate symptom damaged_struct QandA desease)
    (export deffunction init_rank)
    (import SYS ?ALL)
    (import MAIN ?ALL)
    (import ENV deftemplate category lifetime grapevine memb))
(load* "desease_templates.clp")
(load* "desease_rules.clp")

(defmodule QGEN 
    (import PROC deftemplate symptom damaged_struct QandA)
    (import DGNSYS deftemplate oav)
    (import SYS ?ALL)
    (import MAIN ?ALL))
(load* "question_rules_functions.clp")

(defmodule LEARN 
    (import DGNSYS deftemplate oav)
    (import PROC deftemplate desease)
    (import SYS ?ALL)
    (import MAIN ?ALL))
(load* "learning_rules_functions.clp")
(load* "learned_rules.clp")
(load* "learned_deffacts.clp")
(load* "desease_facts.clp")

(run)
