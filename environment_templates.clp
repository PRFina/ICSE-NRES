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
; Relative humidity
(deftemplate humidity
    0 100 percent 
    (
        (low (z 0 30))
        (middle (pi 30 50))
        (high (s 80 100))
    )
)

; Express how much a given plant structure is visibile

;(deftemplate lifetime
;    0 105 point 
;    (
;        (absent (pi 15 15)) ;weight: 0
;        (growing (pi 15 40)) ;weight: 0,8
;        (full (pi 15 65)) ;weight: 0,6
;        (decline (pi 15 90)) ;weight: 0,3
;    )
;)

(deftemplate lifetime
    0 1 point 
    (
        (absent (pi 0.14 0.14)) ;weight: 0
        (decline (pi 0.14 0.38)) ;weight: 0,8
        (growing (pi 0.14 0.62)) ;weight: 0,3
        (full (pi 0.14 0.86)) ;weight: 0,6
    )
)

(deftemplate memb
   0 100
    (
        (low (z 0 30))
        (middle (pi 20 50))
        (high (s 70 100))
    )
)

(deftemplate category
       (slot name)
       (slot membership (type FUZZY-VALUE memb))
)

; Models fase fenologica with fuzzy values / used for debug
(deftemplate fase
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

; Grapevine structure with fuzzy values
(deftemplate grapevine
    (slot fase (type FUZZY-VALUE fase)) ;/ used for debug
    (slot radice (type FUZZY-VALUE lifetime))
    (slot ceppo (type FUZZY-VALUE lifetime))
    (slot tralcio (type FUZZY-VALUE lifetime))
    (slot foglia (type FUZZY-VALUE lifetime))
    (slot infiorescenza (type FUZZY-VALUE lifetime))
    (slot grappolo (type FUZZY-VALUE lifetime))
)