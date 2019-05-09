alias umcsif="umount /Users/$USER/Desktop/Mount"
mcsif () {
    remote_username='bgerrity'
    local_hostname=$1 # local not referring to this system
    cs_domain='cs.ucdavis.edu'

    mountpoint="/Users/$USER/Desktop/Mount"
    login="$remote_username@$local_hostname.$cs_domain"

    if (( "$#" != 1 )) 
    then
        echo 'Usage: mcsif <local hostname>'
        echo "e.g. 'mcsif pc19'"
    else
        mt_cmd="sshfs -o reconnect $login:/home/$remote_username $mountpoint -ovolname=CSIF"
        # should `defer_permissions` be added to options?
        echo
        # echo $mt_cmd
        echo "mount from $login"
        eval $mt_cmd

        connect_cmd="ssh $login"
        echo
        echo "$str$connect_cmd"
        eval $connect_cmd

        echo
        echo "unmount from $login"
        umcsif
    fi
}