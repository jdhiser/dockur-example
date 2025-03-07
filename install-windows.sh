#!/bin/bash


main()
{
	docker compose up -d
	sleep 30s
	echo 'Starting firefox.  Close firefox when install appears complete in the GUI.'
	firefox localhost:8006
	docker compose down
	cp -r win-storage win-storage-save
}

main "$@"
