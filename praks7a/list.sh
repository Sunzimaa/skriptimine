#!/bin/bash
 
fail_count=0
kataloog_count=0
link_count=0

process_item() {
    if [ -L "$1" ]; then
        echo "Link: $1"
        ((link_count++))
    elif [ -f "$1" ]; then
        echo "Fail: $1"
        ((fail_count++))
    elif [ -d "$1" ]; then
        echo "Kataloog: $1"
        ((kataloog_count++))
    fi
}

# List all items in the current directory
for item in *; do
    process_item "$item"
done

# Print summary
echo -e "\nSummary:"
echo "Failide arv: $fail_count"
echo "Kataloogide arv: $kataloog_count"
echo "Linkide arv: $link_count"
echo "Koguarv: $((fail_count + kataloog_count + link_count))"
