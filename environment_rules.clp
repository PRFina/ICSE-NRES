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

