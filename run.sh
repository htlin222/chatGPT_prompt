#!/bin/bash
# title: run
# date created: "2023-02-12"

path="./prompt"
output_file="./my_prompts.yaml"

# Remove the previous combined file if it exists
if [ -f "$output_file" ]; then
  rm "$output_file"
fi

# Create a new combined file
echo "---" >> "$output_file"
for filename in "$path"/*.yaml; do
  cat "$filename" >> "$output_file"
  echo "" >> "$output_file"
done

# Convert the combined YAML file to JSON
cat "$output_file" | python -c "import sys, yaml, json; print(json.dumps(yaml.load(sys.stdin, Loader=yaml.FullLoader), indent=2))" > "user_custom.json"

file_to_replace="user_custom.json"
target_dir="$HOME/.chatgpt/cache_model"

if [ -f "$target_dir/$file_to_replace" ]; then
  rm "$target_dir/$file_to_replace"
  echo "Removed old file: $target_dir/$file_to_replace"
fi

new_file="./$file_to_replace"
if [ -f "$new_file" ]; then
  cp "$new_file" "$target_dir/$file_to_replace"
  echo "Replaced with new file: $target_dir/$file_to_replace"
else
  echo "New file not found: $new_file"
fi

# Display a message to indicate that the conversion is complete
echo "Done. 🟢 "

exit 0


