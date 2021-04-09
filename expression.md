
Lab 9: Gene Expression
======================

During this lab, we will acquaint ourselves with how to estimate gene expression. You will:



> Step 1: Launch an instance on Jetstream. For this exercise, we will use a _m1.xlarge_ instance.



> Update and upgrade your computer like you have every other week. Yes, you may use notes and previous labs..


```
sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y install build-essential git
```

> Install Conda like you have every other week!

```
mkdir anaconda
cd anaconda
curl -LO https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh
bash Anaconda3-2020.11-Linux-x86_64.sh -b -p $HOME/anaconda/install/
echo ". $HOME/anaconda/install/etc/profile.d/conda.sh" >> ~/.bashrc
source ~/.bashrc

conda update -y -n base conda
conda create -y --name gen711
conda activate gen711
```

> Install the following software packages via Conda like you have every other week: `kallisto sra-tools`

> Install bashplotlib

```
conda install -y -c conda-forge bashplotlib
```

> Install Salmon


```
cd 
curl -LO https://github.com/COMBINE-lab/salmon/releases/download/v1.4.0/salmon-1.4.0_linux_x86_64.tar.gz
tar -zxf salmon-1.4.0_linux_x86_64.tar.gz
```

>Download data

```bash
cd
mkdir $HOME/data
cd $HOME/data
curl -LO https://s3.amazonaws.com/reference_assemblies/eremicus/transcriptome/brain.final.fasta
prefetch SRR1575395
```

> Convert SRA format into fastQ (takes a few minutes)

```bash
cd $HOME/data
fastq-dump --split-files --split-spot $HOME/ncbi/public/sra/SRR1575395.sra
```


> Use Kallisto to count

```bash
mkdir $HOME/quant
cd $HOME/quant
kallisto index -i transcripts.idx $HOME/data/brain.final.fasta
kallisto quant -t 24 -i transcripts.idx -o kallisto_output $HOME/data/SRR1575395_1.fastq $HOME/data/SRR1575395_2.fastq
```


> Using Salmon to count


```bash
cd $HOME/quant
$HOME/salmon-latest_linux_x86_64/bin/salmon index -t $HOME/data/brain.final.fasta -i transcripts_index
$HOME/salmon-latest_linux_x86_64/bin/salmon quant -p 24 -i transcripts_index --seqBias --gcBias -l a \
-1 $HOME/data/SRR1575395_1.fastq \
-2 $HOME/data/SRR1575395_2.fastq -o salmon_output
```

> look at estimates of TPM

```bash
cd $HOME/quant
cat salmon_output/quant.sf | sed -e 1d | sort -nk1 > salmon.quant
cat kallisto_output/abundance.tsv | sed -e 1d | sort -nk1 > kallisto.quant
paste salmon.quant kallisto.quant  | column -s $'\t' -t | awk '{print $1 "\t" ($4-$10)/((($4+$10)/2)+.001)}'  > expression.diffs
```

> histogram

```bash
hist -c blue --file <(cat expression.diffs | cut -f2) -b 50
```


TERMINATE YOUR INSTANCE
=======================
