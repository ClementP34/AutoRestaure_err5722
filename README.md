Attention, ce script n'a pas encore été testé. J'ai un bug pour l'execution à distance.

# AutoRestaure_err5722
Script Powershell pour l'erreur Netlogon numero 5722

Ce script permet de reparer de reinitialiser le mot de passe machine d'un ordi sur un domaine Microsoft.
Ca corrige automatiquement l'erreur : "La relation d’approbation entre cette station de travail et le domaine principal a échoué".

Les logs sont dans le journal "System" avec en source "AutoRestaure_err5722"

# Installation

1. Il faut aller dans l'Observateur d'événement (eventvwr.msc)
2. Trouver l'erreur Source "NETLOGON" Evenement "5722"
3. Clic Droit sur l'erreur puis choisir "Joindre une tâche à cet événement"
4. Choisir de lancer ce script (AutoRestaure_err5722.ps1)
