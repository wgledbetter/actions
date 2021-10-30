# Install MKL
conda activate test
conda install -c intel mkl-static mkl-devel intel-openmp
PYTHONEXEC=`which python`
sudo echo "MKLROOT=/usr/local/miniconda" >> $GITHUB_ENV

echo "1*********************"
echo "2*********************"
echo "3*********************"

echo ${PYTHONEXEC%/bin/python}::
echo "*********************"
ls ${PYTHONEXEC%/bin/python}/lib
echo "*********************"
sudo find /usr/local/miniconda -name "libiomp*"
echo "END FIND ************"
