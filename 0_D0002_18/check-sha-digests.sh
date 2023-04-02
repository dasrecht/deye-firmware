# loop over all *.bin.DIGEST files

for filename in *.bin.DIGEST; do
    shasum -a 256 -c $filename
done
