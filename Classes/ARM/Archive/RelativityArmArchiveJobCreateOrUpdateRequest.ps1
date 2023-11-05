class RelativityArmArchiveJobOptions : RelativityArmArchiveJobBase
{
    [String] $ArchiveDirectory
    [String] $JobPriority
    [Boolean] $UseDefaultArchiveDirectory

    RelativityArmArchiveJobOptions(
        [Int32] $workspaceID,
        [String] $jobPriority,
        [String] $archiveDirectory,
        [String] $scheduledStartTime,
        [RelativityArmArchiveJobMigratorOptions] $migratorOptions,
        [RelativityArmArchiveJobFileOptions] $fileOptions,
        [RelativityArmArchiveJobProcessingOptions] $processingOptions,
        [RelativityArmArchiveJobExtendedWorkspaceDataOptions] $extendedWorkspaceDataOptions,
        [RelativityArmJobNotificationOptions] $notificationOptions,
        [Boolean] $uiJobActionsLocked,
        [Boolean] $useDefaultArchiveDirectory
    ) : base(
        $workspaceID,
        $scheduledStartTime,
        $migratorOptions,
        $fileOptions,
        $processingOptions,
        $extendedWorkspaceDataOptions,
        $notificationOptions,
        $uiJobActionsLocked
    )
    {
        $this.JobPriority = $jobPriority
        $this.ArchiveDirectory = $archiveDirectory
        $this.UseDefaultArchiveDirectory = $useDefaultArchiveDirectory
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = ([RelativityArmArchiveJobBase] $this).ToHashTable()

        $ReturnValue.Add("ArchiveDirectory", $this.ArchiveDirectory)
        $ReturnValue.Add("JobPriority", $this.JobPriority)
        $ReturnValue.Add("UseDefaultArchiveDirectory", $this.UseDefaultArchiveDirectory)

        return $ReturnValue
    }
}

class RelativityArmArchiveJobCreateOrUpdateRequest
{
    [RelativityArmArchiveJobOptions] $Request

    RelativityArmArchiveJobCreateOrUpdateRequest(
        [RelativityArmArchiveJobOptions] $request
    )
    {
        $this.Request = $request
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}
        
        $ReturnValue.Add("Request", $this.Request.ToHashTable())

        return $ReturnValue
    }
}