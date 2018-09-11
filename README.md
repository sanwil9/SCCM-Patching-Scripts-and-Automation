# SCCM-Patching-Scripts-and-Automation
This process is meant to simplify monthly patching. Everyone is running in to the same problems. Full FTE Resources are needed to run the entire patching program due to inaccuracies or inconsistencies in their environment. In this process you will not do "Custom" deployments. The simplest solution is only to provide the server owners with "Options"

These scripts will run on a task scheduler with an account that has full SCCM admin rights. 
It will leverage the built in ADR system in SCCM. 


# How this works

## This is the design of the patching scheme
* Enterprise Patching Occurs every 3rd week Monday through Sunday at midnight
* Each deployment will deploy with a reboot except for one
* The no-reboot deployment will just install patches on the first day leaving the server owner to reboot on demand
* There will need to be 8 total collections built out for this. One for each day of the week and one for no-reboot
* This will require you to leverage Automatic Deployment Rules to work.

## The Scripts
### Patch Tuesday 
* Rename ADR to Current Month.ps1 (Runs on Patch Tuesday with Task Scheduler)
### Week 3 on Task Scheduler
* Deploy Monthly Updates Monday.ps1 (Runs on Week 3)
* Deploy Monthly Updates Tuesday.ps1 (Runs on Week 3)
* Deploy Monthly Updates Wednesday.ps1 (Runs on Week 3)
* Deploy Monthly Updates Thursday.ps1 (Runs on Week 3)
* Deploy Monthly Updates Friday.ps1 (Runs on Week 3)
* Deploy Monthly Updates Saturday.ps1 (Runs on Week 3)
* Deploy Monthly Updates Sunday.ps1 (Runs on Week 3)
* Deploy Monthly Updates ServerOwnerReboot.ps1 (Runs on Week 3)

### Rename ADR to Current Month (How it works)
<br>Then this script will rename it to match your naming conventions 
For this to work correctly you have to leverage Automatic Deployment Rules
The best way automate this is to have an ADR point to an empty collection and have the ADR run against it. VOILA! Your monthly package is created and it didn't deploy to anything. You will want this package to follow a standardized naming scheme. The example we have below is this. We have it broken down by year and the current year will have it's monthly's auto generated.

* All Microsoft Software Updates - 2010
* All Microsoft Software Updates - 2011
* All Microsoft Software Updates - 2012
* All Microsoft Software Updates - 2013
* All Microsoft Software Updates - 2014
* All Microsoft Software Updates - 2015
* All Microsoft Software Updates - 2016
* All Microsoft Software Updates - 2017
* All Microsoft Software Updates - January 2018
* All Microsoft Software Updates - February 2018
* All Microsoft Software Updates - March 2018
* All Microsoft Software Updates - April 2018
* All Microsoft Software Updates - May 2018

The ADR will generate the same name every time with a time stamp

It will look like this: 

<code>All Microsoft Software Updates - Automation 2018-09-11 08:04:47</code>

For this to follow our naming convention standards we have to rename it. 

The script will look for the naming convention of this. 
<br><code> All Microsoft Software Updates - Automation* </code>
<br>
and set it to 
<br><code>EPM - All Microsoft Software Updates - $nameOfMonthVariable</code>
which will be the current month. 

### Deploy Monthly Scripts
This is very straight forward for the design that was requested of me my management opted for simple. I could've just ran a script once starting on week 3 and had all of the deployments going to all of the collection (Which was the most efficient way) but in the project design the managers wanted each day running on task scheduler so if an issue was identified the following days could be disabled one by one. (With an off button of course) This would require one more script. It would require you to name all of your task scheduler tasks with a specific naming scheme but this could be done with powershell as well. 
