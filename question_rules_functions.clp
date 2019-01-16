
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
    ?f <-(damaged_structs_rank
                               (struttura ?s)
                               (asserted_slots $? ?as $?))    
    (test (eq ?f (get_rank_pos 1))) ; match only on fact with highest rank position
    =>   
    (bind ?answer (build_question ?s ?as))
    (assert (oav (object ?s) (attribute ?as) (value ?answer)))
    (assert (QandA (struttura ?s)
                 (sintomo ?as)
                 (risposta ?answer)))
    (agenda)
    (facts)
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
    (bind $?range_day (range_two_val 1  365))
    (bind ?value (ask_question "Inserire giorno: (1 - 365)" $?range_day))
    (assert (current_day (real_to_system_calendar ?value)))
)

(defrule estensione_question
    (current_day ?x)
    =>
    (bind ?ans (ask_question "L'estensione della malattia è localizzata o estesa a tutta la vigna? (localizzata | estesa)" localizzata estesa))
    (assert (estensione ?ans))
)