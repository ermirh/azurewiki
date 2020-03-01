Connect-AzAccount

Get-AzSubscription -SubscriptionName '<sub_name>' | Select-AzSubscription

#securely enter password and store it - to pass to deployment#
$credential = Get-Credential
$secretValue = $credential.Password

#create new resource group - or use already an existing one (Get-AzResourceGroup)#
$rg = New-AzResourceGroup -Name 'azurewiki-rg-001' -Location 'westeurope'

#create an ARM deployment#
New-AzResourceGroupDeployment -Name "deploy-keyvault-010320" -ResourceGroupName $rg.ResourceGroupName -TemplateParameterFile .\azure-keyvault-template\template.parameters.json -TemplateFile .\azure-keyvault-template\template.json -secretValue $secretValue