#!/bin/bash


main()
{
	# get the freshly installed windows
	rsync win-storage-save win-storage
	docker compose up -d


	ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[localhost]:2022"

	# Wait until SSH can connect
	local tries=0
	while ! sshpass -p gates ssh -o ConnectTimeout=5 -p 2022 bill@localhost exit 2> /dev/null  && (( tries < 50 )) 
	do
		echo "Waiting for SSH to be available on $REMOTE_HOST:$REMOTE_PORT..."
		sleep 5
		((tries++))
	done


	# done
	echo 
	echo '****************************************'
	echo 'Docker is up, connect with:'
	echo
	echo '	sshpass -p gates ssh -o StrictHostKeyChecking=off bill@localhost -p 2022'
	echo
	echo '****************************************'
	read -p  'Press enter to shut down'

	docker compose down
}

main "$@"

