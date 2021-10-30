# Install MKL
conda install -c intel mkl-static mkl-devel
PYTHONEXEC=`which python`
echo "MKLROOT=${PYTHONEXEC%/bin/python}" >> $GITHUB_ENV
