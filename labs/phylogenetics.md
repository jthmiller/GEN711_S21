Lab 3: Make a phylogeny!!!
--

During this lab, we will acquaint ourselves with the steps to making a tree. Your objectives are:


1. Familiarize yourself with the software, how to execute it, how to visualize results.

2. Identity the unknown sequences.


> Step 1: Launch an instance on Jetstream. For this exercise, we will use a m1.medium instance.

```
ssh -i jetkey username@xxx.xxx.xxx.xxx
```

> The machine you are using is Linux Ubuntu: Ubuntu is an operating system you can use (I do) on your laptop or desktop. One of the nice things about this OS is the ability to update the software, easily.  The command `sudo apt-get update` checks a server for updates to existing software.


```
sudo apt-get update
```

> The upgrade command actually installs any of the required updates.

```
sudo apt-get -y upgrade
```

> OK, what are these commands?  `sudo` is the command that tells the computer that we have admin privileges. Try running the commands without the sudo -- it will complain that you don't have admin privileges or something like that. *Careful here, using sudo means that you can do something really bad to your own computer -- like delete everything*, so use with caution. It's not a big worry when using Jetstream, as this is a virtual machine- fixing your worst mistake is as easy as just terminating the instance and restarting.


> So now that we have updates the software, lets see how to add new software. Same basic command, but instead of the `update` or `upgrade` command, we're using `install`. EASY!!


```
sudo apt-get -y install ruby build-essential python python-pip gdebi-core r-base

```


> Install Conda. Conda is another package manager, but for scientific software. We will use it basically every week!

```
mkdir anaconda
cd anaconda
curl -LO https://repo.anaconda.com/archive/Anaconda3-5.1.0-Linux-x86_64.sh
bash Anaconda3-5.1.0-Linux-x86_64.sh -b -p $HOME/anaconda/install/
echo ". $HOME/anaconda/install/etc/profile.d/conda.sh" >> ~/.bashrc
source ~/.bashrc
```

> Make a conda environment, activate it, and install raxml and mafft. Make sure you know what these software packages are used for.

```
conda create -y --name gen711
conda activate gen711
conda install -y -c bioconda raxml mafft
```


>Download some data, using this command. The 1st dataset is data is from an unknown species, the 2nd is the UniProt database, which is a well curated set of protein sequences from many different organisms. It's often a good 1st database to use for trying to identify sequences. Look at the 2 datasets using the comment `less`. Are these nucleotides or proteins?

```
cd $HOME
curl -LO https://s3.amazonaws.com/gen711/dataset1.pep
curl -LO https://s3.amazonaws.com/gen711/uniprot.pep

```

>In the interest of time, I am having you pull out the HOX genes from the Uniprot database, and 2 unknown sequences (ENSPTRP00000032491 and ENSPTRP00000032494). You're goal is to tell me the identity of these unknowns using a tree.

```
grep --no-group-separator -A1 'ENSPTRP00000032491\|ENSPTRP00000032494' dataset1.pep > query.pep
grep --no-group-separator -A1 'HXA2_HUMAN\|HXA2_BOVIN\|HXA2_PAPAN\|HXA3_HUMAN\|HXA3_MOUSE\|HXA3_BOVIN\|HXA9_HUMAN' uniprot.pep > results.pep
cat query.pep results.pep > for_alignment.pep
```



>Align the proteins using mafft. It would be great if you figured out what the command is doing.


```
mafft --reorder --bl 80 --localpair --thread 6 for_alignment.pep > for.tree
```

> Make a phylogeny. It would be great if you figured out what the command is doing.
```
raxmlHPC-PTHREADS -f a -m PROTGAMMAAUTO -T 6 -x 37644 -N 100 -n tree -s for.tree -p 35 -o "sp|P31269|HXA9_HUMAN"
```


## Visualize the phylogeny...

> Download and install RStudio

```
curl -LO  https://download2.rstudio.org/rstudio-server-1.1.456-amd64.deb
sudo gdebi -n rstudio-server-1.1.456-amd64.deb
```

> Make a password for the Rstudio webserver (make it easy, like the word "password"!!!)

```
sudo passwd $(whoami)
```

>Note that the text will not echo to the screen (because it’s a password!)

> Find out the web address of your server. Paste the web address that comes up on the terminal, in to your browser.

```
printf "\n\n\n\n The web address for my RStudio Web server, the one I need to paste into my browser, is:  http://$(hostname):8787/ \n\n\n\n"
```

### in RStudio (not the terminal)

>Install packages.

```
install.packages(c("ape", "ggplot2"))
source("http://bioconductor.org/biocLite.R")
biocLite(c("ggtree", "Biostrings"))

library("ape")
library("Biostrings")
library("ggplot2")
library("ggtree")
```

>Read in the results file you just made and look at the results!!!

```
tree <- read.raxml("RAxML_bipartitionsBranchLabels.tree")

ggtree(tree) + geom_label(aes(label=bootstrap, fill=bootstrap)) + geom_tiplab() +
scale_fill_continuous(low='darkgreen', high='red') + ggplot2::xlim(0, 4)
```

Looking at the tree, can you tell me which type of HOX genes ENSPTRP00000032491 and ENSPTRP00000032494 are? If you can, you've just used comparative phylogenetics (instead of BLAST) to identify unknown sequences! Some might say this is a much more scientifically sound way of identifying unknown sequences. YAY!!!!

## Terminate your instance!!!

This lab uses code from ANGUS2017: https://angus.readthedocs.io/en/2017/visualizing-blast-scores-with-RStudio.html
