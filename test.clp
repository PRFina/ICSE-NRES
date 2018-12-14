;(plot-fuzzy-value t ".+-*" 1 365
;    (create-fuzzy-value season winter)
;    (create-fuzzy-value season spring)
;    (create-fuzzy-value season summer)
;    (create-fuzzy-value season autumn)
;)

;(plot-fuzzy-value t ".+-*^," -15 40
;    (create-fuzzy-value temperature low)
;    (create-fuzzy-value temperature middle)
;    (create-fuzzy-value temperature high)
;)

(plot-fuzzy-value t "*.+-," 0 100
    (create-fuzzy-value lifetime absent)
    (create-fuzzy-value lifetime growing)
    (create-fuzzy-value lifetime full)
    (create-fuzzy-value lifetime decline)
)
  

(assert (current_day (real_to_system_calendar 78)))
(facts)
(agenda)
(run)
(moment-defuzzify 3)

