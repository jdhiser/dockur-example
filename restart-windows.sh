#!/bin/bash


main()
{
	# get the freshly installed windows
	rsync win-storage-save win-storage
	docker compose up


	# Wait until SSH can connect
	local tries=0
	while ! nc -z -w 5 "localhost" "2022" && (( tries < 50 )) 
	do
		echo "Waiting for SSH to be available on $REMOTE_HOST:$REMOTE_PORT..."
		sleep 5
		((tries++))
	done


	# done
	echo 
	echo '****************************************'
	echo 'Docker is up, connect with:'
	echo '	sshpass -p gates ssh bill@gates -p 2022'
	echo
	echo 'Press enter to shut down'
	echo '****************************************'

	pause
	docker compose down
}

main "$@"

