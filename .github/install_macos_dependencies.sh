# Install MKL
sudo conda install -c intel mkl-static mkl-devel
PYTHONEXEC=`which python`
sudo echo "MKLROOT=${PYTHONEXEC%/bin/python}" >> $GITHUB_ENV

echo "*********************"
echo "*********************"
echo "*********************"

echo ${PYTHONEXEC%/bin/python}::
ls ${PYTHONEXEC%/bin/python}
echo "*********************"
ls ${PYTHONEXEC%/bin/python}/lib
echo "*********************"
find ${PYTHONEXEC%/bin/python} -name "libmkl*"
