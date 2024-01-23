(base) jtmiller@ron:~$ cd dc_workshop/

curl -L -o data/ref_genome/ecoli_rel606.fasta.gz ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/017/985/GCA_000017985.1_ASM1798v1/GCA_000017985.1_ASM1798v1_genomic.fna.gz

(base) jtmiller@ron:~/dc_workshop$ gunzip data/ref_genome/ecoli_rel606.fasta.gz 

(base) jtmiller@ron:~/dc_workshop$ curl -L -o sub.tar.gz https://ndownloader.figshare.com/files/14418248

tar xvf sub.tar.gz

(base) jtmiller@ron:~/dc_workshop$ mkdir -p results/sam results/bam results/vcf

conda activate genomics-plus

(base) jtmiller@ron:~/dc_workshop$ bwa index data/ref_genome/ecoli_rel606.fasta

bwa mem data/ref_genome/ecoli_rel606.fasta 

bwa mem \
    data/ref_genome/ecoli_rel606.fasta \
    data/trimmed_fastq_small/SRR2589044_1.trim.sub.fastq \
    data/trimmed_fastq_small/SRR2589044_2.trim.sub.fastq \
    > results/sam/SRR2589044.aligned.sam

grep -v '^@' results/sam/SRR2589044.aligned.sam | head


samtools view -S -b \
results/sam/SRR2589044.aligned.sam \
> results/sam/SRR2589044.aligned.bam

samtools sort -o results/bam/SRR2589044.aligned.sorted.bam \
results/sam/SRR2589044.aligned.bam 

samtools flagstat results/bam/SRR2589044.aligned.sorted.bam

bcftools mpileup -Ob \
-o results/bam/SRR2589044_raw.bcf \
-f data/ref_genome/ecoli_rel606.fasta \
results/bam/SRR2589044.aligned.sorted.bam