; template diagnosi per modellare le asserzioni fatte dal modulo di calcolo

(deftemplate diagnosi(slot struttura(allowed-values radice ceppo tralcio foglia infiorescenza grappolo nil)(default nil))
                     (slot colore(allowed-values bruno chiaro scuro verde giallo rosso bianco grigio nero nil)(default nil))
                     (slot macchiacolore(allowed-values bruno chiaro scuro verde giallo rosso bianco grigio nero nil)(default nil))
                     (slot macchiaforma(allowed-values regolare irregolare puntiforme mosaico nil)(default nil))
                     (slot muffa(allowed-values grigia bianca scura nil)(default nil))
                     (slot deformazione(allowed-values si no nil)(default nil))
                     (slot marciume(allowed-values si no spugnoso nil)(default nil))
                     (slot disseccamento(allowed-values si no nil)(default nil))
                     (slot caduta(allowed-values si no nil)(default nil))
                     (slot nervature(allowed-values verde deformazione nil)(default nil))
                     (slot tacche(allowed-values si no nil)(default nil))
                     (multislot fattoredsm(allowed-values basso irregolare ritardo aborto nil)(default nil))
                     (slot melatafumag(allowed-values si no nil)(default nil))
                     (slot escrescenze(allowed-values si no nil)(default nil))
                     (slot puntura(allowed-values si no nil)(default nil))
)

; regole che modellano le malattie e matchano i sintomi per eseguire la diagnosi

;;;;;;;;;;;;;;;;;;;;;;;;
;;; PATOLOGIE FUNGHI ;;;
;;;;;;;;;;;;;;;;;;;;;;;;

(defrule peronospora
    (diagnosi
            (struttura foglia)
            (macchiaforma regolare)
            (macchiacolore giallo)
            (muffa bianca)      
            (disseccamento si))
    (diagnosi
            (struttura infiorescenza)
            (colore bruno)
            (deformazione si))
    (diagnosi
            (struttura grappolo)
            (deformazione si)
            (disseccamento si))
    =>
    (printout t "La malattia è: Peronospora" crlf)
)

(defrule oidio
    (diagnosi
            (struttura foglia)
            (macchiacolore giallo)
            (deformazione si))
    (diagnosi
            (struttura foglia)
            (macchiacolore scuro)
            (deformazione si))
    (diagnosi
            (struttura infiorescenza)
            (colore bianco)
            (deformazione si))
    (diagnosi
            (struttura grappolo)
            (caduta si)
            (muffa bianca))
    (diagnosi
            (struttura tralcio)
            (muffa bianca) 
            (deformazione si))
    =>
    (printout t "La malattia è: Oidio" crlf)
)

(defrule botrite
    (diagnosi
            (struttura foglia)
            (macchiacolore giallo))
    (diagnosi
            (struttura grappolo)
            (caduta si)
            (muffa grigia))
    (diagnosi
            (struttura tralcio)
            (disseccamento si)
            (colore bruno))
    =>
    (printout t "La malattia è: Botrite" crlf) 
)

(defrule marciumeradicale
    (diagnosi
            (struttura foglia)
            (disseccamento si))
    (diagnosi
            (struttura ceppo)
            (macchiacolore bianco))
    (diagnosi
            (struttura radice)
            (macchiacolore bianco))    
    =>
    (printout t "La malattia è: Marciume Radicale" crlf)                                                
)

(defrule verticilliosi
    (diagnosi
            (struttura foglia)
            (disseccamento si))
    (diagnosi
            (struttura ceppo)
            (tacche si)) 
    =>
    (printout t "La malattia è: Verticilliosi" crlf)                       
)

(defrule maldellesca
    (diagnosi
            (struttura foglia)
            (macchiacolore giallo)
            (nervature verde)
            (disseccamento si))
    (diagnosi
            (struttura grappolo)
            (macchiacolore bruno)
            (macchiaforma puntiforme))
    (diagnosi
            (struttura ceppo)                               
            (deformazione si)
            (macchiacolore bianco)
            (marciume spugnoso))
    (diagnosi
            (struttura ceppo)                               
            (deformazione si)
            (macchiacolore giallo)
            (marciume spugnoso))
    =>
    (printout t "La malattia è: Mal dell' esca" crlf)
)

(defrule marciumebianco
    (diagnosi
            (struttura grappolo)
            (macchiacolore giallo)
            (muffa scura))
    (diagnosi
            (struttura grappolo)
            (macchiacolore bianco)
            (muffa scura))
    (diagnosi
            (struttura grappolo)
            (macchiacolore bruno)
            (muffa scura))
    (diagnosi
            (struttura tralcio)
            (tacche si))
    =>
    (printout t "La malattia è: Marciume Bianco" crlf)                  
)
    
