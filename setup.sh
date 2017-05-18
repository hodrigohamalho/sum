#!/bin/bash
# Setup Jboss Fuse and Data Virtualization environment
# @author Rodrigo Ramalho - rramalho@redhat.com
#                           github.com/hodrigohamalho
# This script shouldn't be updated
# all settings is on setup.env.sh file

. setup-env.sh

function validateRequirements(){
	command -v mvn -q >/dev/null 2>&1 || { echo >&2 "Maven is required but not installed or not present in thet system PATH yet... aborting."; exit 1; }

	# make some checks first before proceeding.
	if [ -r $FUSE_INSTALLER ] || [ -L $FUSE_INSTALLER ]; then
		printf "\n JBoss Fuse installer is present..."
	else
		printf "\n Need to download Fuse package from the Customer Portal"
		printf "\n\t and place it in the $BINARIES_DIR directory to proceed... \n"
		exit
	fi

}

function installFuse(){
	# install a fresh fuse
	echo
	echo "Installing Fuse"
	echo "Please wait..."

	unzip -q $FUSE_INSTALLER -d $TARGET_DIR

	if [ $? -ne 0 ]; then
		echo "\n Error occurred during JBoss Fuse installation!"
		exit
	fi

	mv $FUSE_HOME $TARGET_DIR/jboss-fuse
	FUSE_HOME=$TARGET_DIR/jboss-fuse

	# comment out user admin
	sed -i '' '/admin/s/^#//g' $FUSE_HOME/etc/users.properties
	
	echo "To create fuse on fabric mode, run:"
	echo ""
	echo "fabric:create --clean -m 127.0.0.1 -r manualip --wait-for-provisioning" 
	echo ""
	echo ""

	echo "JBoss Fuse was successfully installed!"
}

function startFuse(){
	sh $TARGET_DIR/jboss-fuse/bin/fuse
}

function uninstallFuse(){
	if [ -x $TARGET_DIR/jboss-fuse ]; then
		echo "Removing old installation... \n"
		rm -rf $TARGET_DIR/jboss-fuse
	fi
}


case "$1" in
	install-fuse)
		uninstallFuse
		installFuse
		;;

	uninstall-fuse)
		uninstallFuse
        ;;

	start-fuse)
		startFuse
		;;
		
        *)
            echo $"Usage: $0  install-fuse | uninstall-fuse"
	    echo ""
            exit 1

esac
