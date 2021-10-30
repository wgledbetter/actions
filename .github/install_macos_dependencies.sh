# Install MKL
sudo conda install -c intel mkl-static mkl-devel intel-openmp
PYTHONEXEC=`which python`
sudo echo "MKLROOT=${PYTHONEXEC%/bin/python}" >> $GITHUB_ENV

echo "1*********************"
echo "2*********************"
echo "3*********************"

echo ${PYTHONEXEC%/bin/python}::
echo "*********************"
ls ${PYTHONEXEC%/bin/python}/lib/python3.8
echo "*********************"
find ${PYTHONEXEC%/bin/python} -name "libmkl*"
echo "END FIND ************"
