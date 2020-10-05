FROM jupyter/scipy-notebook

USER $NB_UID
RUN mkdir /home/$NB_USER/tmp

# Install octave and additional libraries
user root

RUN apt-get update
RUN apt-get install -y --no-install-recommends octave gnuplot ghostscript liboctave-dev libgdcm3.0 libgdcm-dev cmake libnetcdf-dev

RUN octave --eval "pkg install -forge control"
RUN octave --eval "pkg install -forge struct"
RUN octave --eval "pkg install -forge io"
RUN octave --eval "pkg install -forge statistics"
RUN octave --eval "pkg install -forge dicom"
RUN octave --eval "pkg install -forge image"
RUN octave --eval "pkg install -forge linear-algebra"
RUN octave --eval "pkg install -forge lssa"
RUN octave --eval "pkg install -forge optics"
RUN octave --eval "pkg install -forge optim"
RUN octave --eval "pkg install -forge optiminterp"
RUN octave --eval "pkg install -forge quaternion"
RUN octave --eval "pkg install -forge queueing"
RUN octave --eval "pkg install -forge signal"
RUN octave --eval "pkg install -forge sockets"
RUN octave --eval "pkg install -forge splines"
RUN octave --eval "pkg install -forge netcdf"
RUN octave --eval "pkg install -forge symbolic"

USER $NB_UID

# Install Octave kernel
RUN conda config --add channels conda-forge
RUN conda install octave_kernel

# Remove unused folders
RUN rm -r /home/$NB_USER/tmp
RUN rm -r /home/$NB_USER/work

ADD --chown=1000:100 getstarted.ipynb /home/$NB_USER/

USER root
RUN apt-get install -y --no-install-recommends fonts-freefont-otf

#provide imshow with additional title so that all images are displayed in the same manner
# ADD imshow.m /usr/share/octave/5.2.0/m/image/

USER $NB_UID
