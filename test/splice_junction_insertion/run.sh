printf "%-70s" "Splice junction insertion..."

# change current directory to script directory
cd $(dirname $(readlink -f $0))

# remove and recreate output directory
if [ $1 == 0 ]; then
  if [ -d "out" ]; then
    rm -rf out/
  fi
  mkdir out
fi

# run CooVar
perl ../../coovar.pl \
  -e ENST00000420124.gtf \
  -v HG00732-200-37-ASM.test.vcf \
  -r $2 \
  -o out \
  --no_contig_sum \
  | tee out/coovar.log | grep -iP "(error|warning)"

# check output
n=`grep splice_acceptor_variant out/categorized-gvs.gvf | wc -l`
if [ $n != 1 ] ; then
    echo "[FAILED]"
    exit 1
fi

echo "[PASSED]"
exit 0
