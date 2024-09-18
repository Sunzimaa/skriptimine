#!/bin/bash
# Skript, mis väljastab tärnid ja 'o' kujul, kus iga järgnev rida sisaldab ühe tärni rohkem ja ühe 'o' vähem kui eelmine

read -p "Sisesta ridade arv: " rows

for ((i=1; i<=rows; i++))
do
  for ((j=1; j<=rows-i; j++))
  do
    echo -n "o "
  done
  for ((k=1; k<=i; k++))
  do
    echo -n "* "
  done
  echo ""
done
