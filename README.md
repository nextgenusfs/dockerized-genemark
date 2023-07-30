##### dockerized GeneMark ES/ET/EP

This is a hacky way to run/install genemark with docker.  Why?  Well I develop on Mac OSX and GeneMark is no longer released for OSX, so this little repo will allow you to build a working GeneMark docker image and then "spoof" the `gmes_petap.pl` and `gmhmme3` scripts so that you can put this in your PATH and it can be picked up by some other software, ie `funannotate`.

You will need to download 64-bit GeneMark-ETP along with the license key to the same directory that you clone this repo from http://topaz.gatech.edu/GeneMark/license_download.cgi. [GeneMark-ES/ET/EP+ ver 4.71_lic and LINUX 64 kernel 3.10 - 5 version].  Then from that location you should just be able run:
```
docker build -t genemark .
```

This command will copy genemark and install inside the docker image called `genemark`.  Then using the bash wrapper scripts of `gmes_petap.pl` and `gmhmme3` will call the appropriate genemark execulatble via docker, ie:

```
$ gmes_petap.pl
# -------------------
Usage:  /opt/gmes_linux_64_4/gmes_petap.pl  [options]  --sequence [filename]

GeneMark-ES Suite version 4.71_lic
Suite includes GeneMark.hmm, GeneMark-ES, GeneMark-ET and GeneMark-EP algorithms.

Input sequence/s should be in FASTA format.

Select one of the gene prediction algorithms:

  To run GeneMark-ES self-training algorithm
    --ES

  To run GeneMark-ET with hints from transcriptome splice alignments
    --ET           [filename]; file with intron coordinates from RNA-Seq read splice alignment in GFF format
    --et_score     [number]; default 10; minimum score of intron in initiation of the ET algorithm

  To run GeneMark-EP with hints from protein splice alignments
    --EP
    --dbep         [filename]; file with protein database in FASTA format
    --ep_score     [number,number]; default 4,0.25; minimum score of intron in initiation of the EP algorithm
    or
    --EP           [filename]; file with intron coordinates from protein splice alignment in GFF format

  To run GeneMark.hmm predictions using previously derived model
    --predict_with [filename]; file with species specific gene prediction parameters

  To run ES, ET or EP with branch point model. This option is most useful for fungal genomes
    --fungus

  To run hmm, ES, ET or EP in PLUS mode (prediction with hints)
    --evidence     [filename]; file with hints in GFF format

  To run algorithms with alternative genetic codes
    --gcode      [number]; default 1; supported 1 and 6/26

Output formatting options:
  --format       [label]; default GTF; output gene prediction in GTF of GFF3 format
  --work_dir     [folder name]; default current working directory .;

Masking option
  --soft_mask    [number] or [auto]; default auto; to indicate that lowercase letters stand for repeats;
                 algorithm hard masks only lowercase repeats longer than specified length
                 In 'auto' mode hard masking threshold is selected by algorithm based on the size of the input genome
  --mask_penalty [number] or [auto]; default 0.03;

Run options
  --cores        [number]; default 1; to run program with multiple threads
  --pbs          to run on cluster with PBS support
  --v            verbose

Optional sequence pre-processing parameters
  --max_contig   [number]; default 5000000; will split input genomic sequence into contigs shorter then max_contig
  --min_contig   [number]; default 50000 (10000 fungi);
                 will ignore contigs shorter than min_contig in training
  --max_gap      [number]; default 5000; will split sequence at gaps longer than max_gap
                 Letters 'n' and 'N' are interpreted as standing within gaps
  --max_mask     [number]; default 5000; will split sequence at repeats longer then max_mask
                 Letters 'x' and 'X' are interpreted as results of hard masking of repeats

Optional parameters
  --max_intron            [number]; default 10000 (3000 fungi); maximum length of intron
  --max_intergenic        [number]; default 50000 (10000 fungi); maximum length of intergenic regions
  --min_contig_in_predict [number]; default 500; minimum allowed length of contig in prediction step
  --min_gene_in_predict   [number]; default 300 (120 fungi); minimum allowed gene length in prediction step
  --gc_donor              [value];  default 0.001; transition probability to GC donor in the range 0..1;
                          'off' switches GC donor model OFF
  --gc3          [number]; GC3 cutoff in training for grasses

Developer options
  --training     to run only training step of algorithm; applicable to ES, ET or EP
  --prediction   to run only prediction step of algorithms using species parameters from previously executed training; applicable to ES, ET or EP
  --usr_cfg      [filename]; use custom configuration from this file
  --ini_mod      [filename]; use this file with parameters for algorithm initiation
  --key_bin
  --debug
# -------------------

```