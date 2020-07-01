#region time
	Func  Sec2Time($nr_sec)
		$sec2time_hour = Int($nr_sec / 3600)
		$sec2time_min = Int(($nr_sec - $sec2time_hour * 3600) / 60)
		$sec2time_sec = $nr_sec - $sec2time_hour * 3600 - $sec2time_min * 60
		Return StringFormat('%02d:%02d:%02d', $sec2time_hour, $sec2time_min, $sec2time_sec)
	EndFunc   ;==>Sec2Time
	Func _GetUnixTime($sDate = 0);Date Format: 2013/01/01 00:00:00 ~ Year/Mo/Da Hr:Mi:Se
		Local $aSysTimeInfo = _Date_Time_GetTimeZoneInformation()
		Local $utcTime = ""
		If Not $sDate Then $sDate = _NowCalc()
		If Int(StringLeft($sDate, 4)) < 1970 Then Return ""
		If $aSysTimeInfo[0] = 2 Then
			$utcTime = _DateAdd('n', $aSysTimeInfo[1] + $aSysTimeInfo[7], $sDate)
		Else
			$utcTime = _DateAdd('n', $aSysTimeInfo[1], $sDate)
		EndIf
		Return _DateDiff('s', "1970/01/01 00:00:00", $utcTime)
	EndFunc   ;==>_GetUnixTime
	Func _GetDateFromUnix ($nPosix)
   Local $nYear = 1970, $nMon = 1, $nDay = 1, $nHour = 00, $nMin = 00, $nSec = 00, $aNumDays = StringSplit ("31,28,31,30,31,30,31,31,30,31,30,31", ",")
   While 1
      If (Mod ($nYear + 1, 400) = 0) Or (Mod ($nYear + 1, 4) = 0 And Mod ($nYear + 1, 100) <> 0) Then; is leap year
         If $nPosix < 31536000 + 86400 Then ExitLoop
         $nPosix -= 31536000 + 86400
         $nYear += 1
      Else
         If $nPosix < 31536000 Then ExitLoop
         $nPosix -= 31536000
         $nYear += 1
      EndIf
   WEnd
   While $nPosix > 86400
      $nPosix -= 86400
      $nDay += 1
   WEnd
   While $nPosix > 3600
      $nPosix -= 3600
      $nHour += 1
   WEnd
   While $nPosix > 60
      $nPosix -= 60
      $nMin += 1
   WEnd
   $nSec = $nPosix
   For $i = 1 to 12
      If $nDay < $aNumDays[$i] Then ExitLoop
      $nDay -= $aNumDays[$i]
      $nMon += 1
   Next
   Return $nDay & "/" & $nMon & "/" & $nYear & " " & $nHour & ":" & $nMin & ":" & $nSec
EndFunc; ==> _GetDateFromUnix
Func _timeBetween($cTime, $sTime, $eTime)
	 If Not _DateIsValid('2000/01/01 ' & $cTime) Then Return -1
	 If Not _DateIsValid('2000/01/01 ' & $sTime) Then Return -2
	 If Not _DateIsValid('2000/01/01 ' & $eTime) Then Return -3
	 If _DateDiff('s', '2000/01/01 ' & $cTime & ':00', '2000/01/01 ' & $sTime & ':00') < 0 And _
		 _DateDiff('s', '2000/01/01 ' & $cTime & ':00', '2000/01/01 ' & $eTime & ':00') > 0 Then
		  Return 1
	 Else
		  Return 0
	 EndIf
EndFunc  ; ==>_timeBetween
#endregion
Func getdaiusdsell($s)
     $aArray=StringRegExp ( $s,'dai","purchase_price":"(.*?)","selling_price',3)
;~ 	 ConsoleWrite('@@$aArray = ' & $aArray[1] & @crlf )
	 return $aArray[1]
EndFunc

Func getdaiarsbuy($s)
     $aArray=StringRegExp ( $s,'"selling_price":"(.*?)","market_identifier"',3)
;~ 	 ConsoleWrite('@@$aArray = ' & $aArray[0] & @crlf )
	 return $aArray[0]
EndFunc

Func Popup ($mensaje)
	Opt("GUICoordMode", 2)
	Opt("GUIResizeMode", 1)
	Opt("GUIOnEventMode", 1)
    $mainwindow = GUICreate ( $mensaje , 450, 100)
    GUICtrlCreateLabel ( $mensaje, 30, 30,400 )
	GUICtrlSetColor(-1, $COLOR_RED)
	GUICtrlSetFont(-1, 12)
	GUISetOnEvent($GUI_EVENT_CLOSE, "OKButton")
    GUISetState ( @SW_SHOW )
    global $flagalert=0
    While $flagalert=0
		ConsoleWrite('@@(' & @ScriptName & '-' & @ScriptLineNumber & ') : $flagalert = ' & $flagalert & @crlf )
        SoundPlay ( "wow.wav", 0 )
		Sleep(3000)
    WEnd
	GUISetState ( @SW_HIDE )
EndFunc
Func OKButton()
	global $flagalert=1
EndFunc   ;==>OKPressed
