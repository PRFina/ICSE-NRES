;; FUZZY VARIABLES

(deftemplate season
    1 365 day 
    (
        (spring (PI 55 90))
        (summer (PI 55 180))
        (autumn (PI 55 270))
        (winter (1 1) (55 0) (305 0) (365 1)) ;TODO smoothing singleton values
    )
)

; Typical range of Italy's climates
(deftemplate temperature
    -5 38 celsius 
    (
        (low (z -5 10))
        (middle (pi 10 17))
        (high (s 23 38))
        
    )
)


; Express how much a given plant structure is visibile
(deftemplate lifetime
    0 1 point 
    (
        (absent (z 0 0.28)) ;weight: 0
        (decline (pi 0.14 0.38)) ;weight: 0,8
        (growing (pi 0.14 0.62)) ;weight: 0,3
        (full (s 0.72 1)) ;weight: 0,6
    )
)

;
(deftemplate memb
   0 100
    (
        (low (z 0 30))
        (middle (pi 20 50))
        (high (s 70 100))
    )
)

;
(deftemplate category
       (slot name)
       (slot membership (type FUZZY-VALUE memb))
)

; Models fase fenologica with fuzzy values / used for debug
(deftemplate phenological
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

(deftemplate grapevine 
    (slot phenological_phase (type FUZZY-VALUE phenological))
    (slot structure (allowed-values radice ceppo tralcio foglia infiorescenza grappolo))
    (slot value (type FUZZY-VALUE lifetime))
)