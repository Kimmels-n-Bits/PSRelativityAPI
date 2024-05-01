class RelativityObjectQueryCondition
{
    [String] $Condition

    RelativityObjectQueryCondition (
        [Boolean] $Negated,
        [String] $Field,
        [RelativityObjectQueryConditionComparisonOperator] $ActiveOperator,
        [Nullable[RelativityObjectQueryConditionKeyword]] $ActiveKeyword,
        [Object] $Value
    )
    {
        $this.Condition = "("

        if ($Negated)
        {
            $this.Condition += "NOT "
        }

        $this.Condition += "'$($Field)' "

        switch ($ActiveOperator)
        {
            Eq { $this.Condition += "== " }
            Ne { $this.Condition += "<> " }
            Gt { $this.Condition += "> " }
            Ge { $this.Condition += ">= " }
            Lt { $this.Condition += "< " }
            Le { $this.Condition += "<= " }
            In { $this.Condition += "IN " }
            MonthOf
            {
                $this.Condition += "in MonthOf "
                [RelativityObjectQueryConditionMonthOf] $Value = $Value
            }
            StartsWith { $this.Condition += "STARTSWITH " }
            EndsWith { $this.Condition += "ENDSWITH " }
            Like { $this.Condition += "LIKE " }
            Contains { $this.Condition += "CONTAINS " }
            Intersect { $this.Condition += "INTERSECTS " }
            IsSet { $this.Condition += "ISSET" }
        }

        switch ($ActiveKeyword)
        {
            SavedSearch { $this.Condition += "SAVEDSEARCH " }
            View { $this.Condition += "VIEW " }
            Object { $this.Condition += "OBJECT " }
            MultiObject { $this.Condition += "MULTIOBJECT " }
            Choice { $this.Condition += "CHOICE " }
            MultiChoice { $this.Condition += "MULTICHOICE " }
            User { $this.Condition += "USER " }
        }

        $NonArrayKeywords = @(
            [RelativityObjectQueryConditionKeyword]::SavedSearch
            [RelativityObjectQueryConditionKeyword]::View
        )

        if (($ActiveOperator -eq [RelativityObjectQueryConditionComparisonOperator]::In -and
                $ActiveKeyword -notin $NonArrayKeywords) -or
                ($ActiveOperator -eq [RelativityObjectQueryConditionComparisonOperator]::Contains -and -not
                ($null -eq $ActiveKeyword)) -or
                ($ActiveOperator -eq [RelativityObjectQueryConditionComparisonOperator]::Intersect))
        {
            $this.Condition += "["

            switch ($true)
            {
                { $Value -is [Int32] } { $this.Condition += $Value.ToString() }
                { $Value -is [Int32[]] } { $this.Condition += ($Value | ForEach-Object { $_.ToString() }) -join ", " }
                { $Value -is [Decimal] } { $this.Condition += $Value.ToString() }
                { $Value -is [Decimal[]] } { $this.Condition += ($Value | ForEach-Object { $_.ToString() }) -join ", " }
                { $Value -is [String] } { $this.Condition += "'$($Value)'" }
                { $Value -is [String[]] } { $this.Condition += "'$($Value -join "', '")'" }
                { $Value -is [Guid] } { $this.Condition += $Value.ToString().ToUpper() }
                { $Value -is [Guid[]] } { $this.Condition += ($Value | ForEach-Object { $_.ToString().ToUpper() }) -join ", " }
            }

            $this.Condition += "]"
        }
        else
        {
            switch ($true)
            {
                { $Value -is [Int32] } { $this.Condition += $Value.ToString() }
                { $Value -is [DateTime] } { $this.Condition += "$($Value.ToString("yyyy-MM-ddTHH:mm:ss.ff"))Z" }
                { $Value -is [Boolean] } { $this.Condition += $Value.ToString().ToLower() }
                { $Value -is [Decimal] } { $this.Condition += $Value.ToString() }
                { $Value -is [RelativityObjectQueryConditionMonthOf] } { $this.Condition += $Value.ToString() }
                { $Value -is [String] } { $this.Condition += "'$($Value)'" }
                { $Value -is [Guid] } { $this.Condition += $Value.ToString().ToUpper() }
            }
        }

        $this.Condition += ")"
    }

    RelativityObjectQueryCondition (
        [RelativityObjectQueryCondition] $LeftCondition,
        [RelativityObjectQueryConditionCombinationOperator] $ActiveOperator,
        [Boolean] $Negated,
        [RelativityObjectQueryCondition] $RightCondition
    )
    {
        $this.Condition = "("
        $this.Condition += $LeftCondition.ToString()

        switch ($ActiveOperator)
        {
            And { $this.Condition += " AND " }
            Or { $this.Condition += " OR " }
        }

        if ($Negated)
        {
            $this.Condition += "NOT "
        }

        $this.Condition += $RightCondition.ToString()
        $this.Condition += ")"
    }

    [String] ToString()
    {
        return $this.Condition
    }
}