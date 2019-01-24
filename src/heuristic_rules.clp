; Semantica: in inverno (quindi con temperature basse) gli insetti sono in letargo quindi poco probabili
(defrule ENV::inverno_insetti_low
    (season winter)
    (temperature low)
    =>
    (assert (category (name insetti) (membership low)))
)

; Semantica: operazioni di manutenzione come la potatura potrebbero causare ferite sulle strutture della pianta
;            le quali favoriscono lo sviluppo dei batteri
(defrule ENV::potatura_batteri_high
    (maintenance si)
    =>
    (assert (category (name batteri)(membership high)))
)

; Semantica: la grandine, in qualsiasi stagione, può causare sulle strutture presenti, ferite (tacche) nelle quali 
;            trovano terreno fertile i batteri
(defrule ENV::grandine_batteri_high
    (precipitations grandine)
    =>
    (assert (category(name batteri)(membership high)))
)

; Semantica: in primavera e con il clima mite iniziano a comparire gli insetti che rimangono
;            favoriti in estate con il clima caldo
(defrule ENV::primavera_estate_insetti_high
    (season spring or summer)
    (temperature middle or high)
    =>
    (assert (category (name insetti)(membership high)))
)

;Semantica: temperature alte (>26°) e clima secco, quindi estate, limitano le patologie dei funghi,
;           inoltre favoriscono gli insetti 
(defrule ENV::estate_funghi_low
    (season very summer)
    (precipitations no)
    =>
    (assert (category(name funghi)(membership low)))
 
)

;Semantica: temperature medie e clima umido favoriscono la formazione di funghi
(defrule ENV::primavera_autunno_funghi_high
    (season spring or autumn)
    (temperature very middle)
    (precipitations pioggia)
    (extension estesa)
    =>
    (assert (category (name funghi) (membership high)))
)