(defrule DGNSYS::ss 

?f <- (system_status (mode diagnosys))
(oav(object tralcio)
(attribute secchezza)
(value tantisima))

=>
(diagnosys_completed "ss" ?f)
)

