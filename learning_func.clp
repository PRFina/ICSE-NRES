;Create
(deffunction create_string_deffacts(?patologia ?struttura ?sintomo ?valore)
    (bind ?sintomi "")
    (bind ?sintomi (str-cat ?sintomi (format nil "(symptom (desease %s)%n(structure %s)%n(name %s)%n(value %s))%n" ?patologia ?struttura ?sintomo ?valore)))
    (return ?sintomi)
)

(deffunction create_patologia_deffacts(?nome ?categoria)
    (open "learned-deffacts.txt" data "a")
    (bind ?patologia "")
    (bind ?patologia (format nil "(deffacts %s %n%n(desease (name %s) %n(category %s))%n%n" ?nome ?nome ?categoria))
    (do-for-all-facts ((?x oav))
                      (eq 1 1)
                      (bind ?patologia (str-cat ?patologia (create_string_deffacts ?nome ?x:object ?x:attribute ?x:value) (format nil "%n")))
    )
    (printout data (str-cat ?patologia ")") crlf)
    (close)
)

(deffunction create_string_rule(?struttura ?sintomo ?valore)
    (bind ?string "")
    (bind ?string (str-cat ?string (format nil "(oav(structure %s)%n(name %s)%n(value %s))%n" ?struttura ?sintomo ?valore)))
    (return ?string)
)

(deffunction create_patologia_rule(?nome)
    (open "learned-rule.txt" data "a")
    (bind ?patologia "")
    (bind ?patologia (format nil "(defrule %s %n%n" ?nome))
    (do-for-all-facts ((?x oav))
                      (eq 1 1)
                      (bind ?patologia (str-cat ?patologia (create_string_rule ?x:object ?x:attribute ?x:value) (format nil "%n") ) )
                      
    )
    (printout data (str-cat ?patologia "=>" (format nil "%n")) )
    (printout data "(printout t \"La malattia è:  ")
    (printout data ?nome)
    (printout data " \" ")
    (printout data "crlf)" crlf ")" crlf)
    (close)
)