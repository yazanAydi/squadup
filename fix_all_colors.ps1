# PowerShell script to fix all Color.withValues(alpha:) warnings
# This replaces the deprecated method with the correct Color.withOpacity() method

Write-Host "🔧 Fixing Color.withValues warnings in SquadUp..." -ForegroundColor Green

# Get all Dart files
$dartFiles = Get-ChildItem -Path "lib" -Recurse -Filter "*.dart" | Where-Object { $_.FullName -notlike "*test*" }

$totalFixed = 0

foreach ($file in $dartFiles) {
    $content = Get-Content $file.FullName -Raw
    $originalContent = $content
    
    # Fix Color.withValues(alpha: X) -> Color.withOpacity(X)
    $content = $content -replace 'Color\.withValues\(alpha:\s*([^)]+)\)', 'Color.withOpacity($1)'
    $content = $content -replace 'color\.withValues\(alpha:\s*([^)]+)\)', 'color.withOpacity($1)'
    $content = $content -replace '([a-zA-Z_][a-zA-Z0-9_]*)\.withValues\(alpha:\s*([^)]+)\)', '$1.withOpacity($2)'
    
    # Check if any changes were made
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -NoNewline
        $changes = ([regex]::Matches($originalContent, '\.withValues\(alpha:\s*[^)]+\)')).Count
        $totalFixed += $changes
        Write-Host "✅ Fixed $changes warnings in $($file.Name)" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "🎉 Color warnings fix complete!" -ForegroundColor Green
Write-Host "Total warnings fixed: $totalFixed" -ForegroundColor Cyan
Write-Host ""
Write-Host "The deprecated Color.withValues(alpha:) method has been replaced with Color.withOpacity()" -ForegroundColor White
Write-Host "Your code should now compile without these warnings!" -ForegroundColor White
