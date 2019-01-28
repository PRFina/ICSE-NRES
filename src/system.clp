;; system_status facts are the main message passing way
;; of communication between modules (sub-agents)
;; note that only a single instance of this fact should 
;; present at runtime, act like singleton instance.
(deftemplate SYS::system_status (slot phase)
                                (slot mode)
                                (multislot sequence))

;; every fact damaged_struct represents which (slot symptoms) 
;; and how many (slot symtpoms_freq) desease symtpoms (in the WM)
;; of a specified category (slot category) are related
;; to a given grapevine structure (slot structure).
;; This deftemplate is the RAD cycle and ranking backbone structure                            
(deftemplate SYS::damaged_struct (slot category)
                            (slot structure)
                            (slot symptoms_freq)
                            (multislot symptoms)
                            (slot rank)
)

;; coordinates the RAD cycle execution flow,
;; each phase is matched and append to the tail of
;; sequence slot
(defrule SYS::next_phase
    ?f <- (system_status (phase ?p)
                         (mode ?m)
                         (sequence ?next $?tail))
    =>
    (focus ?next)
    (modify ?f (phase ?next) (mode ?m) (sequence ?tail ?next))
)

;; enumerates every pair of categories and structures, asserting
;; damage_struct facts for initial ranking calculation.
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

;; read the user input, assert the system_status facts related
;; to the choice, run the environment
(deffunction SYS::select_option_system()
    (bind ?answer (read))
    (while (not (member$ ?answer (create$ 1 2 3)))
        (printout t "Scegli un opzione valida!" crlf)
        (bind ?answer (read))
    )
    (switch ?answer
        
        (case 1 then 
            (init_rank)
            (assert (system_status (phase ENV)
                                   (mode diagnosys)
                                   (sequence PROC QGEN DGNSYS CLEAN)))
            (focus ENV)
        )
        (case 2 then 
            (assert (system_status (phase LEARN)
                                   (mode engineering)))
            (focus LEARN)
            (run)
        )
        (case 3 then
            (watch focus)
            (watch rules)
            (watch activations)
            (watch facts)
            (init_rank)
            (assert (system_status (phase ENV)
                                   (mode diagnosys)
                                   (sequence PROC QGEN DGNSYS CLEAN)))
            (focus ENV)
            (run)
        )
    ) 
)

;; read the text-interface from ?file and
;; print it to the stdout
(deffunction SYS::show_interface (?file)
    (open ?file data "r")
    (bind ?data (readline data))
    (while (neq ?data EOF)
       (printout t ?data crlf)
       (bind ?data (readline data)))
    (close data)
)

;; restart the system showing interface and reloading
;; learned rules and learned facts
(defrule SYS::restart_system
    ?f <- (system_status (phase START)
                         (mode diagnosys|engineering))
    =>
    (load* "learned_rules.clp")
    (load* "learned_deffacts.clp")
    (reset)
    (retract ?f)
    (show_interface "interface.gui")
    (select_option_system)
)

;; start the system showing interface
(defrule SYS::init_system
    =>
    (reset)
    (show_interface "interface.gui")
    (select_option_system)
)
