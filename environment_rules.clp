;; Season Rules
(defrule define_season
    (current_day ?day)
    =>
    (bind ?range 5)
    (if (and (>= ?day 0)
             (<= ?day ?range))
        then (assert (season (z 1 ?range)))
        else
        (if  (and (>= ?day (- 366 ?range))
                  (<= ?day 365))
            then (assert (season (s (- 365 ?range) 365)))
            else     
                (assert (season (pi ?range ?day)))
        )
    )
)


;; Temperature Rules
(defrule define_temperature_low
    (season winter)
    =>
    (assert (temperature low))
)

(defrule define_temperature_middle
    (season spring or autumn)
    =>
    (assert (temperature middle))
)

(defrule define_temperature_high
    (season summer)
    =>
    (assert (temperature high))
)

;; Regole fase fenologica
(defrule fase_fenologica_riposo
    (season winter)
    (temperature low)
    =>
    (assert (grapevine (phenological_phase riposo)(structure radice)(value full)))
    (assert (grapevine (phenological_phase riposo)(structure ceppo)(value full)))
    (assert (grapevine (phenological_phase riposo)(structure tralcio)(value full)))
    (assert (grapevine (phenological_phase riposo)(structure foglia)(value absent)))
    (assert (grapevine (phenological_phase riposo)(structure infiorescenza)(value absent)))
    (assert (grapevine (phenological_phase riposo)(structure grappolo)(value absent)))
)

(defrule fase_fenologica_riposo_vegetativa
    (season winter)
    (temperature middle)
    =>
    (assert (grapevine (phenological_phase riposo_vegetativa)(structure radice)(value full)))
    (assert (grapevine (phenological_phase riposo_vegetativa)(structure ceppo)(value full)))
    (assert (grapevine (phenological_phase riposo_vegetativa)(structure tralcio)(value full)))
    (assert (grapevine (phenological_phase riposo_vegetativa)(structure foglia)(value growing)))
    (assert (grapevine (phenological_phase riposo_vegetativa)(structure infiorescenza)(value absent)))
    (assert (grapevine (phenological_phase riposo_vegetativa)(structure grappolo)(value absent)))
)

(defrule fase_fenologica_vegetativa
    (season somewhat spring and not winter)
    (temperature somewhat middle and not low)
    =>
    (assert (grapevine (phenological_phase vegetativa)(structure radice)(value full)))
    (assert (grapevine (phenological_phase vegetativa)(structure ceppo)(value full)))
    (assert (grapevine (phenological_phase vegetativa)(structure tralcio)(value full)))
    (assert (grapevine (phenological_phase vegetativa)(structure foglia)(value full)))
    (assert (grapevine (phenological_phase vegetativa)(structure infiorescenza)(value growing)))
    (assert (grapevine (phenological_phase vegetativa)(structure grappolo)(value absent)))
)

(defrule fase_fenologica_vegetativa_riproduttiva
    (season somewhat spring and not summer)
    (temperature somewhat middle and not high)
    =>
    (assert (grapevine (phenological_phase vegetativa_riproduttiva)(structure radice)(value full)))
    (assert (grapevine (phenological_phase vegetativa_riproduttiva)(structure ceppo)(value full)))
    (assert (grapevine (phenological_phase vegetativa_riproduttiva)(structure tralcio)(value full)))
    (assert (grapevine (phenological_phase vegetativa_riproduttiva)(structure foglia)(value full)))
    (assert (grapevine (phenological_phase vegetativa_riproduttiva)(structure infiorescenza)(value decline)))
    (assert (grapevine (phenological_phase vegetativa_riproduttiva)(structure grappolo)(value growing)))
)

(defrule fase_fenologica_riproduttiva
    (season somewhat summer and not spring)
    (temperature somewhat high and not middle)
    =>
    (assert (grapevine (phenological_phase riproduttiva)(structure radice)(value full)))
    (assert (grapevine (phenological_phase riproduttiva)(structure ceppo)(value full)))
    (assert (grapevine (phenological_phase riproduttiva)(structure tralcio)(value full)))
    (assert (grapevine (phenological_phase riproduttiva)(structure foglia)(value full)))
    (assert (grapevine (phenological_phase riproduttiva)(structure infiorescenza)(value absent)))
    (assert (grapevine (phenological_phase riproduttiva)(structure grappolo)(value full)))
)

