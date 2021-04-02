Lab 10: Transcriptome Assembly
--

See http://oyster-river-protocol.readthedocs.io

> Step 1: Launch an instance on Jetstream. For this exercise, we will use a m1.xlarge instance.

> Update, upgrade, install...

```
sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y install build-essential git
```

> Install the Oyster River Software

We will be using docker to do this

```
sudo usermod -a -G docker USERNAME
```

Install the image

```
docker pull macmaneslab/orp:2.2.6
```

> Download Illumina RNAseq data

```
mkdir newt
cd newt
wget https://raw.githubusercontent.com/AdamStuckert/Gen711/master/Lab/Files/Taricha_granulosa_subsampled.1.fq
wget https://raw.githubusercontent.com/AdamStuckert/Gen711/master/Lab/Files/Taricha_granulosa_subsampled.2.fq
```

>Check everything is there!

```
ls -lht
```

> Activate a conda environment

```
Activate a conda environment
```

> Assemble using the ORP

```
$HOME/Oyster_River_Protocol/oyster.mk \
STRAND=RF \
MEM=15 \
CPU=9 \   
READ1=Taricha_granulosa_subsampled.1.fq \
READ2=Taricha_granulosa_subsampled.2.fq \
RUNOUT=newt
```

Ok, so jetstream is interpreting these all as separate lines. So to make your life easier, you can just paste this into a text editor (NOT Word!!) and then make it a single line. Paste that in. Or just type it all! It will give you the full life experience :)

# Terminate your instance

old version of lab:
------------------------------------------------------------------------------------------------------

```
git clone https://github.com/macmanes-lab/Oyster_River_Protocol.git
cd Oyster_River_Protocol
make
```
## Type

```
source ~/.profile
```

> Download Illumina RNAseq data, and subsample it.

```
cd
source activate orp_v2

curl -LO https://s3.amazonaws.com/gen711/1.subsamp_1.fastq
curl -LO https://s3.amazonaws.com/gen711/1.subsamp_2.fastq
seqtk sample -s23 1.subsamp_1.fastq 100000 > reads.1.fq
seqtk sample -s23 1.subsamp_2.fastq 100000 > reads.2.fq
```

> Edit config.ini

```

sed -i  "s_ubuntu_$(whoami)_g" $HOME/Oyster_River_Protocol/software/config.ini
```

> Assemble using the ORP

```
$HOME/Oyster_River_Protocol/oyster.mk main \
MEM=50 \
CPU=24 \
READ1=reads.1.fq \
READ2=reads.2.fq \
RUNOUT=smallassembly
 ```
# Terminate your instance
