Transcriptome Assembly Project
--

See http://oyster-river-protocol.readthedocs.io

> Step 1: Launch an instance on Jetstream. For this exercise, we will use a m1.xlarge instance.

> Update, upgrade, install...

```
sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y install build-essential git tmux
```

> Install the Oyster River Software.. 

```
docker run -it macmaneslab/orp:2.3.2 bash
```

> Start a TMUX window

```
tmux new -s project
```

> Download Illumina RNAseq data

```
conda create -yn sra
source activate sra

conda install -yc bioconda sra-tools

mkdir $HOME/data
cd $HOME/data
prefetch SRR1789336

fastq-dump --split-files --split-spot $HOME/ncbi/public/sra/SRR1789336.sra
```

> Subsample the data
```
source activate orp

seqtk sample -s1998 SRR1789336_1.fastq 5000000 > reads.1.fq
seqtk sample -s1998 SRR1789336_2.fastq 5000000 > reads.2.fq
```

> Assemble using the ORP

```
$HOME/Oyster_River_Protocol/oyster.mk \
TPM_FILT=1 \
STRAND=RF \
MEM=50 \
CPU=24 \
READ1=reads.1.fq \
READ2=reads.2.fq \
RUNOUT=SRR1789336_5M
```
