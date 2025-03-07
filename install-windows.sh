#!/bin/bash


main()
{
	docker compose up -d
	sleep 30s
	echo
	echo '****************************************************************************'
	echo 'Starting firefox.  Close firefox when install appears complete in the GUI.  '
	echo 'Make sure install.bat has finished running, it can take a while.'
	echo '****************************************************************************'
	echo
	firefox localhost:8006 2> /dev/null
	docker compose down
	cp -r win-storage win-storage-save
}

main "$@"
