;regole che si attivano in caso di malattie diagnosticate

;;;;;;;;;;;;;;
;;; FUNGHI ;;;
;;;;;;;;;;;;;;

(defrule peronospora  
    (oav(object foglia)
        (attribute macchiaforma)
        (value regolare))
    (oav(object foglia)
        (attribute macchiacolore)
        (value giallo))
    (oav(object foglia)
        (attribute muffa)
        (value bianca))
    (oav(object foglia)    
        (attribute disseccamento)
        (value si))
    
    (oav(object infiorescenza)
        (attribute colore)
        (value bruno))
    (oav(object infiorescenza)
        (attribute deformazione)
        (value si))

    (oav(object grappolo)
        (attribute deformazione)
        (value si))
    (oav(object grappolo)
        (attribute disseccamento)
        (value si))
    =>
    (printout t "La malattia è: Peronospora" crlf)
)


(defrule oidio
;OR 
    (oav(object foglia)
        (attribute macchiacolore)
        (value giallo|scuro))
    ;(oav(object foglia)
    ;    (attribute macchiacolore)
    ;    (value scuro))
;end OR
    (oav(object foglia)
        (attribute deformazione)
        (value si))
    
    (oav(object infiorescenza)
        (attribute colore)
        (value bianco))
    (oav(object infiorescenza)
        (attribute deformazione)
        (value si))

    (oav(object grappolo)
        (attribute caduta)
        (value si))
    (oav(object grappolo)
        (attribute muffa)
        (value bianca))

    (oav(object tralcio)
        (attribute muffa)
        (value bianca))
    (oav(object tralcio)
        (attribute deformazione)
        (value si))
    =>
    (printout t "La malattia è: Oidio" crlf)
)


(defrule botrite
    (oav(object foglia)
        (attribute macchiacolore)
        (value giallo))

    (oav(object grappolo)
        (attribute caduta)
        (value si))
    (oav(object grappolo)
        (attribute muffa)
        (value grigia))

    (oav(object tralcio)
        (attribute disseccamento)
        (value si))
    (oav(object tralcio)
        (attribute colore)
        (value bruno))
	=>
    (printout t "La malattia è: Botrite" crlf)
)


(defrule marciumeradicale    
    (oav(object foglia)
        (attribute disseccamento)
        (value si))

    (oav(object ceppo)
        (attribute macchiacolore)
        (value bianco))

    (oav(object radice)
        (attribute macchiacolore)
        (value bianco))
    =>
    (printout t "La malattia è: Marciume Radicale" crlf)
)


(defrule verticilliosi
    (oav(object foglia)
        (attribute disseccamento)
        (value si))

    (oav(object ceppo)
        (attribute tacche)
        (value si))
    =>
    (printout t "La malattia è: Verticilliosi" crlf)
)


(defrule maldellesca
    (oav(object foglia)
        (attribute macchiacolore)
        (value giallo))
    (oav(object foglia)
        (attribute nervature)
        (value verde))
    (oav(object foglia)
        (attribute disseccamento)
        (value si))

    (oav(object grappolo)
        (attribute macchiacolore)
        (value bruno))
    (oav(object grappolo)
        (attribute macchiaforma)
        (value puntiforme))
;OR
    (oav(object ceppo)
        (attribute macchiacolore)
        (value bianco|giallo))
    ;(oav(object ceppo)
    ;    (attribute macchiacolore)
    ;    (value giallo))
;end OR
    (oav(object ceppo)	    
        (attribute marciume)
        (value spugnoso))
    (oav(object ceppo)
        (attribute deformazione)
        (value si))
    =>
    (printout t "La malattia è: Mal dell' esca" crlf)
)


(defrule marciumebianco
;OR
    (oav(object grappolo)
        (attribute macchiacolore)
        (value giallo|bianco|bruno))
    ;(oav(object grappolo)
    ;    (attribute macchiacolore)
    ;    (value bianco))
    ;(oav(object grappolo)
    ;    (attribute macchiacolore)
    ;    (value bruno))
;end OR
    (oav(object grappolo)
        (attribute muffa)
        (value scura))

    (oav(object tralcio)
        (attribute tacche)
        (value si))
    =>
    (printout t "La malattia è: Marciume Bianco" crlf)
)             


(defrule marciumenero
    (oav(object foglia)
        (attribute colore)
        (value bruno))
    (oav(object foglia)
        (attribute macchiaforma)
        (value regolare))

    (oav(object infiorescenza)
        (attribute tacche)
        (value si))
    (oav(object infiorescenza)
        (attribute colore)
        (value scuro))
    (oav(object infiorescenza)
        (attribute fattoredsm)
        (value aborto))
;OR
    (oav(object grappolo)
        (attribute macchiacolore)
        (value bianco|bruno|nero))
    ;(oav(object grappolo)
    ;	(attribute macchiacolore)
    ;	(value bruno))
    ;(oav(object grappolo)
    ;	(attribute macchiacolore)
    ;	(value nero))
;end OR
    =>
    (printout t "La malattia è: Marciume Nero" crlf)
)


;;;;;;;;;;;;;;;;
;;;; BATTERI ;;;
;;;;;;;;;;;;;;;;

