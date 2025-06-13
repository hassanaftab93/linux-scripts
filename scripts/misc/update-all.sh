cd ../update

for f in *.sh; do
  bash "$f" || break
done