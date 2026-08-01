import os
import re

def process_file(filepath):
    with open(filepath, 'r') as f:
        lines = f.readlines()
        
    out_lines = []
    # We will track if we recently saw `Scaffold(` or `AppBar(`
    # A simple state machine:
    state = "normal" 
    
    changed = False
    
    for i, line in enumerate(lines):
        if re.search(r'\b(Scaffold|AppBar)\s*\(', line):
            state = "in_widget"
            
        if state == "in_widget":
            # If we see backgroundColor inside this state, we check if it's the target
            if "backgroundColor: theme.colorScheme.surface" in line:
                # Replace it with theme.scaffoldBackgroundColor if it's Scaffold
                # Wait, it's easier to just comment it out so it falls back to theme!
                line = line.replace("backgroundColor: theme.colorScheme.surface", "// backgroundColor: theme.colorScheme.surface")
                changed = True
            elif "backgroundColor: AppColors.lightBackground" in line:
                line = line.replace("backgroundColor: AppColors.lightBackground", "// backgroundColor: AppColors.lightBackground")
                changed = True
                
        out_lines.append(line)
        
    if changed:
        with open(filepath, 'w') as f:
            f.writelines(out_lines)
        print(f"Fixed {filepath}")

for root, _, files in os.walk('lib'):
    for file in files:
        if file.endswith('.dart'):
            process_file(os.path.join(root, file))
