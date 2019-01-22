;regole che si attivano in caso di malattie diagnosticate


(deffunction diagnosys_completed (?name ?status_fact)
    (printout t crlf crlf "******************************* La malattia diagnosticata è: "?name" *******************************" crlf crlf) 
	(modify ?status_fact (phase START) (sequence))
    (focus SYS)
)


;;;;;;;;;;;;;;
;;; FUNGHI ;;;
;;;;;;;;;;;;;;

(defrule DGNSYS::peronospora
?f <- (system_status (mode diagnosys))  

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
	(diagnosys_completed "Peronospora" ?f)
	
)


(defrule DGNSYS::oidio
?f <- (system_status (mode diagnosys))

    (oav(object foglia)
        (attribute macchiacolore)
        (value giallo|scuro))
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
	(diagnosys_completed "Oidio" ?f)
	
)


(defrule DGNSYS::botrite
?f <- (system_status (mode diagnosys))
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
	(diagnosys_completed "Botrite" ?f)
	
    
)


(defrule DGNSYS::marciumeradicale
?f <- (system_status (mode diagnosys))
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
	(diagnosys_completed "Marciume Radicale" ?f)
	
    
)


(defrule DGNSYS::verticilliosi
?f <- (system_status (mode diagnosys))
    (oav(object foglia)
        (attribute disseccamento)
        (value si))

    (oav(object ceppo)
        (attribute tacche)
        (value si))
    =>
	(diagnosys_completed "Verticilliosi" ?f)
	
)


(defrule DGNSYS::maldellesca
?f <- (system_status (mode diagnosys))
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

    (oav(object ceppo)
        (attribute macchiacolore)
        (value bianco|giallo))
    (oav(object ceppo)	    
        (attribute marciume)
        (value spugnoso))
    (oav(object ceppo)
        (attribute deformazione)
        (value si))
    =>
	(diagnosys_completed "Mal dell' esca" ?f)
	
)


(defrule DGNSYS::marciumebianco
?f <- (system_status (mode diagnosys))

    (oav(object grappolo)
        (attribute macchiacolore)
        (value giallo|bianco|bruno))
    (oav(object grappolo)
        (attribute muffa)
        (value scura))

    (oav(object tralcio)
        (attribute tacche)
        (value si))
    =>
	(diagnosys_completed "Marciume Bianco" ?f)
	
)             


(defrule DGNSYS::marciumenero
?f <- (system_status (mode diagnosys))
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

    (oav(object grappolo)
        (attribute macchiacolore)
        (value bianco|bruno|nero))

    =>
	(diagnosys_completed "Marciume Nero" ?f)
	
)


;;;;;;;;;;;;;;;;
;;;; BATTERI ;;;
;;;;;;;;;;;;;;;;

(defrule DGNSYS::rognadellavite
?f <- (system_status (mode diagnosys))
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
	(diagnosys_completed "Rogna della Vite" ?f)
	
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; FITOPLASMI DELLA VITE ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule DGNSYS::fitoplasmidellavite
?f <- (system_status (mode diagnosys))
    (oav(object foglia)
        (attribute colore)
        (value giallo|rosso))

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
	(diagnosys_completed "Fitoplasmi della Vite" ?f)
	
)


;;;;;;;;;;;;;;;;;
;;;; NEMATODI ;;;
;;;;;;;;;;;;;;;;;

(defrule DGNSYS::nematodi
?f <- (system_status (mode diagnosys))
    (oav(object ceppo)
        (attribute escrescenze)
        (value si))

    (oav(object radice)
        (attribute escrescenze)
        (value si))
    =>
	(diagnosys_completed "Nematodi" ?f)
	
)


;;;;;;;;;;;;;;;;
;;;; INSETTI ;;;
;;;;;;;;;;;;;;;;

(defrule DGNSYS::cocciniglia
?f <- (system_status (mode diagnosys))
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
	(diagnosys_completed "Cocciniglia" ?f)
	
)


(defrule DGNSYS::tripidedellavite
?f <- (system_status (mode diagnosys))
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
	(diagnosys_completed "Tripide della Vite" ?f)
	
)


(defrule DGNSYS::tignolettadellavite
?f <- (system_status (mode diagnosys))    
    (oav(object grappolo)
        (attribute colore)
        (value bruno))
    (oav(object grappolo)
        (attribute puntura)
        (value si))
    =>
	(diagnosys_completed "Tignoletta della Vite" ?f)
	
)


(defrule DGNSYS::tignola
?f <- (system_status (mode diagnosys))   
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
	(diagnosys_completed "Tignola" ?f)
	
)


(defrule DGNSYS::tetranichidae
?f <- (system_status (mode diagnosys))   

    (oav(object foglia)
        (attribute colore)
        (value giallo|rosso))
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
	(diagnosys_completed "Tetranichidae" ?f)
	
)


;;;;;;;;;;;;;;
;;;; VIRUS ;;;
;;;;;;;;;;;;;;

(defrule DGNSYS::legnoriccio
?f <- (system_status (mode diagnosys))
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
	(diagnosys_completed "Legno Riccio" ?f)
	
)


(defrule DGNSYS::accartocciamento
?f <- (system_status (mode diagnosys))
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
	(diagnosys_completed "Accartocciamento Fogliare" ?f)
	
)


(defrule DGNSYS::arricciamento
?f <- (system_status (mode diagnosys))
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

    (oav(object ceppo)
        (attribute fattoredsm)
        (value irregolare))
    (oav(object ceppo)
        (attribute fattoredsm)
        (value aborto))
    =>
	(diagnosys_completed "Arricciamento Fogliare" ?f)
	
)