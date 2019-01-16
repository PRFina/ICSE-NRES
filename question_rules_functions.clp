
(deffunction ask_question (?question $?allowed-values)
   (printout t ?question crlf)
   (bind ?answer (read))
   (if (lexemep ?answer) 
       then (bind ?answer (lowcase ?answer)))
   (while (not (member$ ?answer ?allowed-values)) do
      (printout t ?question)
      (bind ?answer (read))
      (if (lexemep ?answer) 
          then (bind ?answer (lowcase ?answer)))
   )
   (if (eq ?answer altro) 
        then (printout t "quale?")
             (bind ?answer (read)))
    (if (lexemep ?answer) 
        then (bind ?answer (lowcase ?answer))) 
   ?answer
)

(deffunction binary_question (?question)
   (bind ?response (ask_question ?question yes no y n))
   (if (or (eq ?response yes) (eq ?response y))
        then TRUE 
    else FALSE)
)

(deffunction get_allowed_values (?struttura ?sintomo)
    (bind ?allowed_values (create$))

    (do-for-all-facts ((?s symptom))
                      (and (eq ?s:structure ?struttura)
                           (eq ?s:name ?sintomo)
                           (not (member$ ?s:value ?allowed_values)))                     
                      (bind ?allowed_values (insert$ ?allowed_values 1 ?s:value)) 
    )
    (insert$ ?allowed_values (+ 1 (length$ ?allowed_values)) altro)
)

(deffunction build_question (?struttura ?sintomo)
    (bind ?allowed_values (get_allowed_values ?struttura ?sintomo))
    (bind ?answer (ask_question (format nil "La struttura %s presenta %s? (%s)" ?struttura ?sintomo (implode$ ?allowed_values))
                  ?allowed_values))
    ?answer
)

(defrule generate_question
    (phase-question) ;; activation flag
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

(deffunction range_two_val(?first ?second)
    (bind $?value (create$))
    (if (< ?first ?second)
    then
        (loop-for-count (?i ?first ?second) do
            (bind $?value (insert$ ?value 1 ?i))
        )
    )
$?value
)
 
(defrule day_question
    (phase-environment)
    =>
    (bind $?range_day (range_two_val 1 365))
    (bind ?value (ask_question "Inserire giorno: (1 - 365)" $?range_day))
    (assert (current_day (real_to_system_calendar ?value)))
)

(defrule estensione_question
    (current_day ?x)
    =>
    (bind ?ans (ask_question "L'estensione della malattia è localizzata o estesa a tutta la vigna? (localizzata | estesa)" localizzata estesa))
    (assert (estensione ?ans))
)

;Domanda che potrebbe triggerare le euristiche: grandine, tre_dieci, due_quindici, def_temp_mid_funghi
(defrule precipitazioni_question
    (estensione ?x)
    =>
    (bind ?ans (ask_question "Nell'ultimo periodo, si sono verificate (con modesta frequenza) precipitazioni di tipo? (pioggia | grandine | no)" pioggia grandine no))
    (assert (precipitazioni ?ans))
)

;Domanda facoltativa che potrebbe triggerare l'euristica: potatura_primaverile
(defrule potatura_primaverile_question
    (precipitazioni ?x)
    (temperature middle and not low)
    (season spring and not winter)
    (or (grapevine (structure infiorescenza)(value decline))
        (grapevine (structure infiorescenza)(value growing)))
    ;(grapevine (structure foglia)(value absent))
    ;(grapevine (structure grappolo)(value absent))
    =>
    (bind ?ans (ask_question "E' stata effettuata la potatura stagionale? (si | no)" si no))
    (assert (potatura_primaverile ?ans))
)

;Domanda facoltativa che potrebbe triggerare l'euristica: potatura_invernale
(defrule potatura_invernale
    (precipitazioni ?x)
    (season winter and not spring)
    (temperature low and not middle)
    =>
    (bind ?ans (ask_question "E' stata effettuata la potatura stagionale? (si | no)" si no))
    (assert (potatura_invernale ?ans))
)