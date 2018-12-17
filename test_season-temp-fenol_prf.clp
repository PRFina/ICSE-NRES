(watch activations)
(watch rules)

;30 gennaio -> riposo
(assert (current_day (real_to_system_calendar 30)))
(run)
(facts)
(clear)

;21 marzo -> riposo vegetativa foglia g/f, infior g/f, grappolo a
;            vegetativa foglia g/f, infior g/f, grappolo a/g/f
(assert (current_day (real_to_system_calendar 80)))
(run)
(facts)
(clear)

;30 aprile -> riposo vegetativa foglia g/f, infior g/f, grappolo a
;             vegetativa foglia
(assert (current_day (real_to_system_calendar 120)))
(run)
(facts)
(clear)



