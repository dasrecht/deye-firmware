# bash script that runs shasum on all *.bin files in this directory
# and creates a file called $filename.DIGEST

# loop over all *.bin files
for filename in *.bin; do
    # create a file called $filename.DIGEST
    shasum -a 256 $filename > $filename.DIGEST
done
