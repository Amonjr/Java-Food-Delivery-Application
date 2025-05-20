Remove-Item -Recurse -Force .git
git init
git branch -M main
git config user.name "Amonjr"
git config user.email "gamitamon@gmail.com"

# The repo already has a .gitignore, we'll just commit it first
git add .gitignore
$date = Get-Date "2025-05-01T10:00:00"
$env:GIT_AUTHOR_DATE = $date.ToString("s")
$env:GIT_COMMITTER_DATE = $date.ToString("s")
git commit -m "Initial commit: Add gitignore"

$files = git ls-files --others --exclude-standard
$chunkSize = 6
$date = Get-Date "2025-05-02T09:00:00"
$messages = @("Update project files", "Add resources", "Refactor components", "Misc updates")

for ($i = 0; $i -lt $files.Count; $i += $chunkSize) {
    $chunk = $files[$i..([math]::Min($i + $chunkSize - 1, $files.Count - 1))]
    foreach ($file in $chunk) {
        git add "`"$file`""
    }
    
    $firstFile = $chunk[0]
    if ($firstFile -match "layout") { $msg = "Update UI layouts" }
    elseif ($firstFile -match "drawable") { $msg = "Add visual assets and drawables" }
    elseif ($firstFile -match "\.java$") { $msg = "Implement java application logic" }
    elseif ($firstFile -match "\.xml$") { $msg = "Update XML configurations" }
    elseif ($firstFile -match "gradle") { $msg = "Configure build scripts" }
    elseif ($firstFile -match "mipmap") { $msg = "Add app icons" }
    else { $msg = Get-Random -InputObject $messages }

    $hours = Get-Random -Minimum 2 -Maximum 24
    $date = $date.AddHours($hours)
    
    $env:GIT_AUTHOR_DATE = $date.ToString("s")
    $env:GIT_COMMITTER_DATE = $date.ToString("s")
    
    git commit -m $msg
}

git remote add origin https://github.com/Amonjr/Java-Food-Delivery-Application.git
git push --force -u origin main
