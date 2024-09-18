#!/bin/bash

# Funktsioon
process_item() {
    if [ -L "$1" ]; then
        echo "Link: $1 -> $(readlink -f "$1")"
        ((link_count++))
    elif [ -f "$1" ]; then
        echo "Fail: $1"
        ((fail_count++))
    elif [ -d "$1" ]; then
        echo "Kataloog: $1"
        ((kataloog_count++))
    fi
}

# Küsi directorit
read -p "Sisesta directory: " directory

# Vaata kas directory on olemas
if [ ! -d "$directory" ]; then
    echo "Error: Sellist directorit ei ole olemas!."
    exit 1
fi

# Mine directorisse
cd "$directory" || exit

# Initialize counters
fail_count=0
kataloog_count=0
link_count=0

# Listin asjad
echo "Listin direktoris olevad asjad:"
for item in *; do
    process_item "$item"
done

# Print kokkuvõte
echo -e "\nKokkuvõte:"
echo "Failide arv: $fail_count"
echo "Kataloogide arv: $kataloog_count"
echo "Linkide arv: $link_count"
echo "Koguarv: $((fail_count + kataloog_count + link_count))"
