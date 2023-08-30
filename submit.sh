set -x
#cut -f 1 fastq_files.tsv | tail -n +2 |  parallel -X -j1 -l 128 echo seqkit sum --threads 48 -a -o seqkit_sum_{#}.tsv {} \>summarise.{#}.sh
for script in summarise.*.sh
do
	qsub -P xe2 -q normal -l ncpus=48 -l walltime=10:00:00 -l mem=48G \
		-l storage=gdata/xe2+scratch/xe2+massdata/xe2 -l wd -j oe \
		-m abe -W umask=002 -M pbs@kdmurray.id.au \
		$script
done
