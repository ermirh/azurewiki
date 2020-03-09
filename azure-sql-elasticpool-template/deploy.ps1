Connect-AzAccount

#select your subscription where going to provision resources
Get-AzSubscription -SubscriptionName '<Subscription_Name>' | Select-AzSubscription

#create a variable for Resource Group (Get-AzResourceGroup)
$resourceGroup = "<Resource_Group>"

#specify local path of the template & parameters file
$templateParam = ".\template.parameters.json"
$template = ".\template.json"

#test the deployment - empty output is ok, working
Test-AzResourceGroupDeployment -ResourceGroupName $resourceGroup -TemplateParameterFile $templateParam -TemplateFile $template

#create an ARM deployment
New-AzResourceGroupDeployment -Name "deploy-SqlePool-080320" -ResourceGroupName $resourceGroup -TemplateFile $template -TemplateParameterFile $templateParam -Force
