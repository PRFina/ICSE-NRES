
(load "desease_templates.clp")
;(load "desease_rules.clp")
(load "environment_templates.clp")
(load "environment_rules.clp")
(load "utility_func.clp")
(load "question_rules_functions.clp")
(load "test_euristiche.clp")

;(set-alpha-value 0.1)
(assert (phase-environment))

(run)