####qc
for f1 in *.fastq
do
        f2=${f1%%_R1_001.fastq}"_R2_001.fastq"
        fastp -i $f1 -I $f2 -o "trimmed-$f1" -O "trimmed-$f2"
done

#######ref indexing
 bowtie2-build hg_19.fasta hg_db

###move to new directory
mkdir qc_results
mv trimmed*  qc_results
mv *.bt2  qc_results
cd qc_results
##genome mapping

for f1 in *_R1_001.fastq

do

 f2=${f1%%_R1_001.fastq}"_R2_001.fastq"

#bowtie2 -x hg_db -1 f1 -2 f2 -S f1_mapped_and_unmapped.sam
bowtie2 -x hg_db -1 $f1 -2 $f2 -S "$f1"_mapped_and_unmapped.sam

done

########convert sam to bam

for file in *.sam; do
  name= echo "${file%%.*}"
  echo $name
  samtools view -bS $file > "${file%%.*}".bam
done

############filter for unmapped reads

for file in *.bam
do
     samtools view -f 12 -F 256 $file > "${file%.*}"_unmapped.bam
done

##########split and convert to fastq

for f1 in *_unmapped.bam;do
 samtools sort -n $f1 -o "${f1}"_sorted.bam

done

for file in *_sorted.bam;do
   bedtools bamtofastq -i $file -fq "${file%.*}"_depleted_r1.fastq -fq2 "${file%.*}"_depleted_r2.fastq
done


