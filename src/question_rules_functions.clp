
;; get the fact-address of the damaged_struct fact in the ?pos ranking position
(deffunction QGEN::get_rank_pos(?pos)
    (bind ?facts_to_be_sorted
        (find-all-facts ((?f damaged_struct))
            (neq ?f:symptoms_freq 0)
        )
    )
    (bind ?sorted_facts (sort sorting ?facts_to_be_sorted))
    (return (nth$ ?pos ?sorted_facts))
)

;; sort by rank value in ascending order the damaged_struct facts
(deffunction QGEN::sorting(?a ?b)
    (return (< (fact-slot-value ?a rank)(fact-slot-value ?b rank)))
)


;; return a multifield where each value is
;; the name of an sserted symptom fact
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

;; create the user question based on grammar presented in @documentazione.pdf
;; return the user answer
(deffunction QGEN::build_question (?struttura ?sintomo)
    (bind ?allowed_values (get_allowed_values ?struttura ?sintomo))
    (bind ?answer (ask_question (format nil "La struttura %s presenta %s? (%s)" ?struttura ?sintomo (implode$ ?allowed_values))
                  ?allowed_values))
    ?answer
)

;; generate a question for each value of symptoms of the highest ranking 
;; damaged_struct fact
(defrule QGEN::generate_question
    (system_status (phase QGEN)
                   (mode diagnosys))
    ?f <-(damaged_struct (structure ?s)
                         (symptoms $? ?as $?))    
    (test (eq ?f (get_rank_pos 1))) ; match only on fact with highest ranking position
    =>   
    (bind ?answer (build_question ?s ?as))
    (assert (oav (object ?s) (attribute ?as) (value ?answer)))
    (assert (QandA (structure ?s)
                   (symptom ?as)
                   (answer ?answer)))
)

;; Retract symptoms related with question 
;; (see Delete section of @documentazione.pdf for additional info)
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