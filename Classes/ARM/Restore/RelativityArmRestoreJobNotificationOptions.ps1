class RelativityArmRestoreJobNotificationOptions
{
    [ValidateNotNull()]
    [Boolean] $NotifyJobCreator
    [ValidateNotNull()]
    [Boolean] $NotifyJobExecutor

    RelativityArmRestoreJobNotificationOptions([Boolean] $notifyJobCreator, [Boolean] $notifyJobExecutor)
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

