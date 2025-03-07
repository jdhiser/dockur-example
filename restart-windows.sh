#!/bin/bash


main()
{
	rsync win-storage-save win-storage
	docker compose up

	echo 'Docker is up, connect with:'
	echo 'sshpass -p gates ssh bill@gates -p 2022'
}

main "$@"
