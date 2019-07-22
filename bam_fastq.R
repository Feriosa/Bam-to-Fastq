#Note: RNASeq is a folder containing your RNAseq bam files.
#Please create two folders in advance, named "Kallisto_qaunt_RNA" and "kallisto_out_end", the former is used for generating files (then removed) and the latter is used for the final TPM and count values in transcript level.
#If you run these codes in UPPMAX, you should run the following codes in advance:
#module load bioinfo-tools
#module load BEDTools
#module load samtools
#module load kallisto

suffix_sort='_sort.bam'
suffix_fq1='_sort_/crex/proj/snic2018-3-564/test_fastq/Bedtools/'
suffix_fq2='_sort_end2.fq'
cd /mnt/ext_HDD/xiangyu/RNASeq/
  for i in `ls *_RNAseq.bam`
do
echo $i
prefix=${i%%_RNAseq.bam*}a
name_sort=${prefix}${suffix_sort}
name_fq_1=${prefix}${suffix_fq1}
name_fq_2=${prefix}${suffix_fq2}
mkdir /home/xiangyu/proj/Projects_1/Japanese_data/Kallisto_qaunt_RNA/$prefix
cd /home/xiangyu/proj/Projects_1/Japanese_data/Kallisto_qaunt_RNA/$prefix
samtools sort -n /mnt/ext_HDD/xiangyu/RNASeq/$i -o $name_sort
bedtools bamtofastq -i $name_sort -fq $name_fq_1 -fq2 $name_fq_2
kallisto quant -i /home/xiangyu/proj/Projects_1/Index_file/GRCh_P5/Homo_sapiens.GRCh38.cdna.all.fa.idx -o /home/xiangyu/proj/Projects_1/Japanese_data/kallisto_out_end/$prefix $name_fq_1 $name_fq_2
rm -f $name_sort $name_fq_1 $name_fq_2
done