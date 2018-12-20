;modella l'entità sintomo
(deftemplate sintomo(slot struttura(allowed-values radice ceppo tralcio foglia infiorescenza grappolo nil)(default nil))
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
                    (slot nome)
)

;modella il legame tra patologia e categoria usando nome come attributo di join
(deftemplate patologia(slot nome)
                      (slot categoria(allowed-values insetti funghi batteri fitoplasmi nematodi virus nil)(default nil))
)

;(deftemplate ambiente(multislot stagione(allowed-values inverno primavera estate autunno nil) (default nil))
;                     (slot temperatura(range -10 40))
;                     (multislot fasefenologica(allowed-values radice ceppo tralcio gemma foglia infiorescenza grappolo nil)(default nil))
;                     (slot estensione(allowed-values locale esteso nil)(default nil))
;)

;template per classificare gli elementi di struttura
(deftemplate damaged_structs_rank (slot categoria)
                                  (slot struttura)
                                  (slot counter)
                                  (multislot asserted_slots)
)