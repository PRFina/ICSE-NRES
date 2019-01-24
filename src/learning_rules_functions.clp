;; Create a string with a symptom which contains the name of the desease, the damaged struct, the name of the symptom, and its value. Used for deffacts
(deffunction LEARN::create_string_deffacts(?patologia ?struttura ?sintomo ?valore)
    (bind ?sintomi "")
    (bind ?sintomi (str-cat ?sintomi (format nil "(symptom (desease %s)%n(structure %s)%n(name %s)%n(value %s))%n" ?patologia ?struttura ?sintomo ?valore)))
    (return ?sintomi)
)

;; Create a unique deffacts string that corresponds to a desease
(deffunction LEARN::create_patologia_deffacts(?nome ?categoria)
    (open "learned_deffacts.clp" data "a")
    (bind ?patologia "")
    (bind ?patologia (format nil "(deffacts PROC::%s %n%n(desease (name %s) %n(category %s))%n%n" ?nome ?nome ?categoria))
    (do-for-all-facts ((?x oav))
                      (neq ?x:value no)
                      (bind ?patologia (str-cat ?patologia (create_string_deffacts ?nome ?x:object ?x:attribute ?x:value) (format nil "%n")))
    )
    (printout data (str-cat ?patologia ")") crlf crlf)
    (close)
)

;; Create a string with a symptom which contains the damaged struct, the name of the symptom, and its value. Used for rule
(deffunction LEARN::create_string_rule(?struttura ?sintomo ?valore)
    (bind ?string "")
    (bind ?string (str-cat ?string (format nil "(oav(object %s)%n(attribute %s)%n(value %s))%n" ?struttura ?sintomo ?valore)))
    (return ?string)
)

;; Create a unique defrule string that corresponds to a desease
(deffunction LEARN::create_patologia_rule(?nome)
    (open "learned_rules.clp" data "a")
    (bind ?patologia "")
    (bind ?patologia (format nil "(defrule DGNSYS::%s %n%n" ?nome))
    (bind ?patologia (str-cat ?patologia (format nil "?f <- (system_status (mode diagnosys))%n")))
    (do-for-all-facts ((?x oav))
                      (neq ?x:value no)
                      (bind ?patologia (str-cat ?patologia (create_string_rule ?x:object ?x:attribute ?x:value) (format nil "%n") ) )
                      
    )
    (printout data (str-cat ?patologia "=>" (format nil "%n")) )
    (printout data "(diagnosys_completed \"")
    (printout data ?nome)
    (printout data "\" ")
    (printout data "?f)" crlf ")" crlf crlf)
    (close)
)

;; Rule to to get a name and a category from user input from engineering mode
(defrule LEARN::expert_question
    (system_status (phase LEARN)
                   (mode engineering))
    =>
    (printout t "Inserire il nome della malattia: ")
    (bind ?desease (str_replace (readline) " " "_"))
    (bind ?category (ask_question "Inserire la categoria a cui appartiene: (funghi | nematodi | batteri | fitoplasmi | virus | insetti)" funghi nematodi batteri fitoplasmi virus insetti))
    (assert (desease (name ?desease) (category ?category)))
    (assert (phases symptom_question))
)

;; Rule to to get a name and a category from user input from diagnosys mode and check for more
(defrule LEARN::learn_question
    ?fs <- (system_status (phase LEARN)
                          (mode diagnosys))
    =>
    (printout t "Inserire il nome della malattia: ")
    (bind ?desease (str_replace (readline) " " "_"))
    (bind ?category (ask_question "Inserire la categoria a cui appartiene: (funghi | nematodi | batteri | fitoplasmi | virus | insetti)" funghi nematodi batteri fitoplasmi virus insetti))
    (assert (desease (name ?desease) (category ?category)))
    (bind ?ans (binary_question "La malattia ha altri sintomi? (yes y | no n)"))
    (switch ?ans 
        (case (or y yes) then 
            (assert (phases symptom_question))
        )
        (default
            (create_patologia_deffacts ?desease ?category)
            (create_patologia_rule ?desease)
            (printout t "***************************************** Patologia acquisita! *****************************************" crlf)
            (modify ?fs (phase START) (sequence))
            (focus SYS)
        )
    )
)

;; Rule to get the values for a desease in object-attribute-value form
(defrule LEARN::symptom_quest
    ?fs <-  (system_status (phase LEARN)
                           (mode engineering|diagnosys))
    ?f <- (phases symptom_question)
    ?f1 <- (desease (name ?desease) (category ?category))
    =>
    (retract ?f )
    (bind ?object (ask_question "Inserisci la struttura colpita dal sintomo: (radice | ceppo | tralcio | foglia | infiorescenza | grappolo)" radice ceppo tralcio foglia infiorescenza grappolo))
    (printout t "Inserisci il nome del sintomo: (es. colore, macchiacolore, macchiaforma, melatafumag,fattoredsm, disseccamento, deformazione, ecc...)" crlf)
    (bind ?attribute (read))
    (printout t "Inserisci il valore del sintomo: (giallo, rosso, regolare, irregolare, si, no, ecc...)" crlf)
    (bind ?value (read))
    (assert (oav(object ?object)     
                (attribute ?attribute)  
                (value ?value)
            )
    )
    (printout t crlf crlf) 
    (bind ?ans (binary_question "La patologia presenta altri sintomi? (yes y | no n)"))
    (switch ?ans 
        (case (or y yes) then 
            (assert (phases symptom_question))
        )
        (default
            (printout t "***************************************** Patologia acquisita! *****************************************" crlf)
            (create_patologia_deffacts ?desease ?category)
            (create_patologia_rule ?desease)
            (modify ?fs (phase START) (sequence))
            (focus SYS)
        )
    )
)

;; Print every assertions after getting a diagnosys 
(defrule print_oav
    ?f <- (system_status (phase LEARN)
                         (mode diagnosys))
    ?f1 <- (oav (object ?o)
                (attribute ?a)
                (value ?v))      
    =>
    (printout t "Sulla struttura " ?o " è presente " ?a " " ?v crlf)
)