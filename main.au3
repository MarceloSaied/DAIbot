#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=marvin_robot.ico
#AutoIt3Wrapper_Outfile_x64=DAIbot.exe
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <Misc.au3>
If _Singleton(@ScriptName, 1) = 0 Then ; allow only one instance
	MsgBox(0, "Warning", "An occurence of " & @ScriptName & " is already running")
	Exit
EndIf

#include <FileIncludes.au3>
#include <includes.au3>
#include <variables.au3>
#include <functions.au3>
#include <sendmail.au3>
$beginAlert1 = TimerInit()
$beginAlert2 = TimerInit()
global $flag=0

while 1
	$beginGetUpdates = TimerInit()
	If _timeBetween(@HOUR & ':' & @MIN , $StartTime, $EndTime)  then
		$DAIUSDSELL = IniRead($fileini,"prices","DAI-USD-SELL-GE","0" )
		$DAIARSBUY = IniRead($fileini,"prices","DAI-ARS-BUY-LE","0" )
		$everyminutes=IniRead($fileini,"Alerts","everyminutes","10")
		$everyMsec=$everyminutes*60*1000
		$daijson=HttpGetJson($apiurl)
;~ 		ConsoleWrite('@@ $daijson = ' & $daijson & @crlf )
		$daiarsprice=getdaiarsbuy($daijson)
		$daiusdprice=getdaiusdsell($daijson)
		if $DAIUSDSELL <= $daiusdprice then $flag=1
		if $DAIUSDSELL <= $daiusdprice and $everyMsec < TimerDiff($beginAlert1) or $flag=1 Then
			$Subject= _Now() & "  DAI/USD alert ="& $daiusdprice & "  >= " &  $DAIUSDSELL
			ConsoleWrite('++ $Subject = ' & $Subject & @crlf )
			if $mailenabled = "si" then _Sendmail()
;~ 			MsgBox(0, "Warning " , $Subject)
			Popup ($Subject)
			$beginAlert1 = TimerInit()
			$flag=0
		endif
		if $DAIARSBUY >= $daiarsprice  then $flag=1
		if $DAIARSBUY >= $daiarsprice and TimerDiff($beginAlert2) > $everyMsec or  $flag=1 Then
			$Subject= _Now() & "  DAI/ARS alert ="& $daiarsprice & "  >= " &  $DAIARSBUY
			ConsoleWrite('!! $Subject = ' & $Subject & @crlf )
			if $mailenabled = "si" then _Sendmail()
;~ 			MsgBox(0, "Warning " , $Subject)
			Popup ($Subject)
			$beginAlert2 = TimerInit()
			$flag=0
		endif
		$GUTmsec=$GetUpdateTimemsec*$ahora
	Else
		$segundosGUT=10
		$GUTmsec=$segundosGUT*1000
	endif
	ConsoleWrite('Sleeping  ' &Sec2Time($GUTmsec/1000) & @crlf )
	while $GUTmsec > TimerDiff($beginGetUpdates)
		Sleep(100)
	wend
wend
