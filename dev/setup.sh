export XDG_DATA_DIRS=/usr/share

for app in ${HOME}/dev/*
do
    # Do not load files
    if [ -f ${app} ]
    then
	continue;
    fi
    
    # Add binaries to path
    if [ -d ${app}/bin ]
    then
	export PATH=${app}/bin:${PATH}
    fi

    # Add libraries modules to path
    if [ -d ${app}/lib ]
    then
	export LD_LIBRARY_PATH=${app}/lib:${LD_LIBRARY_PATH}
    fi

    if [ -d ${app}/lib64 ]
    then
	export LD_LIBRARY_PATH=${app}/lib64:${LD_LIBRARY_PATH}
    fi

    # Add folders to pkg-config
    if [ -d ${app}/lib/pkgconfig ]
    then
	export PKG_CONFIG_PATH=${app}/lib/pkgconfig:${PKG_CONFIG_PATH}
    fi

    # Add python packages to path
    if [ -d ${app}/lib/python2.7/site-packages ]
    then
	export PYTHONPATH=${app}/lib/python2.7/site-packages:${PYTHONPATH}
    fi

    # Add XDG data to path
    if [ -d ${app}/share ]
    then
	export XDG_DATA_DIRS=${app}/share:${XDG_DATA_DIRS}
    fi

    # Initialize extra paths
    if [ -f ${app}/setup.sh ]
    then
	. ${app}/setup.sh
    fi
done

# Search for all CMake modules and add them to path
#FILES=`find /home/kkrizka/dev/ -name *.cmake`
#DIRS="";
#for i in $FILES
#do
#    DIR=`dirname $i`
#    DIRS=${DIRS}'\n'${DIR}
#done
#CMAKE_PATH=`echo -e ${DIRS} | uniq`
#for i in $CMAKE_PATH
#do
#    export CMAKE_MODULE_PATH="${i};${CMAKE_MODULE_PATH}"
#done
