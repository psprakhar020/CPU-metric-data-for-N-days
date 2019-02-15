<#
#          Script: VM's Average CPU metric for last 90 days                                          
#            Date: Feb 13, 2019                                                                     
#          Author: Prakhar Sharma
#

PREREQUISITE:
PowerShell version: 5
Install following module: Install-Module ImportExcel

DESCRIPTION:
This script is used to get the metric named average CPU for last 90 days for all the VMs provided by input csv. CSV must contain two fields: VM name and 
Resource group name.

INPUT:
1) Path of CSV which contains VM name and Resource groups to which they belong
2) Path where the output needs to be stored.

OUTPUT:
Output of this gives you average CPU utilization of each VM in last 90 days in form of CSV with two fields: Timestamp, Average
#>

############################
#         INPUT            #
############################
$CSVPath =Read-Host -Prompt "Please provide the path of the input csv"
$VMdetails = Import-Csv $CSVPath
$EPath = Read-Host -Prompt "Please provide the path where you want to export the result in format C:\test.csv"



############################
#         Reading CSV      #
############################
foreach($VMdetail in $VMdetails)
{
$Name= $VMdetail.name
$RG= $VMdetail.RG
$vmdetail = Get-AzureRmVM -Name $Name -ResourceGroupName $RG
$RID = $VMdetail.id

#To get all the metric for the VM
#(Get-AzureRmMetricDefinition -ResourceId $Rid).Name



############################
#         LOGIC            #
############################

#Generating percentage CPU data for last three months with interval of 1 hour
$Sdate= Get-Date
$Edate= $Sdate.AddDays(-90)
$AvgCPU= (Get-AzureRmMetric -ResourceId $Rid -MetricNames "Percentage CPU" -StartTime $Edate -EndTime $Sdate -DetailedOutput -TimeGrain 01:00:00).Data | Select-Object Timestamp, Average



#####################################
# For Exporting the result into CSV #                    
#####################################
$AvgCPU | Export-Excel -WorksheetName $Name -Path $EPath

}
