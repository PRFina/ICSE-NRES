;Semantica: temperature medie (10-26°), quindi primavera e autunno,
;           insieme alle pioggie e al clima umido (precipitazioni piovose e ristagno acqua)
;           favoriscono la formazione di funghi
(defrule def_temp_mid_funghi
    (or (season spring)
        (season autumn))
    ?f <- (temperature ?x)
    ?f1 <- (category (name insetti) (membership high))
    (precipitazioni pioggia)
    =>
    (bind ?value (moment-defuzzify ?f))
    (if (and (>= ?value 10)
             (<= ?value 26))
        then
            (modify ?f1 (membership (create-fuzzy-value memb high)))
            (printout t "Primavera/Autunno + Temperature medie + Pioggia -> Clima umido -> Funghi" crlf)
    )
)







;La regola dei "tre dieci" è generalmente legata alla peronospora ma presenta condizioni favorevoli allo sviluppo di FUNGHI (aggiungere?)
(defrule tre_dieci
    ;Semantica: germogli di circa 10cm
    (grapevine (structure foglia)(value growing))
    (grapevine (structure infiorescenza)(value growing))
    
    ;Semantica: temperatura di almeno 10° (non superiore a 26°)
    ?f <- (temperature ?x)

    ;Semantica: pioggia caduta 10mm
    (precipitazioni pioggia)  
    =>
    (bind ?value (moment-defuzzify ?f))
    (if (and (>= ?value 10)
             (<= ?value 26))
        then         
            (printout t "Regola dei tre dieci - Peronospora (Funghi)" crlf)
    )
)


;La regola dei "due quindici" è generalmente legata alla Botrite ma presenta condizioni favorevoli allo sviluppo di FUNGHI (aggiungere?)
(defrule due_quindici
    ;Semantica: temperatura di circa 15° (13-17°)
    ?f <- (temperature ?x)

    ;Semantica: pioggia caduta per 15 ore
    (precipitazioni pioggia)
    =>
    (bind ?value (moment-defuzzify ?f))
    (if (and (>= ?value 13)
             (<= ?value 17))
        then
            (printout t "Regola dei due quindici - Botrite (Funghi)" crlf)
    )
)



;FATTE (unite)
;Semantica: la potatura invernale può causare sulle strutture presenti (tralcio e ceppo) ferite (tacche) nelle quali
;           trovano terreno fertile i batteri
;(defrule potatura_inverno
;    (potatura si)
;    =>
;    (assert (category(name batteri)(membership high)))
;    ;(assert (sintomo (struttura tralcio) 
;    ;                 (tacche si)))
;    ;(assert (sintomo (struttura ceppo) 
;    ;                 (tacche si)))
;    (printout t "Potatura invernale -> Tacche -> Batteri" crlf)
;)
;

;Semantica: la potatura primaverile (effettuata prima dello sviluppo di foglia e frutto) può causare sulle 
;           strutture presenti (tralcio, ceppo e infiorescenza - ma non foglia e grappolo) ferite (tacche) nelle quali
;           trovano terreno fertile i batteri
;(defrule potatura_primavera
;    (potatura si)
;    =>
;    (assert (category(name batteri)(membership middle)))
;    ;(assert (sintomo (struttura tralcio) 
;    ;                 (tacche si)))
;    ;(assert (sintomo (struttura ceppo) 
;    ;                 (tacche si)))
;    ;(assert (sintomo (struttura infiorescenza) 
;    ;                 (tacche si)))
;    (printout t "Potatura primaverile -> Tacche -> Batteri" crlf)
;)


