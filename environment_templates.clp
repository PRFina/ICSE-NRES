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

(deftemplate temperature
    -15 40 celsius 
    (
        (low (z -15 8))
        (middle (pi 10 15))
        (high (s 20 40))
        
    )
)