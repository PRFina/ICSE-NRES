;modella l'entità sintomo
(deftemplate PROC::symptom (slot desease (default ?NONE))
                     (slot structure (allowed-values radice ceppo tralcio infiorescenza foglia grappolo)(default ?NONE))
                     (slot name (default ?NONE))
                     (slot value (default ?NONE))
)

;modella il legame tra patologia e categoria usando nome come attributo di join
(deftemplate PROC::desease (slot name (default ?NONE))
                     (slot category (allowed-values insetti funghi batteri fitoplasmi nematodi virus)(default ?NONE))
)




;modella la risposta dell'utente
(deftemplate PROC::QandA (slot structure)
                   (slot symptom)
                   (slot answer)
)
