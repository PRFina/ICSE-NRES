(load "diagnosis_templates.clp")
(load "diagnosis_rule.clp")


(assert (oav(struttura foglia)(sintomo colore)(valore rosso)))
(assert (oav(struttura foglia)(sintomo macchia)(valore si)))
(assert (oav(struttura grappolo)(sintomo colore)(valore rosso)))
(assert (oav(struttura ceppo)(sintomo macchia)(valore si)))

; (create_patologia_deffacts oidio funghi)
; (create_patologia_rule oidio)