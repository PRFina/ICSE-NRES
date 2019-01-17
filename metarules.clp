
(deftemplate SYS::system_status (slot phase)
                                (slot mode)
                                (multislot sequence))


(deffunction SYS::select_option_system()
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
            (assert (system_status (phase init)
                                   (mode diagnosys)
                                   (sequence ENV PROC QGEN)))
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

(defrule SYS::next_phase
    ?f <- (system_status (phase ?p)
                   (mode ?m)
                   (sequence ?next $?tail))
    =>
    (focus ?next)
    (modify ?f (phase ?next) (mode ?m) (sequence ?tail ?next))


)

(defrule SYS::init_system
    =>
    (select_option_system)
)