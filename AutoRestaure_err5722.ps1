$event = Get-EventLog -LogName "System" -source "NETLOGON" -InstanceId 5722 -EntryType Error -Newest 1
$PcProbleme = $event.ReplacementStrings.Get(0)
$ServerDC = $event.MachineName

Invoke-Command -ComputerName $PcProbleme -ScriptBlock {Reset-ComputerMachinePassword -Server $ServerDC}
