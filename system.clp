
(deftemplate SYS::system_status (slot phase)
                                (slot mode)
                                (multislot sequence))

                                ;template per classificare gli elementi di struttura
(deftemplate SYS::damaged_struct (slot category)
                            (slot structure)
                            (slot symptoms_freq)
                            (multislot symptoms)
                            (slot rank)
)

(defrule SYS::next_phase
    ?f <- (system_status (phase ?p)
                   (mode ?m)
                   (sequence ?next $?tail))
    =>
    (focus ?next)
    (modify ?f (phase ?next) (mode ?m) (sequence ?tail ?next))
)

(deffunction SYS::init_rank()
    (bind ?categories (create$ insetti funghi batteri fitoplasmi nematodi virus))
    (bind ?structures (create$ radice ceppo tralcio infiorescenza foglia grappolo))

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

(deffunction SYS::select_option_system()
    (bind ?answer (read))
    (switch ?answer
        
        (case 1 then 
            (init_rank)
            (assert (system_status (phase ENV)
                                   (mode diagnosys)
                                   (sequence PROC QGEN DGNSYS)))
            (focus ENV)
        )
        (case 2 then 
             (assert (system_status (phase ENV)
                                    (mode engineering)))
            (run)
        )
        (case 3 then 
            (assert (mode_debug))
            (run)
        )
    ) 
)

(deffunction SYS::show_interface (?file)
    (open ?file data "r")
    (bind ?data (readline data))
    (while (neq ?data EOF)
       (printout t ?data crlf)
       (bind ?data (readline data)))
    (close data)
)


(defrule SYS::init_system
    =>
    (show_interface "interface.gui")
    (select_option_system)
)



