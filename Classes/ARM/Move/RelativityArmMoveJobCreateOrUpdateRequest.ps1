class RelativityArmMoveJobOptions : RelativityArmJobOptionsBase
{
    [Int32] $SourceWorkspaceID
    [RelativityArmMoveJobFileOptions] $FileOptions
    [RelativityArmMoveJobDatabaseOptions] $DatabaseOptions
    [RelativityArmJobDestinationOptions] $DestinationOptions

    RelativityArmMoveJobOptions(
        [Int32] $sourceWorkspaceID,
        [String] $jobPriority,
        [String] $scheduledStartTime,
        [RelativityArmMoveJobFileOptions] $fileOptions,
        [RelativityArmMoveJobDatabaseOptions] $databaseOptions,
        [RelativityArmJobDestinationOptions] $destinationOptions,
        [RelativityArmJobNotificationOptions] $notificationOptions,
        [Boolean] $uiJobActionsLocked
    ) : base(
        $jobPriority,
        $scheduledStartTime,
        $notificationOptions,
        $uiJobActionsLocked
    )
    {
        $this.SourceWorkspaceID = $sourceWorkspaceID
        $this.FileOptions = $fileOptions
        $this.DatabaseOptions = $databaseOptions
        $this.DestinationOptions = $destinationOptions
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = ([RelativityArmJobOptionsBase] $this).ToHashTable()

        $ReturnValue.Add("SourceWorkspaceID", $this.SourceWorkspaceID)
        $ReturnValue.Add("FileOptions", $this.FileOptions.ToHashTable())
        $ReturnValue.Add("DatabaseOptions", $this.DatabaseOptions.ToHashTable())
        $ReturnValue.Add("DestinationOptions", $this.DestinationOptions.ToHashTable())

        return $ReturnValue
    }
}

class RelativityArmMoveJobCreateOrUpdateRequest
{
    [RelativityArmMoveJobOptions] $Request

    RelativityArmMoveJobCreateOrUpdateRequest(
        [RelativityArmMoveJobOptions] $request
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