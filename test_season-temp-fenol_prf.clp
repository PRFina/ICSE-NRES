(watch activations)
(watch rules)

;-------------------- TEST day > season > temperature > fenological_phase--------------------
;pieno winter 
;(assert (current_day (real_to_system_calendar 20)))
;(run)
;(facts)

;(assert (current_day (real_to_system_calendar 40)))
;(run)
;(facts)

;(assert (current_day (real_to_system_calendar 60)))
;(run)
;(facts)

;(assert (current_day (real_to_system_calendar 80)))
;(run)
;(facts)

;(assert (current_day (real_to_system_calendar 100)))
;(run)
;(facts)

;(assert (current_day (real_to_system_calendar 120)))
;(run)
;(facts)

;(assert (current_day (real_to_system_calendar 140)))
;(run)
;(facts)

;(assert (current_day (real_to_system_calendar 160)))
;(run)
;(facts)

;(assert (current_day (real_to_system_calendar 180)))
;(run)
;(facts)

;(assert (current_day (real_to_system_calendar 200)))
;(run)
;(facts)

;(assert (current_day (real_to_system_calendar 220)))
;(run)
;(facts)

;(assert (current_day (real_to_system_calendar 240)))
;(run)
;(facts)

;(assert (current_day (real_to_system_calendar 260)))
;(run)
;(facts)

(assert (current_day (real_to_system_calendar 280)))
(run)
(facts)

;(assert (current_day (real_to_system_calendar 300)))
;(run)
;(facts)

;(assert (current_day (real_to_system_calendar 320)))
;(run)
;(facts)

;(assert (current_day (real_to_system_calendar 340)))
;(run)
;(facts)

;(assert (current_day (real_to_system_calendar 360)))
;(run)
;(facts)

;(assert (current_day (real_to_system_calendar 1)))
;(run)
;(facts)

;-------------------- TEST day > season > temperature --------------------
;tra winter e spring 28 febbraio OK
;(assert (current_day (real_to_system_calendar 59)))
;(run)
;(facts)

;tra spring e summer 29 maggio OK
;(assert (current_day (real_to_system_calendar 149)))
;(run)
;(facts)

;estate (non piena) 29 giugno OK
;(assert (current_day (real_to_system_calendar 180)))
;(run)
;(facts)

;tra estate e autunno 9 settembre 17 gradi (troppo bassa)
;(assert (current_day (real_to_system_calendar 252)))
;(run)
;(facts)

;autunno quasi pieno 10 novembre
;(assert (current_day (real_to_system_calendar 314)))
;(run)
;(facts)

;tra autunno e inverno 26 novembre 
;(assert (current_day (real_to_system_calendar 330)))
;(run)
;(facts)

;poco inverno 5 gennaio
;(assert (current_day (real_to_system_calendar 5)))
;(run)
;(facts)

;poco inverno 20 gennaio
;(assert (current_day (real_to_system_calendar 20)))
;(run)
;(facts)

;(bind ?index (get_rank_pos funghi 1))
;
;(bind ?name (fact-slot-names ?index))
;
;(neq (fact-slot-value ?index (nth$ 1 ?name) nil)