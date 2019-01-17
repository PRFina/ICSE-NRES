
; To use in dev
(deffunction MAIN::real_to_system_calendar(?day)
    (bind ?r (+ 1 (mod (- ?day 15) 365)))
    (if (< ?r 0) 
        then (return (+ ?r 365))
        else (return ?r))  
)


;Function to star app
(deffunction MAIN::select_option_system()
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
            (assert (phase-environment))
            (assert (mode_diagnosis))
            (run)
        )
        (case 2 then 
            (assert (mode_engineering))
            (run)
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