# PowerShell script to fix all Color.withValues(alpha:) issues
# Run this in your project root directory

Write-Host "🔧 Fixing Color.withValues(alpha:) issues across all Dart files..." -ForegroundColor Yellow

# Get all Dart files
$dartFiles = Get-ChildItem -Recurse -Filter "*.dart"

$totalFiles = $dartFiles.Count
$fixedFiles = 0
$totalReplacements = 0

foreach ($file in $dartFiles) {
    $content = Get-Content $file.FullName -Raw
    $originalContent = $content
    
    # Replace all instances of .withValues(alpha: X) with .withOpacity(X)
    $content = $content -replace '\.withValues\(alpha:\s*([^)]+)\)', '.withOpacity($1)'
    
    # Count replacements
    $replacements = ([regex]::Matches($originalContent, '\.withValues\(alpha:\s*[^)]+\)')).Count
    
    if ($replacements -gt 0) {
        Set-Content $file.FullName $content
        $fixedFiles++
        $totalReplacements += $replacements
        Write-Host "✅ Fixed $file.Name ($replacements replacements)" -ForegroundColor Green
    }
}

Write-Host "`n🎉 Color fixes completed!" -ForegroundColor Green
Write-Host "📁 Files processed: $totalFiles" -ForegroundColor Cyan
Write-Host "🔧 Files fixed: $fixedFiles" -ForegroundColor Cyan
Write-Host "🔄 Total replacements: $totalReplacements" -ForegroundColor Cyan

if ($fixedFiles -gt 0) {
    Write-Host "`n⚠️  IMPORTANT: After running this script:" -ForegroundColor Yellow
    Write-Host "   1. Run 'flutter clean'" -ForegroundColor White
    Write-Host "   2. Run 'flutter pub get'" -ForegroundColor White
    Write-Host "   3. Test your app to ensure all colors work correctly" -ForegroundColor White
}