(defrule marciumenero
    (diagnosi
            (struttura foglia)
            (colore bruno)
            (macchiaforma regolare))
    (diagnosi
            (struttura infiorescenza)
            (tacche si)
            (colore scuro)
            (fattoredsm aborto))
    (diagnosi
            (struttura grappolo)
            (macchiacolore bianco))
    (diagnosi
            (struttura grappolo)
            (macchiacolore bruno))
    (diagnosi
            (struttura grappolo)
            (macchiacolore nero))
    =>
    (printout t "La malattia è: Marciume Nero" crlf)
)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;; PATOLOGIE BATTERI ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule rognadellavite
    (diagnosi
            (struttura tralcio)
            (tacche si)
            (escrescenze si)
            (colore bruno))
    (diagnosi
            (struttura ceppo)
            (tacche si)
            (escrescenze si)
            (colore bruno))
    =>
    (printout t "La malattia è: Rogna della Vite" crlf)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; FITOPLASMI DELLA VITE ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule fitoplasmidellavite
    (diagnosi
            (struttura ceppo))
    (diagnosi
            (struttura foglia)
            (colore giallo)
            (deformazione si)
            (caduta si))
    (diagnosi
            (struttura foglia)
            (colore rosso)
            (deformazione si)
            (caduta si))
    (diagnosi
            (struttura grappolo)
            (disseccamento si)
            (caduta si))
    (diagnosi
            (struttura tralcio)
            (fattoredsm basso)
            (macchiacolore nero)
            (macchiaforma puntiforme))
    =>
    (printout t "La malattia è: Fitoplasmi della Vite" crlf)
)

;;;;;;;;;;;;;;;;
;;; NEMATODI ;;;
;;;;;;;;;;;;;;;;
(defrule nematodi
    (diagnosi
            (struttura ceppo)
            (escrescenze si))
    (diagnosi
            (struttura radice)
            (escrescenze si))
    =>
    (printout t "La malattia è: Nematodi" crlf)
)

;;;;;;;;;;;;;;;
;;; INSETTI ;;;
;;;;;;;;;;;;;;;
(defrule cocciniglia
    (diagnosi
            (struttura foglia)
            (disseccamento si)
            (melatafumag si))
    (diagnosi
            (struttura grappolo)
            (fattoredsm basso))
    =>
    (printout t "La malattia è: Cocciniglia" crlf)
)

(defrule tripidedellavite
    (diagnosi
            (struttura foglia)
            (macchiacolore giallo)
            (deformazione si))
    (diagnosi
            (struttura grappolo)
            (fattoredsm ritardo)
            (macchiacolore bruno))
    (diagnosi
            (struttura infiorescenza)
            (fattoredsm aborto)
            (macchiacolore giallo))
    =>
    (printout t "La malattia è: Tripide della Vite" crlf)
)

(defrule tignolettadellavite
    (diagnosi
            (struttura grappolo)
            (colore bruno)
            (puntura si))
    =>
    (printout t "La malattia è: Tignoletta della Vite" crlf)
)

(defrule tignola
    (diagnosi
            (struttura foglia)
            (disseccamento si))
    (diagnosi
            (struttura grappolo)
            (macchiacolore bianco)
            (puntura si))
    (diagnosi
            (struttura infiorescenza)
            (fattoredsm aborto))
    =>
    (printout t "La malattia è: Tignola" crlf)
)

(defrule tetranichidae
    (diagnosi
            (struttura foglia)
            (colore giallo)
            (macchiaforma puntiforme)
            (disseccamento si))
    (diagnosi
            (struttura foglia)
            (colore rosso)
            (macchiaforma puntiforme)
            (disseccamento si))
    (diagnosi
            (struttura grappolo)
            (fattoredsm basso))
    =>
    (printout t "La malattia è: Tetranichidae" crlf)
)

;;;;;;;;;;;;;
;;; VIRUS ;;;
;;;;;;;;;;;;;
(defrule legnoriccio
    (diagnosi
            (struttura foglia)
            (colore giallo))
    (diagnosi
            (struttura tralcio)
            (fattoredsm basso))
    (diagnosi
            (struttura ceppo)
            (tacche si))
    =>
    (printout t "La malattia è: Legno Riccio" crlf)
)

(defrule accartocciamento
    (diagnosi
            (struttura foglia)
            (deformazione si)
            (colore rosso))
    (diagnosi
            (struttura grappolo)
            (fattoredsm basso))
    (diagnosi
            (struttura tralcio)
            (fattoredsm irregolare))
    =>
    (printout t "La malattia è: Accartocciamento Fogliare" crlf)
)

(defrule arricciamento
    (diagnosi
            (struttura foglia)
            (deformazione si)
            (macchiaforma mosaico)
            (nervature deformazione))
    (diagnosi
            (struttura tralcio)
            (fattoredsm irregolare))
    (diagnosi
            (struttura ceppo)
            (fattoredsm irregolare aborto))
    =>
    (printout t "La malattia è: Arricciamento Fogliare" crlf)
)



;Create
(deffunction create_sintomo_string(?patologia ?struttura ?sintomo ?valore)
    ;(bind ?f (format nil "(symptom (structure %s)%n" ?struttura))
    (bind ?sintomi "")
    (bind ?sintomi (str-cat ?sintomi (format nil "(symptom (desease %s)%n" ?patologia)))
    (bind ?sintomi (str-cat ?sintomi (format nil "(structure %s)%n" ?struttura)))
    (bind ?sintomi (str-cat ?sintomi (format nil "(name %s)%n(value %s))%n" ?sintomo ?valore)))
    (return ?sintomi)
)

(deffunction create_patologia_string(?nome ?categoria)
    (open "learned-deffacts.txt" data "a")
    (bind ?patologia "")
    (bind ?patologia (format nil "(deffacts %s %n%n(desease (name %s) %n(category %s))%n%n" ?nome ?nome ?categoria))
    (do-for-all-facts ((?x aov))
                      (eq 1 1)
                      (bind ?patologia (str-cat ?patologia (create_sintomo_string ?nome ?x:struttura ?x:sintomo ?x:valore) (format nil "%n")))
    )
    (printout data (str-cat ?patologia ")") crlf)
    (close)
)
