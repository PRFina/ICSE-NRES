;; FUZZY VARIABLES

(deftemplate season
    1 365 day 
    (
        (spring (PI 55 90))
        (summer (PI 55 180))
        (autumn (PI 55 270))
        (winter (1 1) (55 0) (305 0) (365 1));;TODO smoothing singleton values    )
    )
)

;(deftemplate temperature
;    -15 40 celsius 
;    (
;        (frost (z -15 5))
;        (cold (PI 5 5))
;        (mild (PI 5 15))
;        (warm  (PI 5 30))
;        (hot  (s 25 40))
;    )
;)

; Typical range of a continental/temperate climates
(deftemplate temperature
    -15 40 celsius 
    (
        (low (z -15 8))
        (middle (pi 10 15))
        (high (s 20 40))
        
    )
)
; Relative humidity
(deftemplate humidity
    1 100 percent 
    (
        (low (z 0 30))
        (middle (pi 30 50))
        (high (s 80 100))
        
    )
)

;express how much a given plant structure is visibile
(deftemplate lifetime
    1 100 percent 
    (
        (absent (0 1)(0 0))
        (growing (0 0) (25 1) (25 0))
        (full (25 0) (25 1) (75 1) (75 0))
        (decline (75 1) (100 0))
    )
)
