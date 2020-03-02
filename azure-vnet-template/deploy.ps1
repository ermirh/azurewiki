Connect-AzAccount

Get-AzSubscription -SubscriptionName '<sub_name>' | Select-AzSubscription

#create new resource group - or use already an existing one (Get-AzResourceGroup)#
$resourceGroup = ""

#local path of the template & parameters file
$templateParam = "C:\Users\***\Desktop\Box Sync\azurewiki\azure-vnet-template\template.parameters.json"
$template = "C:\Users\***\Desktop\Box Sync\azurewiki\azure-vnet-template\template.json"

#test the deployment - empty output is ok, working#
Test-AzResourceGroupDeployment -ResourceGroupName $resourceGroup -TemplateParameterFile $templateParam -TemplateFile $template

#create an ARM deployment#
New-AzResourceGroupDeployment -Name "deploy-vnet-020320" -ResourceGroupName $resourceGroup -TemplateFile $template -TemplateParameterFile $templateParam -Force