Connect-AzAccount

Get-AzSubscription -SubscriptionName '<Subscription_Name>' | Select-AzSubscription

#create new resource group - or use already an existing one (Get-AzResourceGroup)#
$resourceGroup = "<Resource_Group_Name>"
$templateParam = ".\azure-storageaccount-template\template.parameters.json"
$template = ".\azure-storageaccount-template\template.json"

#test the deployment - empty output is ok, working#
Test-AzResourceGroupDeployment -ResourceGroupName $resourceGroup -TemplateParameterFile $templateParam -TemplateFile $template

#create an ARM deployment#
New-AzResourceGroupDeployment -Name "deploy-sa-010320" -ResourceGroupName $resourceGroup -TemplateFile $template -TemplateParameterFile $templateParam -Force