(deffunction ask_question (?question $?allowed-values)
   (printout t ?question)
   (bind ?answer (read))
   (if (lexemep ?answer) 
       then (bind ?answer (lowcase ?answer)))
   (while (not (member$ ?answer ?allowed-values)) do
      (printout t ?question)
      (bind ?answer (read))
      (if (lexemep ?answer) 
          then (bind ?answer (lowcase ?answer))))
   ?answer
)

(deffunction binary_question (?question)
   (bind ?response (ask_question ?question yes no y n))
   (if (or (eq ?response yes) (eq ?response y))
        then TRUE 
    else FALSE)
)

(deffunction generic_question (?question)
    (printout t ?question)
    (bind ?answer (read))
    (while (not (and (> ?answer 0)
                (< ?answer 366))) do
        (printout t ?question)
        (bind ?answer (read)))
    ?answer
)

(deffunction generate_question (?struttura ?sintomo)
    (bind ?allowed_values (delete-member$ (deftemplate-slot-allowed-values sintomo ?sintomo) nil))
    (ask_question (format nil "La struttura %s presenta %s? (%s)" ?struttura ?sintomo (implode$ ?allowed_values))
                  ?allowed_values) 

)

(defrule day_question
    =>
    (bind ?string "Inserire giorno: ")
    (bind ?value (generic_question ?string))
    (assert (current_day (real_to_system_calendar ?value)))
)

(defrule estensione_question
    (current_day ?x)
    =>
    ;(bind ?allowed_values (loc amp localizzata ampia l a))
    (bind ?ans (ask_question "L'estensione della malattia è localizzata o estesa a tutta la vigna? (loc | amp)" loc amp localizzata ampia l a))
    (if (or (eq ?ans l) (eq ?ans loc) (eq ?ans localizzata))
        then 
            (assert(estensione localizzata))
        else 
        (if (or (eq ?ans a) (eq ?ans amp) (eq ?ans ampia))
            then 
                (assert(estensione ampia))
        )
    )
)