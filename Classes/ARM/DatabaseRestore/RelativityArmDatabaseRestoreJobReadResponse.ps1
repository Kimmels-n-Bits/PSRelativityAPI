class RelativityArmDatabaseRestoreJobReadResponse : RelativityArmJobReadResponseBase
{
    [RelativityArmRestoreJobDestinationOptions] $DestinationOptions
    [RelativityArmRestoreJobUserMapping[]] $UserMappings
    [RelativityArmRestoreJobGroupMapping[]] $GroupMappings

    RelativityArmDatabaseRestoreJobReadResponse(
        [PSCustomObject] $apiResponse
    ) : base($apiResponse)
    {
        $this.DestinationOptions = [RelativityArmRestoreJobDestinationOptions]::New(
            $apiResponse.DestinationOptions.DatabaseServerID,
            $apiResponse.DestinationOptions.ResourcePoolID,
            $apiResponse.DestinationOptions.MatterID,
            $apiResponse.DestinationOptions.CacheLocationID,
            $apiResponse.DestinationOptions.FileRepositoryID
        )

        $UserMappingsValue = New-Object "System.Collections.Generic.List[RelativityArmRestoreJobUserMapping]"

        $apiResponse.UserMappings | ForEach-Object {
            $UserMappingsValue.Add([RelativityArmRestoreJobUserMapping]::New(
                    $_.ArchiveUserID,
                    $_.InstanceUserID
                ))
        }

        $this.UserMappings = $UserMappingsValue.ToArray()

        $GroupMappingsValue = New-Object "System.Collections.Generic.List[RelativityArmRestoreJobGroupMapping]"

        $apiResponse.GroupMappings | ForEach-Object {
            $GroupMappingsValue.Add([RelativityArmRestoreJobGroupMapping]::New(
                    $_.ArchiveGroupID,
                    $_.InstanceGroupID
                ))
        }

        $this.GroupMappings = $GroupMappingsValue.ToArray()
    }
}
