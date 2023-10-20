samples=/Users/emoraa/Desktop/tre/assembly_snakemake/fastq_pass/barcode*

for f in $samples;
 do 
  file=$(basename $f)
  cd $f 
  cat *.fastq > "${file}"_combined.fastq
  mv *_combined.fastq /Users/emoraa/Desktop/tre/assembly_snakemake/fastq_pass/combined_files
 done
