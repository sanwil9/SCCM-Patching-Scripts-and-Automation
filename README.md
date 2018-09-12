# Design Overview
#### Purpose:
Automating the overhead that comes with Monthly Patching in SCCM.
#### Overhead to Automate:
* Packaging and downloading monthly updates (Can be done wtih default ADR pointing to an empty collection)
* Defining, Creating and Maintaining Naming Standards for Software Update Groups (ADR & Scripting)
* Deploying Monthly Updates to collections of your choosing (Scripting & Task Scheduler)
## Special Requests
* Simple Design that an admin can go in and troubleshoot
* On and Off "Button" (Tasks in task scheduler will have to follow a naming scheme for the script to disable/enable) 
* I'm being asked to do seperate scripts per day to prevent delayed client communication for cancellations
## Production 
* Enterprise Patching Occurs every 3rd week Monday through Sunday at midnight
* Each deployment will deploy with a reboot except for one
* The no-reboot deployment will just install patches on the first day leaving the server owner to reboot on demand
* There will need to be 8 total collections built out for this. One for each day of the week and one for no-reboot
* This will require you to leverage Automatic Deployment Rules to work.
## Pilots
* Pilot Patching Occurs the same week as patch Tuesday
* It will occur on Thursday, Friday, Saturday, and Sunday
* You will review metrics with reports before pushing to production
## The Scripts
* Rename ADR to Current Month.ps1 (Runs on Patch Tuesday with Task Scheduler)
* Deploy Monthly Updates Monday.ps1 (Runs on Week 3)
* Deploy Monthly Updates Tuesday.ps1 (Runs on Week 3)
* Deploy Monthly Updates Wednesday.ps1 (Runs on Week 3)
* Deploy Monthly Updates Thursday.ps1 (Runs on Week 3)
* Deploy Monthly Updates Friday.ps1 (Runs on Week 3)
* Deploy Monthly Updates Saturday.ps1 (Runs on Week 3)
* Deploy Monthly Updates Sunday.ps1 (Runs on Week 3)
* Deploy Monthly Updates ServerOwnerReboot.ps1 (Runs on Week 3)
# Engineering Overview
For this to work correctly you have to leverage Automatic Deployment Rules
The best way automate this is to have an ADR point to an empty collection and have the ADR run against it. VOILA! Your monthly package is created, downloaded and it didn't deploy to anything. The package will download whatever you defined in your ADR. You will want this package to follow a standardized naming scheme. The example we have below is this. We have it broken down by year and the current year will have it's monthly's auto generated.

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
and rename it to 
<br><code>EPM - All Microsoft Software Updates - $nameOfMonthVariable</code>
which will be the current month. 

### Deploy Monthly Scripts
This is very straight forward for the design that was requested of me my management opted for simple. I could've just ran a script once starting on week 3 and had all of the deployments going to all of the collection (Which was the most efficient way) but in the project design the managers wanted each day running on task scheduler so if an issue was identified the following days could be disabled one by one. (With an off button of course) This would require one more script. It would require you to name all of your task scheduler tasks with a specific naming scheme but this could be done with powershell as well. 


#End Results
By the end of this, the next step would be to have reports generated over the deployments. 

