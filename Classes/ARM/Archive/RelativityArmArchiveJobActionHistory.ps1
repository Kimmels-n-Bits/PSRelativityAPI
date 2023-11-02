<#
.SYNOPSIS
This class represents the action history of an ARM Archive Job in Relativity.

.DESCRIPTION
The RelativityArmArchiveJobActionHistory class encapsulates details about a particular action taken on an ARM Archive Job. This includes the date and time the action took place, the type of action, and the username of the individual who performed the action.

.PARAMETER Date
Specifies the date and time when the action was performed.

.PARAMETER Type
Specifies the type of action performed on the ARM Archive Job.

.PARAMETER UserName
Specifies the username of the individual who performed the action.

.EXAMPLE
$actionHistory = [RelativityArmArchiveJobActionHistory]::new(
    [DateTime]::Now,
    "JobCreated",
    "jsmith"
)

.NOTES
The ActionsHistory property of the RelativityArmArchiveJobDetails class will contain an array of these action history objects, providing a history of actions taken on the ARM Archive Job.
#>
class RelativityArmArchiveJobActionHistory
{
    [ValidateNotNull()]
    [DateTime] $Date
    [ValidateNotNullOrEmpty()]
    [String] $Type
    [ValidateNotNullOrEmpty()]
    [String] $UserName

    RelativityArmArchiveJobActionHistory([DateTime] $date, [String] $type, [String] $userName)
    {
        $this.Date = $date
        $this.Type = $type
        $this.UserName = $userName
    }
}