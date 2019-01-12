;Semantica: in inverno (quindi con temperature basse) gli insetti sono in letargo quindi poco probabili
(defrule def_temp_low
    (season winter)
    (temperature low)
    =>
    (assert (category(name insetti)(membership low)))
    (printout t "Inverno -> Insetti letargo" crlf)
)


;Semantica: temperature medie (10-26°), quindi primavera e autunno,
;           insieme alle pioggie e al clima umido (precipitazioni piovose e ristagno acqua)
;           favoriscono la formazione di funghi
(defrule def_temp_mid_funghi
    (or (season spring)
        (season autumn))
    ?f <- (temperature ?x)
    (precipitazioni pioggia)
    =>
    (bind ?value (moment-defuzzify ?f))
    (if (and (>= ?value 10)
             (<= ?value 26))
        then
            (assert (category (name funghi)(membership high)))
            (printout t "Primavera/Autunno + Temperature medie + Pioggia -> Clima umido -> Funghi" crlf)
    )
)


;Semantica: in primavera e con il clima mite iniziano a comparire gli insetti
(defrule def_temp_mid_insetti
    (season spring)
    (temperature middle)
    =>
    (assert (category (name insetti)(membership middle)))
    (printout t "Primavera + Temperature medie -> inizio Insetti" crlf)
)


;Semantica: temperature alte (>26°) e clima secco, quindi estate, limitano le patologie dei funghi,
;           inoltre favoriscono gli insetti 
(defrule def_temp_high
    (season summer)
    ?f <- (temperature ?x)
    =>
    (bind ?value (moment-defuzzify ?f))
    (if (>= ?value 26)
        then
            (assert (category(name insetti)(membership high)))
            (printout t "Estate -> Insetti" crlf)
            (assert (category(name funghi)(membership low)))
            (printout t "Estate + Temperatura alta -> Clima secco -> no Funghi" crlf)
    )
)


;La regola dei "tre dieci" è generalmente legata alla peronospora ma presenta condizioni favorevoli allo sviluppo di FUNGHI (aggiungere?)
(defrule tre_dieci
    ;Semantica: germogli di circa 10cm
    (grapevine (foglia growing))
    (grapevine (infiorescenza growing))
    
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


;Semantica: la potatura invernale può causare sulle strutture presenti (tralcio e ceppo) ferite (tacche) nelle quali
;           trovano terreno fertile i batteri
(defrule potatura_inverno
    (season winter)
    (potatura si)
    =>
    (assert (category(name batteri)(membership middle)))
    ;(assert (sintomo (struttura tralcio) 
    ;                 (tacche si)))
    ;(assert (sintomo (struttura ceppo) 
    ;                 (tacche si)))
    (printout t "Potatura invernale -> Tacche -> Batteri" crlf)
)


;Semantica: la potatura primaverile (effettuata prima dello sviluppo di foglia e frutto) può causare sulle 
;           strutture presenti (tralcio, ceppo e infiorescenza - ma non foglia e grappolo) ferite (tacche) nelle quali
;           trovano terreno fertile i batteri
(defrule potatura_primavera
    (season spring)
    (potatura si)
    (or (grapevine (infiorescenza growing))
        (grapevine (infiorescenza full)))
    (grapevine (foglia absent))
    (grapevine (grappolo absent))
    =>
    (assert (category(name batteri)(membership middle)))
    ;(assert (sintomo (struttura tralcio) 
    ;                 (tacche si)))
    ;(assert (sintomo (struttura ceppo) 
    ;                 (tacche si)))
    ;(assert (sintomo (struttura infiorescenza) 
    ;                 (tacche si)))
    (printout t "Potatura primaverile -> Tacche -> Batteri" crlf)
)


;Semantica: la grandine, in qualsiasi stagione, può causare sulle strutture presenti, ferite (tacche) nelle quali trovano
;           terreno fertile i batteri
(defrule grandine
    (precipitazioni grandine)
    =>
    (assert (category(name batteri)(membership middle)))
    ;(if (and (season summer)
    ;         (temperatura high))
    ;    then (printout t "grandine estiva" crlf))
    (printout t "Grandine -> Tacche -> Batteri" crlf)
)


;Semantica: i nematodi possono essere vettori di virus
(defrule nematodi_virus
    (category (name nematodi)(membership high))
    =>
    (assert (category (name virus)(membership middle)))
    (printout t "Nematodi -> Virus" crlf)
)