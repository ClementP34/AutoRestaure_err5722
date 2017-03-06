#Trouve la derniere entrée pour l'erreur Netlogon 5722
$event = Get-EventLog -LogName "System" -source "NETLOGON" -InstanceId 5722 -EntryType Error -Newest 1
#Recupération de l'ordinateur impacté
$PcProbleme = $event.ReplacementStrings.Get(0)
#Recuperation du serveur AD
$ServerDC = $event.MachineName

#Lance la commande de reinitialisation du mot de passe machine a distance sur la machine impacté.
Invoke-Command -ComputerName $PcProbleme -ScriptBlock {Reset-ComputerMachinePassword -Server $ServerDC}
