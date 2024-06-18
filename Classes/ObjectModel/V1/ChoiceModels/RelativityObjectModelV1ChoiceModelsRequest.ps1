class RelativityObjectModelV1ChoiceModelsRequest
{
    <# TODO
        .SYNOPSIS
           Represents a DTO used as a request for creating or updating a user.


        .PARAMETER Color
            the highlight color for the choice.

        .PARAMETER Field
            identifiers for the field to associated with the new choice. 

        .PARAMETER Keywords
            No Description

        .PARAMETER Name
            a string representing the user-friendly name of the choice.

        .PARAMETER Notes
            No Description

        .PARAMETER Order
            an integer used to determine order in which multiple choices are listed in UI. Lower values are listed first.

        .PARAMETER Parent
            No Description

        .PARAMETER RelativityApplications
            No Description. NOT IMPLEMENTED

        .PARAMETER Shortcut
            No Description. NOT IMPLEMENTED

    #>
    [Int32] $Color 
    [RelativitySharedV1ModelsObjectIdentifier] $Field 
    [String] $Keywords 
    [String] $Name 
    [String] $Notes 
    [Int32] $Order 
    [RelativitySharedV1ModelsObjectIdentifier] $Parent 
    [Collections.Generic.List[RelativitySharedV1ModelsObjectIdentifier]] $RelativityApplications 
    [RelativityObjectModelV1SharedModelsShortcut] $Shortcut
    
    RelativityObjectModelV1ChoiceModelsRequest()
    {

    }

    RelativityObjectModelV1ChoiceModelsRequest(
        [Int32] $Color,
        [Nullable[Int32]] $FieldID,
        [Collections.Generic.List[GUID]] $FieldGUIDs,
        [String] $Keywords,
        [String] $Name,
        [String] $Notes,
        [Int32] $Order,
        [Nullable[Int32]] $ParentID,
        [Collections.Generic.List[Int32]] $RelativityApplications,
        [PSCustomObject] $Shortcut
    )
    {
        $this.Color = $Color

        if ($FieldID -ne $null)
        {
            $this.Field = [RelativitySharedV1ModelsObjectIdentifier]::New($FieldID, $FieldGUIDs)
        }
        else
        {
            $this.Field = $null
        }
            
        $this.Keywords = $Keywords
        $this.Name = $Name
        $this.Notes = $Notes
        $this.Order = $Order

        if ($ParentID -ne $null)
        {
            $this.Parent = [RelativitySharedV1ModelsObjectIdentifier]::New($ParentID, "")
        }
        else
        {
            $this.Parent = $null
        }

        if ($RelativityApplications -ne $null)
        {
            $this.RelativityApplications = @()
            $RelativityApplications | ForEach-Object
            {
                $this.RelativityApplications.Add([RelativitySharedV1ModelsObjectIdentifier]::New($_, ""))
            }
        }
        else
        {
            $this.RelativityApplications = $null
        }

        $this.Shortcut = $null # feature not implemented/documented        
    }


    [Hashtable] ToHashTable()
    {
        $hashtable = @{}
        $hashtable["choiceRequest"] = @{}

        $hashtable["choiceRequest"]["Color"] = $this.Color

        if ($this.Field -ne $null)
        {
            $hashtable["choiceRequest"]["Field"] = @{}
            $hashtable["choiceRequest"]["Field"]["ArtifactID"] = $this.Field.ArtifactID
            $hashtable["choiceRequest"]["Field"]["Guids"] = @() # Not implemented/documented
        }

        if ($this.Keywords -ne "")
        {
            $hashtable["choiceRequest"]["Keywords"] = $this.Keywords
        }

        $hashtable["choiceRequest"]["Name"] = $this.Name

        if ($this.Notes -ne "")
        {
            $hashtable["choiceRequest"]["Notes"] = $this.Notes
        }

        $hashtable["choiceRequest"]["Order"] = $this.Order

        if ($this.Parent -ne $null)
        {
            $hashtable["choiceRequest"]["Parent"] = @{}
            $hashtable["choiceRequest"]["Parent"]["ArtifactID"] = $this.Parent.ArtifactID
        }

        if ($this.RelativityApplications -ne $null)
        {
            $hashtable["choiceRequest"]["RelativityApplications"] = @() # Not implemented/documented
        }

        Write-Verbose "Returning [Hashtable]"
        return $hashtable
    }
}
