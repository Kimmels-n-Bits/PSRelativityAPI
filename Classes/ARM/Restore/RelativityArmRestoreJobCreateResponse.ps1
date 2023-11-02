class RelativityArmRestoreJobCreateResponse 
{
    [ValidateNotNull()]
    [Int32] $JobID

    RelativityArmRestoreJobCreateResponse([Int32] $jobId)
    {
        $this.JobID = $jobID
    }
}