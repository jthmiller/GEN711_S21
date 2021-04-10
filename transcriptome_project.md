Lab 10: Transcriptome Assembly
--

See http://oyster-river-protocol.readthedocs.io

> Step 1: Launch an instance on Jetstream. For this exercise, we will use a m1.xlarge instance.

> Update, upgrade, install... note soething different here???

```
sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y install build-essential git
```

> Install the Oyster River Software.. what is this black magoc DOCKER stuff??

```
docker pull macmaneslab/orp:2.3.2
```
## Type

```
docker run -it macmaneslab/orp:2.3.2 bash
```

> Download Illumina RNAseq data, and subsample it.

```
cd
source activate orp

conda install -yc bioconda sra-tools
conda install -yc conda-forge tmux


cd $HOME/data
prefetch SRR1789336

fastq-dump --split-files --split-spot $HOME/ncbi/public/sra/SRR1789336.sra
seqtk sample -s1998 SRR1789336_1.fastq 5000000 > reads.1.fq
seqtk sample -s1998 SRR1789336_2.fastq 5000000 > reads.2.fq
```

> Assemble using the ORP

```
$HOME/Oyster_River_Protocol/oyster.mk main \
TPM_FILT=1 \
STRAND=RF \
MEM=50 \
CPU=24 \
READ1=reads.1.fq \
READ2=reads.2.fq \
RUNOUT=SRR1789336_5M
```
