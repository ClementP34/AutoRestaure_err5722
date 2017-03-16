#Creation du journal d'evenement
#Si le journal n'existe pas, on le crée
if (![System.Diagnostics.EventLog]::SourceExists("Autorestaure_err5722")) {
New-EventLog -LogName "System" -Source "AutoRestaure_err5722"
} 

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

#Gestion de l'erreur pour le journal d'événement
if ($Error) {
Write-EventLog -LogName System -EventId 10 -Message "La correction à echoué. Erreur Rencontré : $Error" -EntryType Error -Source AutoRestaure_err5722 -Category ""
}
else {
Write-EventLog -LogName System -EventId 1 -Message "Execution Réussi" -EntryType Information -Source AutoRestaure_err5722
}
