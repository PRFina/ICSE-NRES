;; Season Rules
(defrule ENV::define_season
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
(defrule ENV::define_temperature_low
    (season winter)
    =>
    (assert (temperature low))
)

(defrule ENV::define_temperature_middle
    (season spring or autumn)
    =>
    (assert (temperature middle))
)

(defrule ENV::define_temperature_high
    (season summer)
    =>
    (assert (temperature high))
)

;; Regole fase fenologica
(defrule ENV::fase_fenologica_riposo
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

(defrule ENV::fase_fenologica_riposo_vegetativa
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

(defrule ENV::fase_fenologica_vegetativa
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

(defrule ENV::fase_fenologica_vegetativa_riproduttiva
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

(defrule ENV::fase_fenologica_riproduttiva
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

(defrule ENV::fase_fenologica_riproduttiva_riposo
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
(defrule ENV::estensione_localizzata
   (estensione localizzata)
   =>
   (assert (category(name insetti)(membership high)))
   (assert (category(name funghi)(membership high)))
   (assert (category(name virus)(membership low)))
   (assert (category(name batteri)(membership low)))
   (assert (category(name nematodi)(membership low)))
   (assert (category(name fitoplasmi)(membership low)))
)

(defrule ENV::estensione_estesa
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
(defrule ENV::plot_season
    (system_status (phase ENV)
                   (mode debug))
    ?f <- (season ?x)
    =>
    (plot-fuzzy-value t "*+-,^" 1 365
        (create-fuzzy-value season winter)
        (create-fuzzy-value season spring)
        (create-fuzzy-value season summer)
        (create-fuzzy-value season autumn)
        ?f   
    )
    (printout t "Defuzzified Season: " (moment-defuzzify ?f) crlf)
)

(defrule ENV::plot_temperature
    (system_status (phase ENV)
                   (mode debug))
    ?f <- (temperature ?x)
    =>
    (plot-fuzzy-value t ".+-^" -15 40
        (create-fuzzy-value temperature low)
        (create-fuzzy-value temperature middle)
        (create-fuzzy-value temperature high)
        ?f   
    )
    (printout t "Defuzzified Temperature: " (moment-defuzzify ?f) crlf)
)

(defrule ENV::plot_membership
    (system_status (phase ENV)
                   (mode debug))
    ?f <- (category (name ?x) (membership ?y))
    =>
    (printout t "Defuzzified Membership: "?x crlf (moment-defuzzify (get-fuzzy-slot ?f membership)) crlf)
)

(defrule ENV::debug_fase_struttura
    (system_status (phase ENV)
                   (mode debug))
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


(defrule ENV::day_question
    (system_status (phase ENV)
                   (mode diagnosys))
    =>
    (bind $?range_day (range_two_val 1  365))
    (bind ?value (ask_question "Inserire giorno: (1 - 365)" $?range_day))
    (assert (current_day (real_to_system_calendar ?value)))
)

(defrule ENV::estensione_question
    (current_day ?x)
    =>
    (bind ?ans (ask_question "L'estensione della malattia è localizzata o estesa a tutta la vigna? (localizzata | estesa)" localizzata estesa))
    (assert (estensione ?ans))
)