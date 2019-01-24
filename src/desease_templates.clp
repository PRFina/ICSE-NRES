;; models symptom entity by its name (and value) and the structure on which it appears;
;; desease field is a join attribute with field name of desease template 
(deftemplate PROC::symptom (slot desease (default ?NONE))
                     (slot structure (allowed-values radice ceppo tralcio infiorescenza foglia grappolo)(default ?NONE))
                     (slot name (default ?NONE))
                     (slot value (default ?NONE))
)

;; models the connection between symptom and category, through name field 
(deftemplate PROC::desease (slot name (default ?NONE))
                     (slot category (allowed-values insetti funghi batteri fitoplasmi nematodi virus)(default ?NONE))
)


;; models user response about each symptom
(deftemplate PROC::QandA (slot structure)
                   (slot symptom)
                   (slot answer)
)
