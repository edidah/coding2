folders="/Users/emoraa/Desktop/tre/assembly_snakemake/fastq_pass/barcode*"
for i in $folders;
 do
   cd $i
   gunzip *.fastq.gz
 done
