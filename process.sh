

##FUNCTIONS ##
writeTittle(){
  echo "  ___                                   __  __    _        __ "
  echo " | _ \  _ _   ___   __   ___   ___  ___ \ \/ /   / |      /  \ "
  echo " |  _/ | '_| / _ \ / _| / -_) (_-< (_-<  >  <    | |  _  | () |"
  echo " |_|   |_|   \___/ \__| \___| /__/ /__/ /_/\_\   |_| (_)  \__/ "
  echo "****************************************************************"
}

createNewProcess (){
  echo "# WRITE THE NAME OF THE PROCESS IN ORDER TO START IT"
  read name
  $name &> processOutput.txt ## TRY TO RUN THE PROCESS AND THEN REDIRECT THE
  #OUTPUT TO A FILE
}

showAllProcesses (){
  echo "** CURRENT PROCESSES **"
  ps -d
  read -p "PRESS ENTER TO CONTINUE"
}

veriffyIfSU (){
  res=$(whoami | grep root)
  if [[ -z $res ]]; then
    echo "YOU HAVE TO RUN THE SCRIPT AS ROOT IN ORDER TO USE IT :("
    exit
  fi
}

killFunction (){
	echo "CHOOSE IF YOU WANT TO KILL A PROCES BY:"
	select option in Name "RAM Usage" "CPU Usage"
	do
		case $option in
			Name)
				echo "ENTER THE NAME OF THE PROCESS:"
				read nameOfP
				id=$(pgrep $nameOfP)
				kill $id
			;;

		esac
				

	break
	done

}

lookForP (){
  echo "WRITE THE PROCESS NAME"
  read name
  echo " ************** **************"
  res=$( ps -d | grep $name )
  if [[ -z $res  ]]; then
    echo "NO SE ENCONTRARON COINCIDENCIAS"
  else
    echo $res
  fi
}
##END FUNCTIONS ##

##CODE ##
option="x"
veriffyIfSU
while [[ $option != Exit ]]; do
  writeTittle
  select option in CreateProcess KillProcess ShowProcesses LookForAProcess Exit
    do
      case $option in
        CreateProcess)
          createNewProcess
        ;;

        ShowProcesses)
          showAllProcesses
        ;;

        LookForAProcess)
          lookForP
        ;;

	KillProcess)
	  killFunction
	;;

	Exit)
	  echo "THANKS FOR USING PROCESSX"
	;;

        *)
          echo "INVALID OPTION"
        ;;

      esac
    break
    done
done

##END OF THE CODE ##
