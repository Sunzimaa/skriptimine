#!/bin/bash
 
# Kontrollime, sisestanud failinime
if [ $# -ne 1 ]; then
    echo "Kasutamine: $0 <inimesed_fail>"
    exit 1
fi

# sisend- ja väljundfailide teed
input_file="$1"
output_dir="./konveier"
first_names_file="$output_dir/eesnimed.txt"
last_names_file="$output_dir/perenimed.txt"
domains_file="$output_dir/domeenid.txt"
usernames_file="$output_dir/kasutajad.txt"
emails_file="$output_dir/meilid.txt"

# Loome katalooge, kui neid ei ole olemas
mkdir -p "$output_dir"

# Lõika eesnimed ja salvesta need 
cut -d',' -f2 "$input_file" | sed 's/;.*//;s/[0-9]*-.*//;s/^[ \t]*//;s/[ \t]*$//' > "$first_names_file"

# Lõika perekonnanimed ja salvesta need
cut -d',' -f1 "$input_file" | tr '[:upper:]' '[:lower:]' | sed 's/^[ \t]*//;s/[ \t]*$//' > "$last_names_file"

# Lõika domeenid ja salvesta need
cut -d'-' -f2 "$input_file" | sed 's/^[ \t]*//;s/[ \t]*$//' > "$domains_file"

# Muuda eesnimed failis kõik tähed väikesteks
tr '[:upper:]' '[:lower:]' < "$first_names_file" > "$first_names_file.tmp" && mv "$first_names_file.tmp" "$first_names_file"

# Muuda perenimed failis kõik tähed väikesteks
tr '[:upper:]' '[:lower:]' < "$last_names_file" > "$last_names_file.tmp" && mv "$last_names_file.tmp" "$last_names_file"

# Loo kasutajate nimed kujul eesnimi.perenimi ja salvesta faili
paste -d"." "$first_names_file" "$last_names_file" > "$usernames_file"

# Loo e-mailid kujul eesnimi.perenimi@domeen ja salvesta faili
paste -d"@" "$usernames_file" "$domains_file" > "$emails_file"

# Kuvame loodud nimed
echo "Eesnimed salvestatud faili: $first_names_file"
echo "Perekonnanimed salvestatud faili: $last_names_file"
echo "Domeenid salvestatud faili: $domains_file"
echo "Kasutajatunnused salvestatud faili: $usernames_file"
echo "E-mailid salvestatud faili: $emails_file"

# Commit muudatused Git repository
git add "$first_names_file" "$last_names_file" "$domains_file" "$usernames_file" "$emails_file"
git commit -m "Genereeritud kasutajate andmed sisendfailist $input_file"
