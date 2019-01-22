; FUZZY VARIABLES
; Models fuzzy-variable season in envitonment rules
(deftemplate ENV::season
    1 365 day 
    (
        (spring (PI 55 90))
        (summer (PI 55 180))
        (autumn (PI 55 270))
        (winter (1 1) (55 0) (305 0) (365 1))
    )
)

; Typical range of Italy's climates
(deftemplate ENV::temperature
    -5 38 celsius 
    (
        (low (z -5 10))
        (middle (pi 10 17))
        (high (s 23 38))
        
    )
)

; Express how much a given plant structure is visibile
(deftemplate ENV::lifetime
    0 1 point 
    (
        (absent (z 0 0.28))
        (decline (pi 0.14 0.38))
        (growing (pi 0.14 0.62))
        (full (s 0.72 1))
    )
)

; Models fuzzy-variable in category
(deftemplate ENV::memb
   0 100
    (
        (low (z 0 0.52))
        (high (s 0.48 1))
    )
)

; Models categories and their related "belief" value
(deftemplate ENV::category
       (slot name)
       (slot membership (type FUZZY-VALUE memb))
)

; Models fase fenologica with fuzzy values
(deftemplate ENV::phenological
    0 120 point
    (   
        (riposo (0 1) (10 1) (30 0)) 
        (riposo_vegetativa (10 0) (30 1) (50 0))
        (vegetativa (30 0) (50 1) (70 0))
        (vegetativa_riproduttiva (50 0) (70 1) (90 0)) 
        (riproduttiva (70 0) (90 1) (110 0))
        (riproduttiva_riposo (90 0) (110 1) (120 1))
    )
)

; Models plant structure, its phenological phase and the lifetime for every part
(deftemplate ENV::grapevine 
    (slot phenological_phase (type FUZZY-VALUE phenological))
    (slot structure (allowed-values radice ceppo tralcio foglia infiorescenza grappolo))
    (slot value (type FUZZY-VALUE lifetime))
)