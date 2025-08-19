# Fix Deprecated withOpacity() to withValues(alpha:) for SquadUp
# This script will fix ALL deprecated withOpacity() calls

Write-Host "🔧 Starting withOpacity() deprecation fix for SquadUp..." -ForegroundColor Yellow

# Get all Dart files
$dartFiles = Get-ChildItem -Recurse -Filter "*.dart" | Where-Object { $_.Name -notlike "fix_*" }

$totalFiles = $dartFiles.Count
$fixedFiles = 0
$totalReplacements = 0

Write-Host "📁 Found $totalFiles Dart files to process..." -ForegroundColor Cyan

foreach ($file in $dartFiles) {
    $content = Get-Content $file.FullName -Raw
    $originalContent = $content
    
    # Count original instances
    $originalCount = ([regex]::Matches($content, '\.withOpacity\([^)]+\)')).Count
    
    if ($originalCount -gt 0) {
        # Replace all instances: .withOpacity(X) -> .withValues(alpha: X)
        $content = $content -replace '\.withOpacity\(([^)]+)\)', '.withValues(alpha: $1)'
        
        # Count new instances
        $newCount = ([regex]::Matches($content, '\.withValues\(alpha:\s*[^)]+\)')).Count
        
        if ($newCount > 0) {
            # Write the fixed content back
            Set-Content $file.FullName $content -Encoding UTF8
            
            $fixedFiles++
            $totalReplacements += $originalCount
            
            Write-Host "✅ Fixed $($file.Name) ($originalCount → $newCount replacements)" -ForegroundColor Green
        }
    }
}

Write-Host "`n🎉 WITHOPACITY DEPRECATION FIX COMPLETED!" -ForegroundColor Green
Write-Host "📁 Files processed: $totalFiles" -ForegroundColor Cyan
Write-Host "🔧 Files fixed: $fixedFiles" -ForegroundColor Cyan
Write-Host "🔄 Total replacements: $totalReplacements" -ForegroundColor Cyan

if ($fixedFiles -gt 0) {
    Write-Host "`n⚠️  IMPORTANT NEXT STEPS:" -ForegroundColor Yellow
    Write-Host "   1. Run: flutter clean" -ForegroundColor White
    Write-Host "   2. Run: flutter pub get" -ForegroundColor White
    Write-Host "   3. Test your app to ensure all colors work correctly" -ForegroundColor White
    Write-Host "   4. Build the app to verify no more deprecation warnings" -ForegroundColor White
}

Write-Host "`n🚀 SquadUp should now use the correct withValues(alpha:) syntax!" -ForegroundColor Green

