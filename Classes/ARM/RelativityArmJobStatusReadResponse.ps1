class RelativityArmJobCurrentJobStage
{
    [String] $Name
    [Int32] $Order
    [Int32] $NumberOfSucceededTasks
    [Int32] $NumberOfFailedTasks
    [Int32] $TotalNumberOfTasks
    [DateTime] $TimeStarted
    [TimeSpan] $TimeElapsed
    [Int32] $PercentComplete

    RelativityArmjobCurrentJobStage(
        [PSCustomObject] $apiResponse
    )
    {
        $this.Name = $apiResponse.CurrentJobStage.Name
        $this.Order = $apiResponse.CurrentJobStage.Order
        $this.NumberOfSucceededTasks = $apiResponse.CurrentJobStage.NumberOfSucceededTasks
        $this.NumberOfFailedTasks = $apiResponse.CurrentJobStage.NumberOfFailedTasks
        $this.TotalNumberOfTasks = $apiResponse.CurrentJobStage.TotalNumberOfTasks

        if ($null -ne $apiResponse.CurrentJobStage.TimeStarted)
        {
            $this.TimeStarted = [DateTime]::Parse($apiResponse.CurrentJobStage.TimeStarted)
        }

        if ($null -ne $apiResponse.CurrentJobStage.TimeElapsed)
        {
            $this.TimeElapsed = [TimeSpan]::Parse($apiResponse.CurrentJobStage.TimeElapsed)
        }

        $this.PercentComplete = $apiResponse.CurrentJobStage.PercentComplete
    }
}

class RelativityArmJobStatusReadResponse
{
    [String] $JobType
    [String] $JobState
    [RelativityArmJobCurrentJobStage] $CurrentJobStage
    [Int32] $TotalNumberOfStages
    [DateTime] $TimeStarted
    [DateTime] $TimeCompleted
    [TimeSpan] $TimeElapsed

    RelativityArmJobStatusReadResponse(
        [PSCustomObject] $apiResponse
    )
    {
        $this.JobType = $apiResponse.JobType
        $this.JobState = $apiResponse.JobState
        $this.CurrentJobStage = [RelativityArmJobCurrentJobStage]::New($apiResponse)
        $this.TotalNumberOfStages = $apiResponse.TotalNumberOfStages

        if ($null -ne $apiResponse.TimeStarted)
        {
            $this.TimeStarted = [DateTime]::Parse($apiResponse.TimeStarted)
        }

        if ($null -ne $apiResponse.TimeCompleted)
        {
            $this.TimeCompleted = [DateTime]::Parse($apiResponse.TimeCompleted)
        }

        if ($null -ne $apiResponse.TimeElapsed)
        {
            $this.TimeElapsed = [TimeSpan]::Parse($apiResponse.TimeElapsed)
        }
    }
}