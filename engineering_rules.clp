(defrule LEARN::expert_quest
    ?f <- (mode_engineering)
    =>
    (retract ?f)
    (printout t "Inserire il nome della malattia: ")
    (bind ?desease (read))
    (bind ?category (ask_question "Inserire la categoria a cui appartiene: (funghi | nematodi | batteri | fitoplasmidellavite | virus | insetti)" funghi nematodi batteri fitoplasmidellavite virus insetti))
    ;(printout t "Inserire la categoria a cui appartiene: ")
    ;(bind ?category (read))

    (assert (desease (name ?desease) (category ?category)))
    (assert (phases symptom_question))
)

(defrule LEARN::check_symptom_quest
    ?f <- (phases symptom_question)
    =>
    (assert (desease (name ?desease) (category ?category)))
)

(defrule LEARN::symptom_quest
    ?f <- (phases symptom_question)
    ?f1 <- (desease (name ?desease) (category ?category))
    =>
    (retract ?f)
    ;(printout t "Inserisci la struttura colpita dal sintomo: (radice | ceppo | tralcio | foglia | infiorescenza | grappolo)" crlf)
    ;(bind ?object (read))
    (bind ?object (ask_question "Inserisci la struttura colpita dal sintomo: (radice | ceppo | tralcio | foglia | infiorescenza | grappolo)" radice ceppo tralcio foglia infiorescenza grappolo))
    (printout t "Inserisci il nome del sintomo: (colore | macchiacolore | macchiaforma | melatafumag | fattoredsm | disseccamento | deformazione...)" crlf)
    (bind ?attribute (read))
    (printout t "Inserisci il valore del sintomo: (giallo | macchiacolore | macchiaforma | melatafumag | fattoredsm | si | no...)" crlf)
    (bind ?value (read))
    (assert (oav(object ?object)     
                (attribute ?attribute)  
                (value ?value)
            )
    )
    (printout t crlf crlf) 
    (printout t "La malattia ha altri sintomi? (si | no)")
    (bind ?ans (read))
    (switch ?ans 
        (case si then 
            (assert (phases symptom_question))
            (run)
        )
        (default
            (create_patologia_deffacts ?desease ?category)
            (create_patologia_rule ?desease)
            (select_option_system)
        )
    )
)