(defrule rognadellavite
    (oav(object tralcio)
        (attribute tacche)
        (value si))
    (oav(object tralcio)
        (attribute escrescenze)
        (value si))
    (oav(object tralcio)
        (attribute colore)
        (value bruno))

    (oav(object ceppo)
        (attribute tacche)
        (value si))
    (oav(object ceppo)
        (attribute escrescenze)
        (value si))
    (oav(object ceppo)
        (attribute colore)
        (value bruno))
    =>
    (printout t "La malattia è: Rogna della Vite" crlf)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; FITOPLASMI DELLA VITE ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule fitoplasmidellavite
;OR
    (oav(object foglia)
        (attribute colore)
        (value giallo|rosso))
    ;(oav(object foglia)
    ;    (attribute colore)
    ;    (value rosso))
;end OR
    (oav(object foglia)
        (attribute deformazione)
        (value si))  
    (oav(object foglia)
        (attribute caduta)
        (value si))

    (oav(object grappolo)
        (attribute disseccamento)
        (value si))
    (oav(object grappolo)
        (attribute caduta)
        (value si))

    (oav(object tralcio)
        (attribute fattoredsm)
        (value basso))
    (oav(object tralcio)
        (attribute macchiacolore)
        (value nero))
    (oav(object tralcio)
        (attribute macchiaforma)
        (value puntiforme))
    =>
    (printout t "La malattia è: Fitoplasmi della Vite" crlf)
)


;;;;;;;;;;;;;;;;;
;;;; NEMATODI ;;;
;;;;;;;;;;;;;;;;;

(defrule nematodi
    (oav(object ceppo)
        (attribute escrescenze)
        (value si))

    (oav(object radice)
        (attribute escrescenze)
        (value si))
    =>
    (printout t "La malattia è: Nematodi" crlf)
)


;;;;;;;;;;;;;;;;
;;;; INSETTI ;;;
;;;;;;;;;;;;;;;;

(defrule cocciniglia
    (oav(object foglia)
        (attribute disseccamento)
        (value si))
    (oav(object foglia)
        (attribute melatafumag)
        (value si))

    (oav(object grappolo)
        (attribute fattoredsm)
        (value basso))
    =>
    (printout t "La malattia è: Cocciniglia" crlf)
)


(defrule tripidedellavite
    (oav(object foglia)
        (attribute macchiacolore)
        (value giallo))
    (oav(object foglia)
        (attribute deformazione)
        (value si))

    (oav(object grappolo)
        (attribute fattoredsm)
        (value ritardo))
    (oav(object grappolo)
        (attribute macchiacolore)
        (value bruno))

    (oav(object infiorescenza)
        (attribute fattoredsm)
        (value aborto))
    (oav(object infiorescenza)
        (attribute macchiacolore)
        (value giallo))
    =>
    (printout t "La malattia è: Tripide della Vite" crlf)
)


(defrule tignolettadellavite    
    (oav(object grappolo)
        (attribute colore)
        (value bruno))
    (oav(object grappolo)
        (attribute puntura)
        (value si))
    =>
    (printout t "La malattia è: Tignoletta della Vite" crlf)
)


(defrule tignola   
    (oav(object foglia)
        (attribute disseccamento)
        (value si))

    (oav(object grappolo)
        (attribute macchiacolore)
        (value bianco))
    (oav(object grappolo)
        (attribute puntura)
        (value si))

    (oav(object infiorescenza)
        (attribute fattoredsm)
        (value aborto))
    =>
    (printout t "La malattia è: Tignola" crlf)
)


(defrule tetranichidae   
;OR
    (oav(object foglia)
        (attribute colore)
        (value giallo|rosso))
    ;(oav(object foglia)
    ;    (attribute colore)
    ;    (value rosso))
;end OR
    (oav(object foglia)
        (attribute macchiaforma)
        (value puntiforme))
    (oav(object foglia)
        (attribute disseccamento)
        (value si))

    (oav(object grappolo)
        (attribute fattoredsm)
        (value basso))
    =>
    (printout t "La malattia è: Tetranichidae" crlf)
)


;;;;;;;;;;;;;;
;;;; VIRUS ;;;
;;;;;;;;;;;;;;

(defrule legnoriccio
    (oav(object foglia)
        (attribute colore)
        (value giallo))

    (oav(object tralcio)
        (attribute fattoredsm)
        (value basso))

    (oav(object ceppo)
        (attribute tacche)
        (value si))
    =>
    (printout t "La malattia è: Legno Riccio" crlf)
)


(defrule accartocciamento
    (oav(object foglia)
        (attribute deformazione)
        (value si))
    (oav(object foglia)
        (attribute colore)
        (value rosso))

    (oav(object grappolo)
        (attribute fattoredsm)
        (value basso))

    (oav(object tralcio)
        (attribute fattoredsm)
        (value irregolare))
    =>
    (printout t "La malattia è: Accartocciamento Fogliare" crlf)
)


(defrule arricciamento
    (oav(object foglia)
        (attribute deformazione)
        (value si))
    (oav(object foglia)
        (attribute macchiaforma)
        (value mosaico))
    (oav(object foglia)
        (attribute nervature)
        (value deformazione))

    (oav(object tralcio)
        (attribute fattoredsm)
        (value irregolare))

;and
    (oav(object ceppo)
        (attribute fattoredsm)
        (value irregolare))
    (oav(object ceppo)
        (attribute fattoredsm)
        (value aborto))
    =>
    (printout t "La malattia è: Arricciamento Fogliare" crlf)
)



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
                      (bind ?patologia (str-cat ?patologia (create_string_deffacts ?nome ?x:struttura ?x:sintomo ?x:valore) (format nil "%n")))
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
                      (bind ?patologia (str-cat ?patologia (create_string_rule ?x:struttura ?x:sintomo ?x:valore) (format nil "%n") ) )
                      
    )
    (printout data (str-cat ?patologia "=>" (format nil "%n")) )
    (printout data "(printout t \"La malattia è:  ")
    (printout data ?nome)
    (printout data " \" ")
    (printout data "crlf)" crlf ")" crlf)
    (close)
)