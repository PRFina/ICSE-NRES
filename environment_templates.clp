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

; Typical range of a continental/temperate climates
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

;express how much a given plant structure is visibile
;(deftemplate lifetime
;    0 100 percent 
;    (
;        (absent (0 1)(0 0))
;        (growing (0 0) (25 1) (25 0))
;        (full (25 0) (25 1) (75 1) (75 0))
;        (decline (75 0) (75 1) (100 0))
;    )
;)


(deftemplate grapevine
    (slot fase)
    (slot radice )
    (slot ceppo )
    (slot tralcio )
    (slot foglia) ;(type FUZZY-VALUE lifetime))
    (slot infiorescenza) ;(type FUZZY-VALUE lifetime))
    (slot grappolo) ;(type FUZZY-VALUE lifetime))
)


