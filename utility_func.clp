
; To use in dev
(deffunction real_to_system_calendar(?day)
    (bind ?r (+ 1 (mod (- ?day 15) 365)))
    (if (< ?r 0) 
        then (return (+ ?r 365))
        else (return ?r))  
)

(deffunction init_rank()
(bind ?categories (deftemplate-slot-allowed-values desease category))
(bind ?structures (deftemplate-slot-allowed-values symptom structure))

   (loop-for-count (?i 1 (length$ ?categories))
       do
       (bind ?category (nth$ ?i ?categories))
       
       (loop-for-count (?j 1 (length$ ?structures))
           do
           (bind ?structure (nth$ ?j ?structures))
           (assert (damaged_struct (category ?category)
                                   (structure ?structure)
                                   (symptoms_freq 0)
                                   (symptoms (create$))
                                   (rank 0)))
       )
   )
)

;Function to star app
(deffunction select_option_system()
    (printout t "" crlf)
    (printout t "" crlf)
    (printout t "****************************************************************************************************" crlf)
    (printout t "*                                                                                                  *" crlf)
    (printout t "*                                                                                                  *" crlf)
    (printout t "*   |||||                 |||   ||||||||||||||||||       ||||||||||||||||||   ||||||||||||||||||   *" crlf)
    (printout t "*   ||| |||               |||   |||            ||||      |||                  |||                  *" crlf)
    (printout t "*   |||   |||             |||   |||             ||||     |||                  |||                  *" crlf)
    (printout t "*   |||     |||           |||   |||            ||||      |||                  |||                  *" crlf)
    (printout t "*   |||       |||         |||   ||||||||||||||||||       ||||||||             ||||||||||||||||||   *" crlf)
    (printout t "*   |||         |||       |||   |||            |||       |||                                 |||   *" crlf)
    (printout t "*   |||           |||     |||   |||             |||      |||                                 |||   *" crlf)
    (printout t "*   |||             |||   |||   |||              |||     |||                                 |||   *" crlf)
    (printout t "*   |||               ||| |||   |||               |||    |||                                 |||   *" crlf)
    (printout t "*   |||                 |||||   |||                |||   ||||||||||||||||||   ||||||||||||||||||   *" crlf)
    (printout t "*                                                                                                  *" crlf)
    (printout t "*                                                                                                  *" crlf)
    (printout t "****************************************************************************************************" crlf)
    (printout t "" crlf)    
    (printout t "                                                                                      NRES v 1.0" crlf)
    (printout t "" crlf)
    (printout t "" crlf)
    (printout t "Benvenuto" crlf)
    (printout t "Premere:" crlf
                         "1) per effettuare una nuova diagnosi" crlf
                         "2) per inserire una nuova patologia" crlf
                         "3) per avviare la modalità debug" crlf)
    (bind ?answer (read))
    (switch ?answer
        
        (case 1 then 
            (batch "diagnosis_desease.clp")
        )
        (case 2 then 
            (batch "create_desease.clp")
        )
        (case 3 then 
            (assert (mode_debug))
            (run)
        )
    ) 
)
; To use in production
;(deffunction real_to_system_calendar()
;    (bind ?day (nth$ 8 (create$ (local-time))))
;    (bind ?day (+ 1 ?day)) ;; local-time return day passed in range 0-365 http://www.agr.unideb.hu/~agocs/informatics/11_e_unix/unixhelp/unixhelp.ed.ac.uk/CGI/man-cgi3ccc.html?localtime+3
;    (bind ?r (+ 1 (mod (- ?day 15) 365)))
;    (if (< ?r 0) 
;        then (return (+ ?r 365))
;        else (return ?r))  
;)