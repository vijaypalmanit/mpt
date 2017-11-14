^SPACE::  Winset, Alwaysontop, , A
Return

MButton::
   run SnippingTool.exe 
Sleep,500
Send, !nr
Return

;for quick sql statements
::ssf::SELECT * FROM  limit 10{left 9}

::ssfr::
SendInput ` 
(
SELECT "Crosswalkplanperiod_new","amount (dollars) [USD]","amount (converted)" 
FROM  "recurly_notifications"  
where site_id=1 
and created >='2017-03-1'
and type='successful_payment_notification'
and "successful unique payment notification number (1=yes)"=1
and SuccessfulPaymentNotificationNumberNew = 1
)
Return

::ssfdr::
SendInput `
(
select 
CASE When "SuccessfulPaymentNumber" = 1 Then 'New' Else 'Renewal' END As "New/Renewal",
Case When payment_method_name = 'Amex' Then 'Amex' When payment_method_name = 'ELO' Then 'ELO' Else 'Other' END As payment_method,
"Plan Period First Activated Plan",
count("Plan Period First Activated Plan") as transactions,sum( "captured_amount [USD]") as Revenue
from digitalriver_notifications 
where order_state = 'Paid'
and  "Successful unique payment notification number" = 1
and created >='2017-01-01'
limit 100
)
Return

::ssftr::
SendInput `
(
SELECT sum("Amount_in_dollars (from raw_data)")
FROM  "table_recurly_payments"
where rec_date>='2017-04-11'
and notification_type='successful_payment_notification'
)
Return




::ssfwp::
SendInput `
(
select extract(YEAR from created) as "YEAR", extract(MONTH from created) as "Month",'2for2d' as plan,
sum("transaction_amount/100 [USD]") 
from worldpay_notifications 
where order_state = 'AUTHORISED'
and  "NumberOfAuthorisedPaymentsNew" = 0
and "User's external_plan (first activated plan)" like '%2for2d%'
and  "Successful unique payment notification number (1=yes)" = 1
group by "YEAR", "Month" ,plan
order by "YEAR" asc, "Month" asc,plan asc
 limit 10000 
)
Return


;to run Notepad
#n::Run Notepad

;to change the line

::ccl::1|1`r2|2 `r3|3

:o:e.mail::vijaypalmanit@gmail.com ;no trailing space
Return

::gtind::GET /_cat/indices?pretty
::gtq::
send,GET //_search?filter_path= `r{{}


;change volume using mouse wheel
!WheelUp::Send {Volume_Up}	
!WheelDown::Send {Volume_Down}
Return

Insert::send %clipboard%


~!RButton::
SendInput {LWin down}{Tab}{LWin up}

; Tab::
; SendInput {LWin down}{Tab}{LWin up}

^+t:: ;Control, Shift and T trigger script
StringReplace, clipboard, clipboard,%A_Tab%, `r , All ;replace all tabs with line return
Send,^v   ;send "paste"
Return

;testing ground goes here-----

;^j::
MsgBox Wow!

:*:btw::By the way                         ; Replaces "btw" with "By the way" without needing an EndChar

^/::
Clipbackup := ClipboardAll
Clipboard =
Send ^c
Sleep, 40
Clipboard := "/*" . Clipboard . "*/"
Sleep, 40
Send ^v
Clipboard := Clipbackup
Clipbackup =
Return




^\::
ClipSaved := ClipboardAll   ; Save the entire clipboard to a variable of your choice.

Clipboard= ; clear Clipboard

Send ^x ; cut text to Clipboard

Sleep, 40

StringReplace, Clipboard, Clipboard, `/*, , All

StringReplace, Clipboard, Clipboard, *`/, , All

StringReplace, Clipboard, Clipboard, `/`/, , All

Sleep, 40

Send ^v ; paste new Clipboard

Clipboard := ClipSaved   ; Restore the original clipboard. Note the use of Clipboard (not ClipboardAll).

ClipSaved =   ; Free the memory in case the clipboard was very large.

Return


:*:qq::
SendInput `
(
select type,user_external_id,created,user_id,state,
"user's external_plan (first activated plan)",
plan_code,"plan period","amount (converted)",
successfulpaymentnotificationnumbernew
from recurly_notifications
)

#g::    ; <-- Google Web Search Using Highlighted Text (Win+G)
   Search := 1
   Gosub www.google.com
Return