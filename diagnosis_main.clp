(load "diagnosis_templates.clp")
(load "diagnosis_rule.clp")


(assert (aov(struttura foglia)(sintomo colore)(valore rosso)))
(assert (aov(struttura foglia)(sintomo macchia)(valore si)))
(assert (aov(struttura grappolo)(sintomo colore)(valore rosso)))
(assert (aov(struttura ceppo)(sintomo macchia)(valore si)))