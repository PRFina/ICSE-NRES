
;get the fact-address of damaged_struct  with category category in the pos rank position
(deffunction QGEN::get_rank_pos(?pos)
    (bind ?facts_to_be_sorted
        (find-all-facts ((?f damaged_struct))
            (neq ?f:symptoms_freq 0)
        )
    )
    (bind ?sorted_facts (sort sorting ?facts_to_be_sorted))
    (return (nth$ ?pos ?sorted_facts))
)

;funzione di ordinamento decrescente
(deffunction QGEN::sorting(?a ?b)
    (return (< (fact-slot-value ?a rank)(fact-slot-value ?b rank)))
)



(deffunction QGEN::get_allowed_values (?struttura ?sintomo)
    (bind ?allowed_values (create$))

    (do-for-all-facts ((?s symptom))
                      (and (eq ?s:structure ?struttura)
                           (eq ?s:name ?sintomo)
                           (not (member$ ?s:value ?allowed_values)))                     
                      (bind ?allowed_values (insert$ ?allowed_values 1 ?s:value)) 
    )
    (insert$ ?allowed_values (+ 1 (length$ ?allowed_values)) altro)
)

(deffunction QGEN::build_question (?struttura ?sintomo)
    (bind ?allowed_values (get_allowed_values ?struttura ?sintomo))
    (bind ?answer (ask_question (format nil "La struttura %s presenta %s? (%s)" ?struttura ?sintomo (implode$ ?allowed_values))
                  ?allowed_values))
    ?answer
)

(defrule QGEN::generate_question
    (system_status (phase QGEN)
                   (mode diagnosys))
    ?f <-(damaged_struct (structure ?s)
                         (symptoms $? ?as $?))    
    (test (eq ?f (get_rank_pos 1))) ; match only on fact with highest rank position
    =>   
    (bind ?answer (build_question ?s ?as))
    (assert (oav (object ?s) (attribute ?as) (value ?answer)))
    (assert (QandA (structure ?s)
                   (symptom ?as)
                   (answer ?answer)))
)

; Retract symptoms related with question
(defrule QGEN::clean_symptoms_by_evidence
    (system_status (phase QGEN)
                   (mode diagnosys))
    ?f  <- (QandA (structure ?s)
                  (symptom ?smo)
                  (answer ?risp))
    ?fs  <- (symptom (structure ?s)
                     (name ?smo))
    =>
    (retract ?fs)
)

(deffunction why_explanation(?r)
    (open "test#spiegazione.txt" mydata "r")
    (bind ?x (readline mydata))
    (printout t "-----------------------------------------------------------------" crlf)
    (while (neq ?x EOF)
        (if (eq ?x "")
            then
            (bind ?x (readline mydata))
            else
                (bind ?rfile (sub-string 0 (- (str-index "@" ?x) 1) ?x))
                (if (eq (str-cat ?r) ?rfile) then
                    (bind ?spiegazione (sym-cat (sub-string (+ (str-index "@" ?x) 2) (str-length ?x) ?x)))
                    ;(retract ?f)
                    (printout t ?spiegazione crlf)
                )
        )
        (bind ?x (readline mydata))
    )
    (printout t "-----------------------------------------------------------------" crlf)
    (close)
)


;(defrule how_environment
;    (how-explanation)
;    ?s <- (season ?x)
;    ;?t <- (temperature ?y)
;    ;?g <- (grapevine (phenological_phase ?ph) (structure ?st) (value ?v))
;    =>
;    (bind ?season (moment-defuzzify ?s))
;    (switch ?season 
;        (case (and (< ?season 150)
;                   (> ?season 50))
;            then (printout t "spring" crlf)
;        )           
;    )
;)


;Domanda che potrebbe triggerare le euristiche: grandine, tre_dieci, due_quindici, def_temp_mid_funghi
(defrule precipitazioni_question
    (estensione ?x)
    =>
    (bind ?x x)
    (while (eq ?x x)
        (bind ?ans (ask_question "Nell'ultimo periodo, si sono verificate precipitazioni di tipo? (pioggia | grandine | no) | perchè [x]" pioggia grandine no x))
        (if (eq ?ans x)
            then (why_explanation 3)
            else
                (assert (precipitazioni ?ans))
                (bind ?x a)
        )
    )
)

;Domanda facoltativa che potrebbe triggerare l'euristica: potatura_primaverile
;(defrule potatura_primaverile_question
;    (precipitazioni ?x)
;    (temperature middle and not low)
;    (season spring and not winter)
;    (or (grapevine (structure infiorescenza)(value decline))
;        (grapevine (structure infiorescenza)(value growing)))
;    ;(grapevine (structure foglia)(value absent))
;    ;(grapevine (structure grappolo)(value absent))
;    =>
;    (bind ?ans (ask_question "E' stata effettuata la potatura stagionale? (si | no)" si no))
;    (assert (potatura_primaverile ?ans))
;)

;Domanda facoltativa che potrebbe triggerare l'euristica: potatura_invernale
;(defrule potatura_invernale
;    (precipitazioni ?x)
;    (season winter and not spring)
;    (temperature low and not middle)
;    =>
;    (bind ?ans (ask_question "E' stata effettuata la potatura stagionale? (si | no)" si no))
;    (assert (potatura_invernale ?ans))
;)

(defrule potatura_question
    (estensione localizzata)
    (or (precipitazioni no)
        (precipitazioni pioggia))
    (season winter or spring)
    =>
    (bind ?x x)
    (while (eq ?x x)
        (bind ?ans (ask_question "E' stata effettuata la potatura stagionale? (si | no) | perchè [x]" si no x))
        (if (eq ?ans x)
            then (why_explanation 4)
            else
            (assert (potatura ?ans))
            (bind ?x a)
        )
    )
)

;(defrule spiegazione
;    ?f <- (why-explanation ?r)
;    =>
;    (open "test#spiegazione.txt" mydata "r")
;    (bind ?x (readline mydata))
;    (while (neq ?x EOF)
;        (if (eq ?x "")
;            then
;            (bind ?x (readline mydata))
;            else
;                (bind ?rfile (sub-string 0 (- (str-index "@" ?x) 1) ?x))
;                (if (eq (str-cat ?r) ?rfile) then
;                    (bind ?spiegazione (sym-cat (sub-string (+ (str-index "@" ?x) 2) (str-length ?x) ?x)))
;                    (retract ?f)        
;                    (printout t "Testo spiegazione: " ?spiegazione crlf)
;                )
;        )
;        (bind ?x (readline mydata))
;    )
;    (close)
;)



;per leggere il numero riga
;(sub-string 0 (- (str-index ")" ?x) 1) ?x)

;per asserire tutto meno il numero riga
;r(sub-string (+ (str-index ")" ?x) 2) (str-length ?x) ?x)