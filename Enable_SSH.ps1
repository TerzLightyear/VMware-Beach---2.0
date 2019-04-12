#Abilita SSH su una lista di Host

$HOSTLIST = Get-Content C:\temp\hosts.txt

Connect-VIServer -Server "Vcenter_server_name" 

write-host "Stai procedendo ad attivare SSH per i seguenti host:" $HOSTLIST". Sei sicuro di voler procedere [S/N]?" -ForegroundColor Yellow
	$risposta = read-host
	
	if ($risposta -eq "S"){
			foreach($hooost in $HOSTLIST){
			
			## Attiva l'SSH
			Get-VMHost -Name $hooost| Foreach {Start-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM-SSH"} )}
			
			
			## Disattiva SSH
			#Get-VMHost -Name $hooost| Foreach {Stop-VMHostService -HostService ($_ | Get-VMHostService | Where { $_.Key -eq "TSM-SSH"} ) -Confirm:$false}
		}
	}
	else{
			write-host "Operazione annullata" -ForegroundColor Red
	}

Disconnect-VIServer -Server "Vcenter_server_name"
