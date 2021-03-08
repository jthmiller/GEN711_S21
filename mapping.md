## Week 6: Read Mapping


During this lab, we will acquaint ourselves with read mapping. You will:

1. Install software and download data

3. Map reads to dataset

4. look at mapping quality


The STAR manuscript: https://www.ncbi.nlm.nih.gov/pubmed/23104886
The STAR manual: https://github.com/alexdobin/STAR/blob/master/doc/STARmanual.pdf



> Step 1: Launch an instance on Jetstream. For this exercise, we will use a _m1.Xlarge_ instance.

```
ssh -i jetkey username@xxx.xxx.xxx.xxx
```

> Update and upgrade your computer like you have every other week. Yes, you may use notes and pervious labs..


> Install the following...
```
sudo apt-get -y install build-essential python libssl-dev python3-htseq
pip3 install HTSeq
```


> Install Conda like you have every other week!


> Install the following software packages via Conda like you have every other week: `samtools openssl=1.0 bedtools star bcftools vcftools`


>Download data

```bash

mkdir $HOME/data
cd $HOME/data
curl -LO ftp://ftp.ensemblgenomes.org/pub/metazoa/release-50/fasta/danaus_plexippus/dna/
curl -LO ftp://ftp.ensemblgenomes.org/pub/metazoa/release-50/gff3/danaus_plexippus/Danaus_plexippus.Dpv3.50.gff3.gz
curl -LO https://s3.amazonaws.com/gen711/SRR585568_R1.fastq.gz
curl -LO https://s3.amazonaws.com/gen711/SRR585568_R2.fastq.gz
gzip -d *gz

```


> Index the genome

```bash
mkdir $HOME/butterfly

STAR --runMode genomeGenerate --genomeDir $HOME/butterfly \
--genomeFastaFiles $HOME/data/Danaus_plexippus.Dpv3.dna.toplevel.fa \
--sjdbGTFfile $HOME/data/Danaus_plexippus.Dpv3.50.gff3 \
--genomeSAindexNbases 12 \
--runThreadN 24
```

>Map reads!! (5 minutes). You're mapping RNA data, from a butterfly antenna to the butterfly genome.

```bash

mkdir $HOME/mapping/
cd $HOME/mapping/

STAR --runMode alignReads \
--genomeDir $HOME/butterfly/ \
--readFilesIn $HOME/data/SRR585568_R1.fastq $HOME/data/SRR585568_R2.fastq   \
--runThreadN 14 \
--outFilterMultimapNmax 20 \
--outFilterMismatchNmax 10 \
--outFilterScoreMinOverLread 0.5 \
--outFilterMatchNminOverLread 0.5 \
--quantMode GeneCounts \
--outFileNamePrefix monarch_mapping_ \
--outSAMtype BAM SortedByCoordinate
```

> Let's find SNPs, but just on the largest scaffold.

```bash
cd $HOME/mapping/

samtools view -h -t  $HOME/data/Danaus_plexippus.Dpv3.dna.toplevel.fa --threads 12 monarch_mapping_Aligned.sortedByCoord.out.bam \
| awk '$1 ~ "@" || $3=="DPSCF300001"' \
| samtools view -h -t  $HOME/data/Danaus_plexippus.Dpv3.dna.toplevel.fa --threads 12 -1 -o filtered.bam -


bcftools mpileup --skip-indels -f $HOME/data/Danaus_plexippus.Dpv3.dna.toplevel.fa filtered.bam | \
bcftools view -O v --threads 24 -v snps - > variants.vcf
```

> look at your vcf file. If we had mapped many individuals, we could calculate many interesting population genetics stats using the `vcftools` package.

```bash
less -S variants.vcf
```


# TERMINATE YOUR INSTANCE
