Lab 10: Transcriptome Assembly
--

See http://oyster-river-protocol.readthedocs.io

> Step 1: Launch an instance on Jetstream. For this exercise, we will use a m1.xlarge instance.

> Update, upgrade, install... note soething different here???

```
sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y install build-essential git
```

> Install the Oyster River Software.. what is this black magic DOCKER stuff??

```
docker pull macmaneslab/orp:2.2.8
```
## Type

```
docker run -it macmaneslab/orp:2.2.8 bash
```

> Download Illumina RNAseq data, and subsample it.

```
cd
source activate orp

curl -LO https://s3.amazonaws.com/gen711/1.subsamp_1.fastq
curl -LO https://s3.amazonaws.com/gen711/1.subsamp_2.fastq
seqtk sample -s23 1.subsamp_1.fastq 100000 > reads.1.fq
seqtk sample -s23 1.subsamp_2.fastq 100000 > reads.2.fq
```


> Assemble using the ORP

```
$HOME/Oyster_River_Protocol/oyster.mk main \
TPM_FILT=2 \
STRAND=RF \
MEM=50 \
CPU=24 \
READ1=reads.1.fq \
READ2=reads.2.fq \
RUNOUT=smallassembly
 ```
# Terminate your instance
