;Create
(deffunction LEARN::create_string_deffacts(?patologia ?struttura ?sintomo ?valore)
    (bind ?sintomi "")
    (bind ?sintomi (str-cat ?sintomi (format nil "(symptom (desease %s)%n(structure %s)%n(name %s)%n(value %s))%n" ?patologia ?struttura ?sintomo ?valore)))
    (return ?sintomi)
)

(deffunction LEARN::create_patologia_deffacts(?nome ?categoria)
    (open "learned-deffacts.txt" data "a")
    (bind ?patologia "")
    (bind ?patologia (format nil "(deffacts PROC::%s %n%n(desease (name %s) %n(category %s))%n%n" ?nome ?nome ?categoria))
    (do-for-all-facts ((?x oav))
                      (eq 1 1)
                      (bind ?patologia (str-cat ?patologia (create_string_deffacts ?nome ?x:object ?x:attribute ?x:value) (format nil "%n")))
    )
    (printout data (str-cat ?patologia ")") crlf)
    (close)
)

(deffunction LEARN::create_string_rule(?struttura ?sintomo ?valore)
    (bind ?string "")
    (bind ?string (str-cat ?string (format nil "(oav(object %s)%n(attribute %s)%n(value %s))%n" ?struttura ?sintomo ?valore)))
    (return ?string)
)

(deffunction LEARN::create_patologia_rule(?nome)
    (open "learned-rule.txt" data "a")
    (bind ?patologia "")
    (bind ?patologia (format nil "(defrule DGNSYS::%s %n%n" ?nome))
    (bind ?patologia (str-cat ?patologia (format nil "?f <- (system_status (mode diagnosys))%n")))
    (do-for-all-facts ((?x oav))
                      (eq 1 1)
                      (bind ?patologia (str-cat ?patologia (create_string_rule ?x:object ?x:attribute ?x:value) (format nil "%n") ) )
                      
    )
    (printout data (str-cat ?patologia "=>" (format nil "%n")) )
    (printout data "(diagnosys_completed \"")
    (printout data ?nome)
    (printout data "\" ")
    (printout data "?f)" crlf ")")
    (close)
)

(defrule LEARN::expert_quest
    ;?f <- (mode_engineering)
    ?f <- (system_status(phase LEARN)
                        (mode engineering))
    =>
    (retract ?f)
    (printout t "Inserire il nome della malattia: ")
    (bind ?desease (read))
    (bind ?category (ask_question "Inserire la categoria a cui appartiene: (funghi | nematodi | batteri | fitoplasmidellavite | virus | insetti)" funghi nematodi batteri fitoplasmidellavite virus insetti))
    (assert (desease (name ?desease) (category ?category)))
    (assert (phases symptom_question))
)

(defrule LEARN::symptom_quest
    ?f <- (phases symptom_question)
    ?f1 <- (desease (name ?desease) (category ?category))
    =>
    (retract ?f)
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
    (bind ?ans (binary_question "La malattia ha altri sintomi? (yes y | no n)"))
    (switch ?ans 
        (case (or y yes) then 
            (assert (phases symptom_question))
            (run)
        )
        (default
            (create_patologia_deffacts ?desease ?category)
            (create_patologia_rule ?desease)
            (focus SYS)
        )
    )
)
(defrule welcome
   ?f <- (system_status (phase LEARN))
                         
    =>
    (printout t crlf crlf "***************** WELCOME TO LEARNING MODE *************"crlf crlf)
    (modify ?f (phase START) (sequence))
    


)