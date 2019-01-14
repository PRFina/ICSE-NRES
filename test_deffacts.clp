;asserisce inizialmente tutte le patologie, i relativi sintomi e le categorie alle quali appartengono

;;;;;;;;;;;;;;;;;;;;;;;;
;;; PATOLOGIE FUNGHI ;;;
;;;;;;;;;;;;;;;;;;;;;;;;
(deffacts initial_patologie
    (patologia(nome peronospora)
            (categoria funghi))
    (sintomo(nome peronospora)
            (struttura foglia)
            (macchiaforma regolare)
            (macchiacolore giallo)
            (muffa bianca)      
            (disseccamento si))
    (sintomo(nome peronospora)
            (struttura infiorescenza)
            (colore bruno)
            (deformazione si))
    (sintomo(nome peronospora)
            (struttura grappolo)
            (deformazione si)
            (disseccamento si)) 


    (patologia(nome marciumeradicale)
            (categoria funghi))  
    (sintomo(nome marciumeradicale)
            (struttura foglia)
            (disseccamento si))
    (sintomo(nome marciumeradicale)
            (struttura ceppo)
            (macchiacolore bianco))
    (sintomo(nome marciumeradicale)
            (struttura radice)
            (macchiacolore bianco))                                                    
    
   
    (patologia(nome cocciniglia)
            (categoria insetti))
    (sintomo(nome cocciniglia)
            (struttura foglia)
            (disseccamento si)
            (melatafumag si))
    (sintomo(nome cocciniglia)
            (struttura grappolo)
            (fattoredsm basso))
)
