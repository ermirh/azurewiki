Connect-AzAccount

Get-AzSubscription -SubscriptionName '<Subscription_Name>' | Select-AzSubscription

#create new resource group - or use already an existing one (Get-AzResourceGroup)#
$resourceGroup = "<Resource_Group_Name>"

#local path of the template & parameters file
$templateParam = ".\azure-appservice-template\azuredeploy.parameters.json"
$template = ".\azure-appservice-template\azuredeploy.json"

#test the deployment - empty output is ok, working#
Test-AzResourceGroupDeployment -ResourceGroupName $resourceGroup -TemplateParameterFile $templateParam -TemplateFile $template

#create an ARM deployment#
New-AzResourceGroupDeployment -Name "deploy-webapp-100320" -ResourceGroupName $resourceGroup -TemplateFile $template -TemplateParameterFile $templateParam -Force