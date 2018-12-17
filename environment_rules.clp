;; Season Rules
(defrule define_season 
    (current_day ?day)
    =>
    (assert (season (pi 5 ?day)))
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
                       (radice yes)
                       (ceppo yes)
                       (tralcio yes)
                       (foglia absent)
                       (infiorescenza absent)
                       (grappolo absent)))
)

(defrule fase_fenologica_riposo_vegetativa
    (season spring)
    (temperature low)
    =>
    (assert (grapevine (fase riposo_vegetativa)
                       (radice yes)
                       (ceppo yes)
                       (tralcio yes)
                       (foglia growing)
                       (infiorescenza growing)
                       (grappolo absent)))
)

(defrule fase_fenologica_vegetativa
    (season spring)
    (temperature middle)
    =>
    (assert (grapevine (fase vegetativa)
                       (radice yes)
                       (ceppo yes)
                       (tralcio yes)
                       (foglia full)
                       (infiorescenza full)
                       (grappolo growing)))
)

(defrule fase_fenologica_vegetativa_riproduttiva
    (season spring)
    (temperature middle)
    =>
    (assert (grapevine (fase vegetativa_riproduttiva)
                       (radice yes)
                       (ceppo yes)
                       (tralcio yes)
                       (foglia full)
                       (infiorescenza decline)
                       (grappolo growing)))
)

(defrule fase_fenologica_riproduttiva
    (season summer)
    (temperature high)
    =>
    (assert (grapevine (fase riproduttiva)
                       (radice yes)
                       (ceppo yes)
                       (tralcio yes)
                       (foglia full)
                       (infiorescenza absent)
                       (grappolo full)))
)

(defrule fase_fenologica_riproduttiva_riposo
    (season autumn)
    (temperature middle)
    =>
    (assert (grapevine (fase riproduttiva_riposo)
                       (radice yes)
                       (ceppo yes)
                       (tralcio yes)
                       (foglia decline)
                       (infiorescenza absent)
                       (grappolo decline)))
)

;; Regole cateogorie malattie
;; @TODO chiedere a michele
(defrule estensione_localizzata 
    (estensione localizzata)
    => 
    (assert (patologia (categoria insetti)) CF 0.7)
    (assert (patologia (categoria funghi)) CF 0.7)
    (assert (patologia (categoria virus)) CF 0.3)
    (assert (patologia (categoria batteri)) CF 0.3)
    (assert (patologia (categoria nematodi)) CF 0.3)
    (assert (patologia (categoria fitoplasmi)) CF 0.3)
)

(defrule estensione_ampia
    (estensione ampia)
    => 
    (assert (categoria insetti) CF 0.3)
    (assert (categoria funghi) CF 0.3)
    (assert (categoria virus) CF 0.7)
    (assert (categoria batteri) CF 0.7)
    (assert (categoria nematodi) CF 0.7)
    (assert (categoria fitoplasmi) CF 0.7)
)

(defrule categoria_funghi
    (season summer or spring)
    (temperature middle or high)
    (humidity high)
    ?f <- (patologia (categoria funghi))
    =>
    (bind ?CF (get-cf ?f))
    (printout t "CF old: " ?CF " CF new: " (+ ?CF 0.15))
    (modify ?f (categoria virus))   
)



;; Debug rules
(defrule plot_season
    ?f <- (season ?x)
    =>
    (plot-fuzzy-value t "*+-,^" 1 365
        (create-fuzzy-value season winter)
        (create-fuzzy-value season spring)
        (create-fuzzy-value season summer)
        (create-fuzzy-value season autumn)
        ?f   
    )
)

(defrule plot_temperature
    ?f <- (temperature ?x)
    =>
    (plot-fuzzy-value t ".+-^" -15 40
        (create-fuzzy-value temperature low)
        (create-fuzzy-value temperature middle)
        (create-fuzzy-value temperature high)
        ?f   
    )
)

