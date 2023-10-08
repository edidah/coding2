#dir="/Users/emoraa/Desktop/run238/fastq_pass/barcode*"
#for i in $dir;
#do
 #echo "$i"
 #cd "$i"
 #gunzip *.fastq.gz
 #filename=$(basename "$i" .fastq)
 #cat *fastq > "${filename}".fastq
 #mv "${filename}".fastq /Users/emoraa/Desktop/run238/fastq_pass/work_dir/
#done

#dir="/Users/emoraa/Desktop/run238/fastq_pass/barcode*"
#for i in $dir;
#do
 #echo "$i"

# Paths to the folder and CSV file
#folder_path="/Users/emoraa/Desktop/run238/fastq_pass"
#csv_file_path="/Users/emoraa/Desktop/run238/fastq_pass/run238.csv"

# Read CSV file line by line and rename files
#while IFS=, read -r old_name new_name; do
    #old_path="$folder_path/$old_name"
    #new_path="$folder_path/$new_name"

    #if [ -d "$old_path" ]; then
        #mv "$old_path" "$new_path"
        #echo "Renamed: $old_path -> $new_path"
    #else
        #echo "File not found: $old_path"
    #fi
#done < "$csv_file_path"

####quality check
#fastqc /Users/emoraa/Desktop/run238/work_dir/*.fastq
#multiqc /Users/emoraa/Desktop/run238/work_dir/*.zip
#multiqc /Users/emoraa/Desktop/run238/work_dir/*.html


####adapter_trimming chopping
#sample="/Users/emoraa/Desktop/run238/work_dir/*.fastq"
#for i in $sample;
#do
 #barcode=$(basename "$i" .fastq)
 #porechop -i "$i"  -o "${barcode}".trimmed.fastq
#done

#mkdir trimmed
#mv /Users/emoraa/Desktop/run238/fastq_pass/work_dir/*.fastq /Users/emoraa/Desktop/run238/fastq_pass/trimmed

###alignment step
#sample="/Users/emoraa/Desktop/run238/trimmed/*.trimmed.fastq"
#ref="/Users/emoraa/snakemake-tutorial/snakemake-turorial/isnv_prac/combined/ref.fasta"
#for i in $sample;
#do
  #file=$(basename "$i" .trimmed.fastq)
  #minimap2 -ax map-ont $ref $i > "${file}".sam
#done

####convert sam to bam
#sample="/Users/emoraa/Desktop/run238/*.sam"
#for i in $sample;
#do
 #file=$(basename "$i" .sam)
 #samtools view -bS "$i" > "${file}".bam
#done
 
#mv /Users/emoraa/Desktop/run238/fastq_pass/*.bam /Users/emoraa/Desktop/run238/fastq_pass/bam_files

#sample="/Users/emoraa/Desktop/run238/bam_files/*.bam"
#for i in $sample;
#do
 #file=$(basename "$i" .bam)
 #samtools sort "$i" -o "${file}".sorted.bam
 #samtools index "${file}".sorted.bam
#done

#mv /Users/emoraa/Desktop/run238/fastq_pass/*.sorted.bam /Users/emoraa/Desktop/run238/fastq_pass/bam_files

###variant calling
#sample="/Users/emoraa/Desktop/run238/sorted_bams/*.bam"
#ref="/Users/emoraa/snakemake-tutorial/snakemake-turorial/isnv_prac/combined/ref.fasta"
#for i in $sample;
#do
 #calls=$(basename "$i" .bam)
 #bcftools mpileup -Ou -f $ref "$i" |  bcftools call -mv -Ob -o "${calls}".vcf
#done

#sample="/Users/emoraa/Desktop/run238/vcf_files/*.vcf"
#for i in $sample;
#do
 #file=$(basename "$i" .vcf)
 #bcftools view "$i" -Oz -o "${file}".vcf.gz
 #bcftools index "${file}".vcf.gz 
#done

sample="/Users/emoraa/Desktop/run238/vcf_files/*.vcf.gz"
ref="/Users/emoraa/snakemake-tutorial/snakemake-turorial/isnv_prac/combined/ref.fasta"
for i in $sample;
do
 file=$(basename "$i" .vcf.gz)
 bcftools consensus -f $ref -o "${file}".consensus.fasta "$i"
done

#####rename the generated sequences

# Paths to the folder and CSV file
#folder_path="/Users/emoraa/Desktop/run238/fastq_pass/run238_genomes"
#csv_file_path="/Users/emoraa/Desktop/run238/fastq_pass/run238_genomes/run238.csv"

# Read CSV file line by line and rename files
#while IFS=, read -r old_name new_name; do
    #old_path="$folder_path/$old_name"
    #new_path="$folder_path/$new_name"
    
    #if [ -e "$old_path" ]; then
        #mv "$old_path" "$new_path"
        #echo "Renamed: $old_path -> $new_path"
    #else
        #echo "File not found: $old_path"
    #fi
#done < "$csv_file_path"
