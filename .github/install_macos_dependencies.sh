# Install MKL
conda install -c intel mkl-static mkl-devel
PYTHONEXEC=`which python`
echo "MKLROOT=${PYTHONEXEC%/bin/python}" >> $GITHUB_ENV

echo ${PYTHONEXEC%/bin/python}::
ls ${PYTHONEXEC%/bin/python}
echo "*********************"
ls ${PYTHONEXEC%/bin/python}/lib
echo "*********************"
find ${PYTHONEXEC%/bin/python} -name "libmkl*"
