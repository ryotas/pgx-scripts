#!/bin/bash

echo '# Nodes' > data.pg

echo '' | \
awk '{for (i=0; i<100; i++) print(i, "type:account", "name:acc_"i)}' \
>> data.pg

echo '# Edges' >> data.pg

cat data-100.txt | \
awk '{print $1, $2, ":transfer"}' \
>> data.pg
