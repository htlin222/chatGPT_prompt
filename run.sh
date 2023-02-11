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
cat "$output_file" | python -c "import sys, yaml, json; print(json.dumps(yaml.load(sys.stdin, Loader=yaml.FullLoader), indent=2))" > "my_prompts.json"

# Display a message to indicate that the conversion is complete
echo "Done. 🟢 "

exit 0


