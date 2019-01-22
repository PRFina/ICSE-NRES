;1) Semantica: in inverno (quindi con temperature basse) gli insetti sono in letargo quindi poco probabili
(defrule ENV::insetti_low
    (season winter)
    (temperature low)
    =>
    (assert (category (name insetti) (membership low)))
    (printout t "Inverno -> Insetti letargo" crlf)
    
    ;testata: si attiva a partire da 320 e influisce fino a 60
    ;solo se estensione localizzata quindi insetti high OK
)


;2) Semantica: i nematodi possono essere vettori di virus
;(defrule nematodi_virus
;    (category (name nematodi)(membership high))
;    ?f <- (category (name virus)(membership low))
;    =>
;    (modify ?f (membership (create-fuzzy-value memb high)))
;    (printout t "Nematodi -> Virus" crlf)
;)

(defrule ENV::batteri_high
    (maintenance si)
    =>
    (assert (category (name batteri)(membership high)))
    (printout t "Potatura -> Tacche -> Batteri" crlf)

    ;testata. non si attiva da 160 a 320, solo se estensione localizzata quindi batteri low
    ;se viene asserita la grandine i batteri salgono automaticamente, altrimenti salgono se 
    ;si risponde si alla domanda sulla potatura
)

;Semantica: la grandine, in qualsiasi stagione, può causare sulle strutture presenti, ferite (tacche) nelle quali trovano
;           terreno fertile i batteri
(defrule ENV::grandine
    (precipitations grandine)
    =>
    (assert (category(name batteri)(membership high)))
    ;(if (and (season summer)
    ;         (temperatura high))
    ;    then (printout t "grandine estiva" crlf))
    (printout t "Grandine -> Tacche -> Batteri" crlf)
)


;7) Semantica: in primavera e con il clima mite iniziano a comparire gli insetti che rimangono
;           favoriti in estate con il clima caldo
(defrule ENV::def_insetti
    (season spring or summer)
    (temperature middle or high)
    =>
    (assert (category (name insetti)(membership high)))
    (printout t "Primavera o Estate + Temperature Medie o Alte -> Insetti" crlf)

    ;testata: si attiva a partire da 60 e influisce fino a 240 (tra spring e summer si abbassa)
    ;solo se estensione estesa quindi insetti low OK
)


;Semantica: temperature alte (>26°) e clima secco, quindi estate, limitano le patologie dei funghi,
;           inoltre favoriscono gli insetti 
(defrule ENV::def_temp_high
    (season very summer)
    ;?f <- (temperature ?x)
    (precipitations no)
    =>
    ;(bind ?value (moment-defuzzify ?f))
    ;(if (>= ?value 26)
    ;    then
            (assert (category(name funghi)(membership low)))
            (printout t "Estate + Temperatura alta -> Clima secco -> no Funghi" crlf)
    ;)
)

(defrule ENV::def_mid_funghi
    (season spring or autumn)
    (temperature very middle)
    (precipitations pioggia)
    (extension estesa)
    =>
    (assert (category (name funghi) (membership high)))
    (printout t "Primavera o Autunno -> Temperatura media -> Pioggia (clima umido) -> Funghi")
)