
;fuzzy-template to define a group of people
(deftemplate group 
    0 25 members
    (
        (few (0 0) (5 1) (10 0))
        (many (5 0) (20 1))

    )
)

;main template
(deftemplate party (slot organizer)
                   (slot expected (type FUZZY-VALUE group)))

;Define some facts
(deffacts parties
    (party (organizer Jhon)
                (expected many)) ;fuzzyfication

    (party (organizer Mary)
                (expected slightly many)) ;fuzzyfication
)

; match parties with MANY people expected and then assert call-help
(defrule check-invited 
    ?f <- (party (organizer ?organizer)
                 (expected many))
    =>
    (assert (call-help ?organizer))
    (printout t "expected to " ?organizer "'s party: " (moment-defuzzify (get-fuzzy-slot ?f expected)) crlf) ;defuzzyfication
)
(reset)
(facts)
(run)
; note how "call-help Mary" have low CF due to "low match" in check-invited LHS rule
; and "call-help Jhon" have a 1.0 CF due to "perfect match" in check-invited LHS rule
(facts) 