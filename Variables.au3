
global $WorkingFolder=@ScriptDir
global $ahora=1
$fileini="config.ini"
global $StartTime=IniRead($fileini,"Times","StartTimeBotHH:MM","00:00")
global $EndTime=IniRead($fileini,"Times","EndTimeBotHH:MM","23:59")
global $GetUpdateTimeSec=IniRead($fileini,"Times","BotUpdateTimeSec","10")
ConsoleWrite('//  GetUpdates every Sec ' & Sec2Time($GetUpdateTimeSec) & @crlf )
global $GetUpdateTimeMsec=$GetUpdateTimeSec*1000
global $mailenabled = IniRead($fileini, "Mail", "enabled", "No")



global $SmtpServer = IniRead($fileini,"mail","SmtpServer","smtp.gmail.com" ); address for the smtp-server to use - REQUIRED
global $FromName = IniRead($fileini,"mail","FromName","" ); name from who the email was sent
global $FromAddress = IniRead($fileini,"mail","FromAddress","" ); address from where the mail should come
global $ToAddress = IniRead($fileini,"mail","ToAddress","" ) ; destination address of the email - REQUIRED
global $Subject = "testing" ; subject from the email - can be anything you want it to be
global $Body = "test" ; the messagebody from the mail - can be left blank but then you get a blank mail
global $Username = IniRead($fileini,"mail","Username","" ); username for the account used from where the mail gets sent - REQUIRED
global $Password = IniRead($fileini,"mail","Password","" ) ; password for the account used from where the mail gets sent - REQUIRED
global $IPPort = IniRead($fileini,"mail","IPPort","465" ); GMAIL port used for sending the mail
global $SSL = True ; GMAIL enables/disables secure socket layer sending - set to True if using httpS

global $AttachFiles=""
global $CcAddress=""
global $BccAddress=""
global $Importance="Normal"

ConsoleWrite('@@$Password = ' & $Password & @crlf )


$apiurl="https://be.buenbit.com/api/market/tickers/"
;~ ConsoleWrite('//$SmtpServer ' & $SmtpServer& @crlf )

global $flagalert=0