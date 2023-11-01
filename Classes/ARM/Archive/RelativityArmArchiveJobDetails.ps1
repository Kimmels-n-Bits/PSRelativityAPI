<#
.SYNOPSIS
This class represents the detailed information of an ARM Archive Job in Relativity.

.DESCRIPTION
The RelativityArmArchiveJobDetails class encapsulates various detailed information about an ARM Archive Job. This includes the date and time of job creation and most recent modification, the user who submitted the job, the current state and priority of the job, and a history of actions taken on the job.

.PARAMETER CreatedOn
Specifies the date and time when the ARM Archive Job was created.

.PARAMETER ModifiedTime
Specifies the date and time of the most recent modification to the ARM Archive Job.

.PARAMETER SubmittedBy
Specifies the username of the individual who submitted the ARM Archive Job.

.PARAMETER State
Specifies the current state of the ARM Archive Job.

.PARAMETER Priority
Specifies the priority of execution for the ARM Archive Job.

.PARAMETER ActionsHistory
Specifies an array of action history objects, each representing a particular action taken on the ARM Archive Job.

.EXAMPLE
$actionsHistory = @(
    [RelativityArmArchiveJobActionHistory]::new([DateTime]::Now.AddHours(-1), "JobCreated", "jsmith"),
    [RelativityArmArchiveJobActionHistory]::new([DateTime]::Now, "JobStarted", "jsmith")
)
$jobDetails = [RelativityArmArchiveJobDetails]::new(
    [DateTime]::Now.AddHours(-2),
    [DateTime]::Now,
    "jsmith",
    "Running",
    "High",
    $actionsHistory
)

.NOTES
The ActionsHistory property provides a history of actions taken on the ARM Archive Job, which can be useful for auditing or troubleshooting purposes.
#>
class RelativityArmArchiveJobDetails
{
    [ValidateNotNull()]
    [DateTime] $CreatedOn
    [ValidateNotNull()]
    [DateTime] $ModifiedTime
    [ValidateNotNullOrEmpty()]
    [String] $SubmittedBy
    [ValidateNotNullOrEmpty()]
    [String] $State
    [ValidateNotNullOrEmpty()]
    [String] $Priority
    [ValidateNotNull()]
    [RelativityArmArchiveJobActionHistory[]] $ActionsHistory

    RelativityArmArchiveJobDetails([DateTime] $createdOn, [DateTime] $modifiedOn, [String] $submittedBy, [String] $state, [String] $priority, [RelativityArmArchiveJobActionHistory[]] $actionsHistory)
    {
        $this.CreatedOn = $createdOn
        $this.ModifiedTime = $modifiedOn
        $this.SubmittedBy = $submittedBy
        $this.State = $state
        $this.Priority = $priority
        $this.ActionsHistory = $actionsHistory
    }
}