;modella l'entità sintomo
(deftemplate symptom (slot desease (default ?NONE))
                     (slot structure (allowed-values radice ceppo tralcio infiorescenza foglia grappolo)(default ?NONE))
                     (slot name (default ?NONE))
                     (slot value (default ?NONE))
)

;modella il legame tra patologia e categoria usando nome come attributo di join
(deftemplate desease (slot name (default ?NONE))
                     (slot category (allowed-values insetti funghi batteri fitoplasmi nematodi virus)(default ?NONE))
)


;template per classificare gli elementi di struttura
(deftemplate damaged_structs_rank (slot categoria)
                                  (slot struttura)
                                  (slot counter)
                                  (multislot asserted_slots)
                                  (slot global_rank)
)

;modella le categorie gestite nel modulo environment
(deftemplate categoria (slot nome)
                       (slot punteggio)
)

;modella la risposta dell'utente
(deftemplate QandA (slot struttura)
                   (slot sintomo)
                   (slot risposta))
