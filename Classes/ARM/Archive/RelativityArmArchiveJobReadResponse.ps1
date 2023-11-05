class RelativityArmArchiveJobReadResponse : RelativityArmArchiveJobBase
{
    [Int32] $JobID
    [String] $JobName
    [Int32] $JobExecutionID
    [Guid] $JobExecutionGuid
    [String] $ArchivePath
    [RelativityArmJobDetails] $JobDetails

    RelativityArmArchiveJobReadResponse([PSCustomObject] $apiResponse) : base($apiResponse)
    {
        $this.JobID = $apiResponse.jobID
        $this.JobName = $apiResponse.jobName
        $this.JobExecutionID = $apiResponse.jobExecutionID
        $this.JobExecutionGuid = $apiResponse.jobExecutionGuid
        $this.ArchivePath = $apiResponse.archivePath

        $ActionsHistoryValue = New-Object "System.Collections.Generic.List[RelativityArmJobActionHistory]"

        $apiResponse.JobDetails.ActionsHistory | ForEach-Object {
            $ActionsHistoryValue.Add([RelativityArmJobActionHistory]::New(
                $_.Date,
                $_.Type,
                $_.UserName))
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
    }
}