<#
.SYNOPSIS
Represents notification options for an ARM archive job.

.DESCRIPTION
This class defines options related to the sending of email notifications upon various events in the job lifecycle.

.PARAMETER NotifyJobCreator
Indicates if email notifications will be sent to the job creator.

.PARAMETER NotifyJobExecutor
Indicates if email notifications will be sent to the job executor.
#>
class RelativityArmArchiveJobNotificationOptions
{
    [ValidateNotNull()]
    [Boolean] $NotifyJobCreator
    [ValidateNotNull()]
    [Boolean] $NotifyJobExecutor

    RelativityArmArchiveJobNotificationOptions([Boolean] $notifyJobCreator, [Boolean] $notifyJobExecutor)
    {
        $this.NotifyJobCreator = $notifyJobCreator
        $this.NotifyJobExecutor = $notifyJobExecutor
    }

    [Hashtable] ToHashTable()
    {
        return @{
            NotifyJobCreator = $this.NotifyJobCreator
            NotifyJobExecutor = $this.NotifyJobExecutor
        }
    }
}