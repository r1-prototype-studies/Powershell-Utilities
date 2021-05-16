function FetchFromGit {
    git fetch --all
}

function CommitChanges { 
    $currentBranch = git branch --show-current
    write-host "Current GIT branch is $currentBranch"

    #git status
    if (!([string]::IsNullOrEmpty($(git status --porcelain)))) {
        
        if ($currentBranch.ToLower() -eq "main" ) {
            $branchDate = $(Get-Date).ToString('yyyyMMddHHmm');
            $currentBranch = "$($env:UserDomain)_$($env:UserName)_$($env:ComputerName)_$branchDate"
        
            Write-Host "Creating new branch $currentBranch..."
            git checkout -b $currentBranch     
        }

        git status
            
        $proceed = YesNoAlert -title "Changed Detected" -question "The changes will be committed and pushed to GIT branch: $currentBranch. Do you want to proceed? "
        if ($proceed) {
            git add .
            $commitMessage = ""
            while ($commitMessage.Trim() -eq "" ) {
                $commitMessage = Read-Host "Enter descriptive commit message"  
            }

            git commit -m $commitMessage
            git push --set-upstream origin $currentBranch

            $proceed = YesNoAlert -title "Move to Main Branch" -question "The changes from the branch: $currentBranch will not be available until it is merged with main branch. Do you want to proceed? "
            if ($proceed) {
                git checkout main
                git pull --force
            }
        }
        else {
            exit
        }
    }
    else {
        git checkout main
        git pull --force
    }
} 

function InitializeGit {
    CommitChanges
    #git status
    #git checkout main
}

#clear-host