(defrule fase_fenologica_riproduttiva_riposo
    (season very autumn)
    (temperature very middle)
    =>
    (assert (grapevine (phenological_phase riproduttiva_riposo)(structure radice)(value full)))
    (assert (grapevine (phenological_phase riproduttiva_riposo)(structure ceppo)(value full)))
    (assert (grapevine (phenological_phase riproduttiva_riposo)(structure tralcio)(value full)))
    (assert (grapevine (phenological_phase riproduttiva_riposo)(structure foglia)(value decline)))
    (assert (grapevine (phenological_phase riproduttiva_riposo)(structure infiorescenza)(value absent)))
    (assert (grapevine (phenological_phase riproduttiva_riposo)(structure grappolo)(value decline)))
)

;; Regole cateogorie malattie
(defrule estensione_localizzata
   (estensione localizzata)
   =>
   (assert (category(name insetti)(membership high)))
   (assert (category(name funghi)(membership high)))
   (assert (category(name virus)(membership low)))
   (assert (category(name batteri)(membership low)))
   (assert (category(name nematodi)(membership low)))
   (assert (category(name fitoplasmi)(membership low)))
)

(defrule estensione_estesa
   (estensione estesa)
   =>
   (assert (category(name insetti)(membership low)))
   (assert (category(name funghi)(membership low)))
   (assert (category(name virus)(membership high)))
   (assert (category(name batteri)(membership high)))
   (assert (category(name nematodi)(membership high)))
   (assert (category(name fitoplasmi)(membership high)))
)


;; Debug rules
(defrule plot_season
    ?f <- (season ?x)
    =>
    ;(plot-fuzzy-value t "*+-,^" 1 365
    ;    (create-fuzzy-value season winter)
    ;    (create-fuzzy-value season spring)
    ;    (create-fuzzy-value season summer)
    ;    (create-fuzzy-value season autumn)
    ;    ?f   
    ;)
    (printout t "Defuzzified Season: " (moment-defuzzify ?f) crlf)
)

(defrule plot_temperature
    ?f <- (temperature ?x)
    =>
    ;(plot-fuzzy-value t ".+-^" -15 40
    ;    (create-fuzzy-value temperature low)
    ;    (create-fuzzy-value temperature middle)
    ;    (create-fuzzy-value temperature high)
    ;    ?f   
    ;)
    (printout t "Defuzzified Temperature: " (moment-defuzzify ?f) crlf)
)

(defrule plot_membership
    ?f <- (category (name ?x) (membership ?y))
    =>
    ;(bind ?value (nth$ 2 (deftemplate-slot-allowed-values category (get-fuzzy-slot ?f membership) ) ))
    ;(plot-fuzzy-value t “.+-^” 0 100
    ;    ;(create-fuzzy-value memb ?y)
    ;    (create-fuzzy-value memb low)
    ;    (create-fuzzy-value memb middle)
    ;    (create-fuzzy-value memb high)
    ;    ;?f
    ;)
    (printout t "Defuzzified Membership: "?x crlf (moment-defuzzify (get-fuzzy-slot ?f membership)) crlf)
)

(defrule debug_fase_struttura
    ?f <- (grapevine (phenological_phase ?fase)
                     (structure ?structure)
                     (value ?value))
    =>
    (printout t "-------------------------" crlf)
    (printout t "Defuzzified phenological phase: " (moment-defuzzify (get-fuzzy-slot ?f phenological_phase)) crlf)
    (printout t "Defuzzified structure: " ?structure crlf)
    (printout t "Defuzzified value: " (moment-defuzzify (get-fuzzy-slot ?f value)) crlf)
    (printout t "-------------------------" crlf)
)


;Debug fasi fenologiche
(defrule debug_environment
    (phase-debug)
    =>
    (assert (categoria (nome funghi) (punteggio 0.7))
            (categoria (nome fitoplasmi) (punteggio 0.5))
            (categoria (nome batteri) (punteggio 0.4))
            (categoria (nome virus) (punteggio 0.3))
            (categoria (nome insetti) (punteggio 0.2))
            (categoria (nome nematodi) (punteggio 0.1)))
)