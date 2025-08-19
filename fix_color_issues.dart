// Script to fix Color.withValues(alpha:) issues
// Run this in your terminal to fix all files:

// For Windows PowerShell:
// Get-ChildItem -Recurse -Filter "*.dart" | ForEach-Object { (Get-Content $_.FullName) -replace '\.withValues\(alpha:\s*([^)]+)\)', '.withValues(alpha: $1)' | Set-Content $_.FullName }

// For Unix/Linux/Mac:
// find . -name "*.dart" -exec sed -i 's/\.withValues(alpha: \s*\([^)]*\))/.withValues(alpha: \1)/g' {} \;

// This will replace all instances of:
// .withValues(alpha: 0.5) → .withValues(alpha: 0.5)
// .withValues(alpha: 0.1) → .withValues(alpha: 0.1)
// etc.
