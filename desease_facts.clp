;asserisce inizialmente tutte le patologie, i relativi sintomi e le categorie alle quali appartengono

;;;;;;;;;;;;;;
;;; FUNGHI ;;;
;;;;;;;;;;;;;;
(deffacts PROC::initial_patologie
    (desease(name peronospora)
            (category funghi))
    (symptom(desease peronospora)
            (structure foglia)
            (name macchiaforma)
            (value regolare))
    (symptom(desease peronospora)
            (structure foglia)
            (name macchiacolore)
            (value giallo))
    (symptom(desease peronospora)
            (structure foglia)
            (name muffa)
            (value bianca))
    (symptom(desease peronospora)
            (structure foglia)    
            (name disseccamento)
            (value si))
    
    (symptom(desease peronospora)
            (structure infiorescenza)
            (name colore)
            (value bruno))
    (symptom(desease peronospora)
            (structure infiorescenza)
            (name deformazione)
            (value si))

    (symptom(desease peronospora)
            (structure grappolo)
            (name deformazione)
            (value si))
    (symptom(desease peronospora)
            (structure grappolo)
            (name disseccamento)
            (value si))


    (desease(name oidio)
            (category funghi))
;OR 
    (symptom(desease oidio)
            (structure foglia)
            (name macchiacolore)
            (value giallo))
    (symptom(desease oidio)
            (structure foglia)
            (name macchiacolore)
            (value scuro))
;end OR
    (symptom(desease oidio)
            (structure foglia)
            (name deformazione)
            (value si))
    
    (symptom(desease oidio)
            (structure infiorescenza)
            (name colore)
            (value bianco))
    (symptom(desease oidio)
            (structure infiorescenza)
            (name deformazione)
            (value si))

    (symptom(desease oidio)
            (structure grappolo)
            (name caduta)
            (value si))
    (symptom(desease oidio)
            (structure grappolo)
            (name muffa)
            (value bianca))

    (symptom(desease oidio)
            (structure tralcio)
            (name muffa)
            (value bianca))
    (symptom(desease oidio)
            (structure tralcio)
            (name deformazione)
            (value si))
    

    (desease(name botrite)
            (category funghi)) 
    (symptom(desease botrite)
            (structure foglia)
            (name macchiacolore)
            (value giallo))

    (symptom(desease botrite)
            (structure grappolo)
            (name caduta)
            (value si))
    (symptom(desease botrite)
            (structure grappolo)
            (name muffa)
            (value grigia))

    (symptom(desease botrite)
            (structure tralcio)
            (name disseccamento)
            (value si))
    (symptom(desease botrite)
            (structure tralcio)
            (name colore)
            (value bruno))

    
    (desease(name marciumeradicale)
            (category funghi))  
    (symptom(desease marciumeradicale)
            (structure foglia)
            (name disseccamento)
            (value si))

    (symptom(desease marciumeradicale)
            (structure ceppo)
            (name macchiacolore)
            (value bianco))

    (symptom(desease marciumeradicale)
            (structure radice)
            (name macchiacolore)
            (value bianco))
    

    (desease(name verticilliosi)
            (category funghi))
    (symptom(desease verticilliosi)
            (structure foglia)
            (name disseccamento)
            (value si))

    (symptom(desease verticilliosi)
            (structure ceppo)
            (name tacche)
            (value si))                        


    (desease(name maldellesca)
            (category funghi))
    (symptom(desease maldellesca)
            (structure foglia)
            (name macchiacolore)
            (value giallo))
    (symptom(desease maldellesca)
            (structure foglia)
            (name nervature)
            (value verde))
    (symptom(desease maldellesca)
            (structure foglia)
            (name disseccamento)
            (value si))

    (symptom(desease maldellesca)
            (structure grappolo)
            (name macchiacolore)
            (value bruno))
    (symptom(desease maldellesca)
            (structure grappolo)
            (name macchiaforma)
            (value puntiforme))
;OR
    (symptom(desease maldellesca)
            (structure ceppo)
            (name macchiacolore)
            (value bianco))
    (symptom(desease maldellesca)
            (structure ceppo)
            (name macchiacolore)
            (value giallo))
;end OR
    (symptom(desease maldellesca)
            (structure ceppo)	    
            (name marciume)
            (value spugnoso))
    (symptom(desease maldellesca)
            (structure ceppo)
            (name deformazione)
            (value si))


    (desease(name marciumebianco)
            (category funghi))
;OR
    (symptom(desease marciumebianco)
            (structure grappolo)
            (name macchiacolore)
            (value giallo))
    (symptom(desease marciumebianco)
            (structure grappolo)
            (name macchiacolore)
            (value bianco))
    (symptom(desease marciumebianco)
            (structure grappolo)
            (name macchiacolore)
            (value bruno))
;end OR
    (symptom(desease marciumebianco)
            (structure grappolo)
            (name muffa)
            (value scura))

    (symptom(desease marciumebianco)
            (structure tralcio)
            (name tacche)
            (value si))                   


    (desease(name marciumenero)
            (category funghi))
    (symptom(desease marciumenero)
            (structure foglia)
            (name colore)
            (value bruno))
    (symptom(desease marciumenero)
            (structure foglia)
            (name macchiaforma)
            (value regolare))

    (symptom(desease marciumenero)
            (structure infiorescenza)
            (name tacche)
            (value si))
    (symptom(desease marciumenero)
            (structure infiorescenza)
            (name colore)
            (value scuro))
    (symptom(desease marciumenero)
            (structure infiorescenza)
            (name fattoredsm)
            (value aborto))
;OR
    (symptom(desease marciumenero)
            (structure grappolo)
            (name macchiacolore)
            (value bianco))
    (symptom(desease marciumenero)
            (structure grappolo)
            (name macchiacolore)
            (value bruno))
    (symptom(desease marciumenero)
            (structure grappolo)
            (name macchiacolore)
            (value nero))
;end OR

;;;;;;;;;;;;;;;;
;;;; BATTERI ;;;
;;;;;;;;;;;;;;;;
    (desease(name rognadellavite)
            (category batteri))
    (symptom(desease rognadellavite)
            (structure tralcio)
            (name tacche)
            (value si)
    (symptom(desease rognadellavite)
            (structure tralcio)
            (name escrescenze)
            (value si))
    (symptom(desease rognadellavite)
            (structure tralcio)
            (name colore)
            (value bruno))

    (symptom(desease rognadellavite)
            (structure ceppo)
            (name tacche)
            (value si))
    (symptom(desease rognadellavite)
            (structure ceppo)
            (name escrescenze)
            (value si))
    (symptom(desease rognadellavite)
            (structure ceppo)
            (name colore)
            (value bruno))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; FITOPLASMI DELLA VITE ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (desease(name fitoplasmidellavite)
            (category fitoplasmi))
;OR
    (symptom(desease fitoplasmidellavite)
            (structure foglia)
            (name colore)
            (value giallo))
    (symptom(desease fitoplasmidellavite)
            (structure foglia)
            (name colore)
            (value rosso))
;end OR
    (symptom(desease fitoplasmidellavite)
            (structure foglia)
            (name deformazione)
            (value si))  
    (symptom(desease fitoplasmidellavite)
            (structure foglia)
            (name caduta)
            (value si))

    (symptom(desease fitoplasmidellavite)
            (structure grappolo)
            (name disseccamento)
            (value si))
    (symptom(desease fitoplasmidellavite)
            (structure grappolo)
            (name caduta)
            (value si))

    (symptom(desease fitoplasmidellavite)
            (structure tralcio)
            (name fattoredsm)
            (value basso)
    (symptom(desease fitoplasmidellavite)
            (structure tralcio)
            (name macchiacolore)
            (value nero))
    (symptom(desease fitoplasmidellavite)
            (structure tralcio)
            (name macchiaforma)
            (value puntiforme))

;;;;;;;;;;;;;;;;;
;;;; NEMATODI ;;;
;;;;;;;;;;;;;;;;;
    (desease(name nematodi)
            (category nematodi))
    (symptom(desease nematodi)
            (structure ceppo)
            (name escrescenze)
            (value si))

    (symptom(desease nematodi)
            (structure radice)
            (name escrescenze)
            (value si))

;;;;;;;;;;;;;;;;
;;;; INSETTI ;;;
;;;;;;;;;;;;;;;;
    (desease(name cocciniglia)
            (category insetti))
    (symptom(desease cocciniglia)
            (structure foglia)
            (name disseccamento)
            (value si))
    (symptom(desease cocciniglia)
            (structure foglia)
            (name melatafumag)
            (value si))

    (symptom(desease cocciniglia)
            (structure grappolo)
            (name fattoredsm)
            (value basso))


    (desease(name tripidedellavite)
            (category insetti))
    (symptom(desease tripidedellavite)
            (structure foglia)
            (name macchiacolore)
            (value giallo))
    (symptom(desease tripidedellavite)
            (structure foglia)
            (name deformazione)
            (value si))

    (symptom(desease tripidedellavite)
            (structure grappolo)
            (name fattoredsm)
            (value ritardo))
    (symptom(desease tripidedellavite)
            (structure grappolo)
            (name macchiacolore)
            (value bruno))

    (symptom(desease tripidedellavite)
            (structure infiorescenza)
            (name fattoredsm)
            (value aborto))
    (symptom(desease tripidedellavite)
            (structure infiorescenza)
            (name macchiacolore)
            (value giallo))


    (desease(name tignolettadellavite)
            (category insetti))
    (symptom(desease tignolettadellavite)
            (structure grappolo)
            (name colore)
            (value bruno))
    (symptom(desease tignolettadellavite)
            (structure grappolo)
            (name puntura)
            (value si))


    (desease(name tignola)
            (category insetti))
    (symptom(desease tignola)
            (structure foglia)
            (name disseccamento)
            (value si))

    (symptom(desease tignola)
            (structure grappolo)
            (name macchiacolore)
            (value bianco))
    (symptom(desease tignola)
            (structure grappolo)
            (name puntura)
            (value si))

    (symptom(desease tignola)
            (structure infiorescenza)
            (name fattoredsm)
            (value aborto))


    (desease(name tetranichidae)
            (category insetti))
;OR
    (symptom(desease tetranichidae)
            (struttura foglia)
            (name colore)
            (value giallo))
    (symptom(desease tetranichidae)
            (structure foglia)
            (name colore)
            (value rosso))
;end OR
    (symptom(desease tetranichidae)
            (struttura foglia)
            (name macchiaforma)
            (value puntiforme))
    (symptom(desease tetranichidae)
            (structure foglia)
            (name disseccamento)
            (value si))

    (symptom(desease tetranichidae)
            (structure grappolo)
            (name fattoredsm)
            (value basso))

;;;;;;;;;;;;;;
;;;; VIRUS ;;;
;;;;;;;;;;;;;;
    (desease(name legnoriccio)
            (category virus))
    (symptom(desease legnoriccio)
            (structure foglia)
            (name colore)
            (value giallo))

    (symptom(desease legnoriccio)
            (structure tralcio)
            (name fattoredsm)
            (value basso))

    (symptom(desease legnoriccio)
            (structure ceppo)
            (name tacche)
            (value si))


    (desease(name accartocciamento)
            (category virus))
    (symptom(desease accartocciamento)
            (structure foglia)
            (name deformazione)
            (value si))
    (symptom(desease accartocciamento)
            (structure foglia)
            (name colore)
            (value rosso))

    (symptom(desease accartocciamento)
            (structure grappolo)
            (name fattoredsm)
            (value basso))

    (symptom(desease accartocciamento)
            (structure tralcio)
            (name fattoredsm)
            (value irregolare))


    (desease(name arricciamento)
            (category virus))
    (symptom(desease arricciamento)
            (structure foglia)
            (name deformazione)
            (value si))
    (symptom(desease arricciamento)
            (structure foglia)
            (name macchiaforma)
            (value mosaico))
    (symptom(desease arricciamento)
            (structure foglia)
            (name nervature)
            (value deformazione))

    (symptom(desease arricciamento)
            (structure tralcio)
            (name fattoredsm)
            (value irregolare))

;and
    (symptom(name arricciamento)
            (structure ceppo)
            (name fattoredsm)
            (value irregolare))
    (symptom(name arricciamento)
            (structure ceppo)
            (name fattoredsm)
            (value aborto))
)