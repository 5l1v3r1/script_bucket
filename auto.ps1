$triger = New-JobTrigger -AtStartup
Register-ScheduledJob -Name ssp -FilePath "C:\WINDOWS\ssp.exe -s 1.1.1.1 -p 111 -l 1000 -k '132424'" -Trigger $triger