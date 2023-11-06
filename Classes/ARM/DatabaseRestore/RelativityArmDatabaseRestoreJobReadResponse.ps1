class RelativityArmDatabaseRestoreJobReadResponse : RelativityArmDatabaseRestoreJobBase
{
    [Int32] $JobID
    [String] $JobName
    [Int32] $JobExecutionID
    [Guid] $JobExecutionGuid
    [RelativityArmJobDetails] $JobDetails
    [RelativityArmRestoreJobUserMapping[]] $UserMappings
    [RelativityArmRestoreJobGroupMapping[]] $GroupMappings

    RelativityArmDatabaseRestoreJobReadResponse([PSCustomObject] $apiResponse) : base($apiResponse)
    {
        $this.JobID = $apiResponse.JobID
        $this.JobName = $apiResponse.JobName
        $this.JobExecutionID = $apiResponse.JobExecutionID
        $this.JobExecutionGuid = $apiResponse.JobExecutionGuid

        $ActionsHistoryValue = New-Object "System.Collections.Generic.List[RelativityArmJobActionHistory]"

        $apiResponse.JobDetails.ActionsHistory | Foreach-Object {
            $ActionsHistoryValue.Add([RelativityArmJobActionHistory]::New(
                $_.Date,
                $_.Type,
                $_.UserName
            ))
        }

        $JobDetailsValue = [RelativityArmJobDetails]::New(
            $apiResponse.JobDetails.CreatedOn,
            $apiResponse.JobDetails.ModifiedTime,
            $apiResponse.JobDetails.SubmittedBy,
            $apiResponse.JobDetails.State,
            $apiResponse.JobDetails.Priority,
            $ActionsHistoryValue.ToArray()
        )

        $this.JobDetails = $JobDetailsValue

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