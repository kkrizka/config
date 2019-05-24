# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
source ${HOME}/dev/setup.sh

export PATH=${HOME}/bin:${PATH}
export LD_LIBRARY_PATH=${HOME}/lib:${LD_LIBRARY_PATH}

# config in git
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# ROOT
export ROOTSYS=${HOME}/Sources/root/build-v6-16-00
if [ -e ${ROOTSYS}/bin/thisroot.sh ]; then
    source ${ROOTSYS}/bin/thisroot.sh
    alias root='root -l'
fi

# Desktop helpers
if [ -z ${DESKTOP_SESSION} ]; then
    alias o='echo open'
elif [ ${DESKTOP_SESSION} == "gnome" ]; then
    alias o='gnome-open'
else
    alias o="kde-open"
fi
export EDITOR=emacs

# SSH autocomplete
complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh

# Gentoo
alias emerge="sudo emerge"
alias euse="sudo euse"
alias ebuild="sudo ebuild"
alias layman="sudo layman"

# ATLAS
function atlas() {
    export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
    export ALRB_localConfigDir=$HOME/localConfig
    source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh

    export RUCIO_ACCOUNT=kkrizka
    export XrdSecGSISRVNAMES="*"

    alias gridcert="voms-proxy-init -voms atlas -out \${X509_USER_PROXY} -valid 500:00"
    alias mwt2xrd="sed -e 's/^/root:\/\/xrddc.mwt2.org:1096/'"
    alias uct3xrd="sed -e 's/^/root:\/\/uct3-xrd.mwt2.org\//'"
    alias faxboxxrd="sed -e 's/^/root:\/\/faxbox.usatlas.org\//'"

    export SVNUSR=svn+ssh://svn.cern.ch/reps/atlasusr
    export SVNOFF=svn+ssh://svn.cern.ch/reps/atlasoff
    export SVNPHYS=svn+ssh://svn.cern.ch/reps/atlasphys
    export SVNPERF=svn+ssh://svn.cern.ch/reps/atlasperf
    export SVNINST=svn+ssh://svn.cern.ch/reps/atlasinst
    export SVNGRPS=svn+ssh://svn.cern.ch/reps/atlasgroups

    export ROOTCORE_NCPUS=10
}

# Vivado
function setupVivado()
{
    version=${1}
    if [ ! -e /opt/Xilinx/Vivado/${version}/settings64.sh ]; then
	echo "unable to find version ${version}"
	return
    fi
    export PS1="(vivado) ${PS1}"
    source /opt/Xilinx/Vivado/${1}/settings64.sh
}
