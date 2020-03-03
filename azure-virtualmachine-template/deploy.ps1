Connect-AzAccount

Get-AzSubscription -SubscriptionName '<sub_name>' | Select-AzSubscription

#create new resource group - or use already an existing one (Get-AzResourceGroup)#
$resourceGroup = "wikirg0203"

#enter username & password for VM credentials
$credentials = Get-Credential
$adminUser = $credentials.UserName
$adminPassword = $credentials.Password

#local path of the template & parameters file
$templateParam = "C:\Users\ehoxhaj\Desktop\Box Sync\azurewiki\azure-virtualmachine-template\template.parameters.json"
$template = "C:\Users\ehoxhaj\Desktop\Box Sync\azurewiki\azure-virtualmachine-template\template.json"

#test the deployment - empty output is ok, working#
Test-AzResourceGroupDeployment -ResourceGroupName $resourceGroup -TemplateParameterFile $templateParam -TemplateFile $template -adminUsername $adminUser -adminPassword $adminPassword

#create an ARM deployment#
New-AzResourceGroupDeployment -Name "deploy-vm-030320" -ResourceGroupName $resourceGroup -TemplateFile $template -TemplateParameterFile $templateParam -adminUsername $adminUser -adminPassword $adminPassword -Force