#Trouve la derniere entrée pour l'erreur Netlogon 5722
$event = Get-EventLog -LogName "System" -source "NETLOGON" -InstanceId 5722 -EntryType Error -Newest 1
#Recupération de l'ordinateur impacté
$NamePcProbleme = $event.ReplacementStrings.Get(0)
#Recuperation du serveur AD
$NameDC = $event.MachineName.Substring(0,$event.MachineName.IndexOf("."))
#Recuperation Domaine
$NameDomaine = $event.MachineName.Substring($event.MachineName.IndexOf(".")+1,$event.MachineName.Length-$event.MachineName.IndexOf(".")-1)

#Lance la commande de reinitialisation du mot de passe machine a distance sur la machine impacté.
Invoke-Command -ComputerName $NamePcProbleme -ScriptBlock {Reset-ComputerMachinePassword -Server $NameDC}
