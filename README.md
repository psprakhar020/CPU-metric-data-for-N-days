# Get CPU metric data of N days as per desired input from user for all the VMs in an azure subscription.

## PREREQUISITE:
1) PowerShell version: 5
2) Install following module: Install-Module ImportExcel

## DESCRIPTION:
This script is used to get the metric named average CPU for last 90 days for all the VMs provided by input csv. CSV must contain two fields: VM name and 
Resource group name.

## INPUT:
1) Path of CSV which contains VM name and Resource groups to which they belong
2) Path where the output needs to be stored.

## OUTPUT:
Output of this gives you average CPU utilization of each VM in last 90 days in form of CSV with two fields: Timestamp, Average
