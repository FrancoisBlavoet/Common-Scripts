export DZR_TEXT_HOME=~/code/mobile_texts_module

function updateTexts() {
		echo 'updating the text module repo'
		cd $DZR_TEXT_HOME && git pull 
		cd -
}


alias sshdzr='ssh fblavoet@172.16.1.103'