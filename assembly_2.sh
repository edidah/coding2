####quality check

cd barcode69/processed_files
#gunzip *.fastq.gz
#cat *.fastq > combined1.fastq
#fastqc *.fastq.gz
#fastqc /Users/emoraa/snakemake-tutorial/snakemake-turorial/isnv_prac/combined/barcode69/processed_files/combined1.fastq

####adapter_trimming chopping
#sample="/Users/emoraa/snakemake-tutorial/snakemake-turorial/isnv_prac/combined/barcode69/*.fastq.gz"
#for i in $sample;
#do
 #barcode=$(basename "$i" .fastq.gz)
 #porechop -i "$i"  -o "${barcode}"._trimmed.fastq.gz
 #porechop -i /Users/emoraa/snakemake-tutorial/snakemake-turorial/isnv_prac/combined/barcode69/processed_files/combined1.fastq -o combined1_trimmed.fastq
#done


###alignment step
#sample="/Users/emoraa/snakemake-tutorial/snakemake-turorial/isnv_prac/combined/barcode69/processed_files/combined1_trimmed.fastq"
#ref="/Users/emoraa/snakemake-tutorial/snakemake-turorial/isnv_prac/combined/ref.fasta"
#for i in $sample;
#do
 #file=$(basename "$i" ._trimmed.fastq.gz)
 #minimap2 -ax map-ont $ref $sample > barcode69.sam
#done 

####convert sam to bam

#sample="/Users/emoraa/snakemake-tutorial/snakemake-turorial/isnv_prac/combined/barcode69/*.sam"
#for i in $sample;
#do
 #file=$(basename "$i" .sam)
 #samtools view -bS "$i" > "${file}".bam
 #samtools view -bS /Users/emoraa/snakemake-tutorial/snakemake-turorial/isnv_prac/combined/barcode69/processed_files/barcode69.sam > barcode69.bam
#done

######
#sample="/Users/emoraa/snakemake-tutorial/snakemake-turorial/isnv_prac/combined/barcode69/processed_files/*.bam"
#for i in $sample;
#do 
 #file=$(basename "$i" .bam)
 #samtools sort "$i" -o "${file}".sorted.bam
 #samtools sort /Users/emoraa/snakemake-tutorial/snakemake-turorial/isnv_prac/combined/barcode69/processed_files/barcode69.bam -o barcode69_sorted.bam
 #samtools index /Users/emoraa/snakemake-tutorial/snakemake-turorial/isnv_prac/combined/barcode69/processed_files/barcode69_sorted.bam 
 #samtools index "${file}".sorted.bam
#done

###variant calling
sample="/Users/emoraa/snakemake-tutorial/snakemake-turorial/isnv_prac/combined/barcode69/processed_files/barcode69_sorted.bam"
ref="/Users/emoraa/snakemake-tutorial/snakemake-turorial/isnv_prac/combined/ref.fasta"
#for i in $sample; 
#do
 #calls=$(basename "$i" .bam)
 #bcftools mpileup -Ou -f $ref $sample |  bcftools call -mv -Ob -o barcode69.vcf
 #bcftools mpileup -Ou -f $ref "$i" |  bcftools call -mv -Ob -o "${calls}".vcf 
#bcftools view "${calls}".bcf -Ov -o "${calls}".vcf
#bcftools view "${calls}".bcf -Ov -o "${calls}".vcf
#done



#####
#bgzip /Users/emoraa/snakemake-tutorial/snakemake-turorial/isnv_prac/combined/barcode69/processed_files/barcode69.vcf
#bcftools index /Users/emoraa/snakemake-tutorial/snakemake-turorial/isnv_prac/combined/barcode69/processed_files/barcode69.vcf.gz
sample="/Users/emoraa/snakemake-tutorial/snakemake-turorial/isnv_prac/combined/barcode69/processed_files/barcode69.vcf.gz"
ref="/Users/emoraa/snakemake-tutorial/snakemake-turorial/isnv_prac/combined/ref.fasta"
bcftools consensus -f $ref -o barcode69.consensus $sample

