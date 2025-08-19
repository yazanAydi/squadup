#!/usr/bin/env python3
"""
Comprehensive withValues(alpha:) to withOpacity() Fixer for SquadUp
This script will fix ALL Color.withValues(alpha:) issues across all Dart files
"""

import os
import re
import glob

def fix_withvalues_in_file(file_path):
    """Fix all withValues(alpha:) occurrences in a single file"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Count original occurrences
        original_count = len(re.findall(r'\.withValues\(alpha:\s*[^)]+\)', content))
        
        if original_count == 0:
            return 0
        
        # Replace all occurrences
        fixed_content = re.sub(r'\.withValues\(alpha:\s*([^)]+)\)', r'.withOpacity(\1)', content)
        
        # Write back to file
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(fixed_content)
        
        return original_count
    except Exception as e:
        print(f"Error processing {file_path}: {e}")
        return 0

def main():
    """Main function to fix all Dart files"""
    print("🔧 Starting comprehensive withValues(alpha:) fix for SquadUp...")
    
    # Find all Dart files
    dart_files = glob.glob("**/*.dart", recursive=True)
    dart_files = [f for f in dart_files if not f.startswith('fix_')]
    
    print(f"📁 Found {len(dart_files)} Dart files to process...")
    
    total_files = 0
    total_replacements = 0
    
    for file_path in dart_files:
        replacements = fix_withvalues_in_file(file_path)
        if replacements > 0:
            total_files += 1
            total_replacements += replacements
            print(f"✅ Fixed {file_path} ({replacements} replacements)")
    
    print(f"\n🎉 COMPREHENSIVE FIX COMPLETED!")
    print(f"📁 Files processed: {len(dart_files)}")
    print(f"🔧 Files fixed: {total_files}")
    print(f"🔄 Total replacements: {total_replacements}")
    
    if total_replacements > 0:
        print(f"\n⚠️  IMPORTANT NEXT STEPS:")
        print(f"   1. Run: flutter clean")
        print(f"   2. Run: flutter pub get")
        print(f"   3. Test your app to ensure all colors work correctly")
        print(f"   4. Build the app to verify no more compile errors")
    
    print(f"\n🚀 SquadUp should now compile without withValues errors!")

if __name__ == "__main__":
    main()
