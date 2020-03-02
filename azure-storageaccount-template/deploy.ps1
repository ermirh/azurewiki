Connect-AzAccount

Get-AzSubscription -SubscriptionName '<sub_name>' | Select-AzSubscription

#create new resource group - or use already an existing one (Get-AzResourceGroup)#
$resourceGroup = "azurewiki-rg-001"
$templateParam = "C:\Users\***\Desktop\Box Sync\azurewiki\azure-storageaccount-template\template.parameters.json"
$template = "C:\Users\***\Desktop\Box Sync\azurewiki\azure-storageaccount-template\template.json"

#test the deployment - empty output is ok, working#
Test-AzResourceGroupDeployment -ResourceGroupName $resourceGroup -TemplateParameterFile $templateParam -TemplateFile $template

#create an ARM deployment#
New-AzResourceGroupDeployment -Name "deploy-sa-010320" -ResourceGroupName $resourceGroup -TemplateFile $template -TemplateParameterFile $templateParam -Force