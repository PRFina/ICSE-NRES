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
;; @TODO modificare valori e testare

(defrule fase_fenologica_riposo
    (season winter)
    (temperature low)
    =>
    (assert (grapevine (fase riposo)
                       (radice full)
                       (ceppo full)
                       (tralcio full)
                       (foglia absent)
                       (infiorescenza absent)
                       (grappolo absent)))
)

(defrule fase_fenologica_riposo_vegetativa
    (season winter)
    (temperature middle)
    =>
    (assert (grapevine (fase riposo_vegetativa)
                       (radice full)
                       (ceppo full)
                       (tralcio full)
                       (foglia growing)
                       (infiorescenza growing)
                       (grappolo absent)))
)

(defrule fase_fenologica_vegetativa
    (season somewhat spring and not winter)
    (temperature somewhat middle and not low)
    =>
    (assert (grapevine (fase vegetativa)
                       (radice full)
                       (ceppo full)
                       (tralcio full)
                       (foglia full)
                       (infiorescenza full)
                       (grappolo growing)))
)

(defrule fase_fenologica_vegetativa_riproduttiva
    (season somewhat spring and not summer)
    (temperature somewhat middle and not high)
    =>
    (assert (grapevine (fase vegetativa_riproduttiva)
                       (radice full)
                       (ceppo full)
                       (tralcio full)
                       (foglia full)
                       (infiorescenza decline)
                       (grappolo growing)))
)

(defrule fase_fenologica_riproduttiva
    (season somewhat summer and not spring)
    (temperature somewhat high and not middle)
    =>
    (assert (grapevine (fase riproduttiva)
                       (radice full)
                       (ceppo full)
                       (tralcio full)
                       (foglia full)
                       (infiorescenza absent)
                       (grappolo full)))
)

(defrule fase_fenologica_riproduttiva_riposo
    (season very autumn)
    (temperature very middle)
    =>
    (assert (grapevine (fase riproduttiva_riposo)
                       (radice full)
                       (ceppo full)
                       (tralcio full)
                       (foglia decline)
                       (infiorescenza absent)
                       (grappolo decline)))
)

;; Regole cateogorie malattie
;; @TODO chiedere a michele
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,
;(defrule def_temp_low
;  (temperature low)
;  =>
;  (assert (category(name insetti)(membership low)))
;  (assert (category(name funghi)(membership low)))
;  (assert (category(name virus)(membership low)))
;  (assert (category(name batteri)(membership low)))
;  (assert (category(name nematodi)(membership low)))
;  (assert (category(name fitoplasmi)(membership low)))
;)
;
;(defrule def_temp_mid
;  (temperature middle)
;  =>
;  (assert (category(name insetti)(membership high)))
;  (assert (category(name funghi)(membership high)))
;  (assert (category(name virus)(membership high)))
;  (assert (category(name batteri)(membership high)))
;  (assert (category(name nematodi)(membership high)))
;  (assert (category(name fitoplasmi)(membership high)))
;)
;
;(defrule def_temp_high
;  (temperature high)
;  =>
;  (assert (category(name insetti)(membership high)))
;  (assert (category(name funghi)(membership low)))
;  (assert (category(name virus)(membership middle)))
;  (assert (category(name batteri)(membership middle)))
;  (assert (category(name nematodi)(membership middle)))
;  (assert (category(name fitoplasmi)(membership middle)))
;)


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
    ?f <- (grapevine (fase ?fase)
                     (radice ?radice)
                     (ceppo ?ceppo)
                     (tralcio ?tralcio)
                     (foglia ?foglia)
                     (infiorescenza ?infiorescenza)
                     (grappolo ?grappolo))
    =>
    (printout t "Defuzzified fase: " (moment-defuzzify (get-fuzzy-slot ?f fase)) crlf)
    (printout t "Defuzzified radice: " (moment-defuzzify (get-fuzzy-slot ?f radice)) crlf)
    (printout t "Defuzzified ceppo: " (moment-defuzzify (get-fuzzy-slot ?f ceppo)) crlf)
    (printout t "Defuzzified tralcio: " (moment-defuzzify (get-fuzzy-slot ?f tralcio)) crlf)
    (printout t "Defuzzified foglia: " (moment-defuzzify (get-fuzzy-slot ?f foglia)) crlf)
    (printout t "Defuzzified infiorescenza: " (moment-defuzzify (get-fuzzy-slot ?f infiorescenza)) crlf)
    (printout t "Defuzzified grappolo: " (moment-defuzzify (get-fuzzy-slot ?f grappolo)) crlf)
)

;Debug fasi fenologiche

(defrule riposo
    (grapevine (fase riposo))
    =>
    (printout t "riposo" crlf)
)
(defrule riposo-vegetativa
    (grapevine (fase riposo_vegetativa))
    =>
    (printout t "riposo_vegetariva" crlf)
)
(defrule vegetativa
    (grapevine (fase vegetativa))
    =>
    (printout t "vegetativa" crlf)
)
(defrule vegetativa-riproduttiva
    (grapevine (fase vegetativa_riproduttiva))
    =>
    (printout t "vegetativa_riproduttiva" crlf)
)
(defrule riproduttiva
    (grapevine (fase riproduttiva))
    =>
    (printout t "riproduttiva" crlf)
)
(defrule riproduttiva-riposo
    (grapevine (fase riproduttiva_riposo))
    =>
    (printout t "riproduttiva_riposo" crlf)
)
