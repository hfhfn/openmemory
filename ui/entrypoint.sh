#!/bin/sh
set -e

# Ensure the working directory is correct
cd /app



# Replace env variable placeholders with real values
echo "Replacing environment variables..."
printenv | grep NEXT_PUBLIC_ | while read -r line ; do
  key=$(echo "$line" | cut -d "=" -f1)
  value_raw=$(echo "$line" | cut -d "=" -f2-)

  # Escape backslashes and double quotes in the raw value to make it a valid JS string literal content
  # Ensure that the final replacement is treated as a string literal in JS by quoting it.
  js_string_value="\"$(echo "$value_raw" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g')\""

  # Construct sed expressions to replace:
  # 1. process.env.KEY
  # 2. process.env['KEY'] (single quotes)
  # 3. process.env["KEY"] (double quotes)
  # with "$js_string_value" (the actual JS string literal)

  # Note: Using pipe '|' as the sed delimiter.
  # The key itself (e.g., NEXT_PUBLIC_API_URL) is assumed to be a simple alphanumeric string
  # and doesn't require further regex escaping in this specific context of sed patterns.

  # Apply to .js and .html files in .next/ directory.
  # Using find -print0 | xargs -0 for safer filename handling.
  find .next/ \( -name "*.js" -o -name "*.html" \) -type f -print0 | xargs -0 sed -i \
    -e "s|process\.env\.$key|$js_string_value|g" \
    -e "s|process\.env\['$key'\]|$js_string_value|g" \
    -e "s|process\.env\[\"$key\"\]|$js_string_value|g"
done
echo "Done replacing env variables NEXT_PUBLIC_ with real values"


# Execute the container's main process (CMD in Dockerfile)
exec "$@"