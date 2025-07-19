import os

file_path = 'wum_enhanced.txt'
temp_path = 'wum_enhanced.tmp'

# Read the content of the file
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Write the content back with ANSI encoding, replacing unsupported characters
with open(temp_path, 'w', encoding='cp1252', errors='replace') as f:
    f.write(content)

# Replace the original file with the new one
os.replace(temp_path, file_path)
