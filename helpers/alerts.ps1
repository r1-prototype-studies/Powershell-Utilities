function YesNoAlert {
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string] $title,
        [Parameter(Mandatory = $true, Position = 2)]
        [string] $question
    )

    $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
    $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'))
    $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'))

    $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
    if ($decision -eq 0) {
        return $true;
    }
    
}

clear-host