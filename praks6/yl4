#!/bin/bash
# Skript, mis kontrollib, kas sisestatud arv on algarv
# ja väljastab 20 esimese täisarvu kohta, kas need on algarvud või mitte

is_prime() {
    local num=$1
    if [ "$num" -le 1 ]; then
        echo "$num - ei ole algarv"
        return
    fi

    for ((i=2; i*i<=num; i++)); do
        if [ $((num % i)) -eq 0 ]; then
            echo "$num - ei ole algarv"
            return
        fi
    done

    echo "$num - on algarv"
}

# Kontrolli 20 esimese täisarvu kohta
for ((n=1; n<=20; n++)); do
    is_prime $n
done

# Kasutaja sisestatud arvu kontroll
read -p "Sisesta suvaline arv: " number
is_prime $number
