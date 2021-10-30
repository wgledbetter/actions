# Install MKL
conda install -c intel mkl-static mkl-devel
PYTHONEXEC=`which python`
export MKLROOT=${PYTHONEXEC%/bin/python}
