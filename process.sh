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
  bash $name &
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
				echo "ENTER THE PROCESS NAME:"
				read nameOfP
				id=$(pgrep $nameOfP | head -n 1)
				if [[ -z $id ]]; then
					echo "NOT RESULT"
				else 
					kill $id
				fi
			;;
			"RAM Usage")
				echo "RAM USED BY EACH PROCESS: "
				ps aux | awk '{print $4, $11}' | sort -k1r | head -n 15
				res=$(ps aux | awk '{print $2, $4}' | sort -k2r | head -n 15) 
				echo "SELECT THE PERCENTAGE OF THE CHOOSEN PROCESS IN ORDER TO FINISH IT"
				read perc
				if [[ -z $perc || $perc -eq 0 ]]; then
					echo "NOT ALLOWED VALUE"
				else
					idErase=$(echo "$res" | grep $perc | awk '{print $1}' | head -n 1)
					echo "KILLING PROCESS: $idErase"
					kill $idErase
				fi
			;;
			"CPU Usage")
				echo "CPU USED BY EACH PROCESS: "
				ps aux | awk '{print $3, $11}' | sort -k1r | head -n 15
				res=$(ps aux | awk '{print $2, $3}' | sort -k2r | head -n 15) 
				echo "TEST: $res"
				echo "SELECT THE PERCENTAGE OF THE CHOOSEN PROCESS IN ORDER TO FINISH IT"
				read perc
				if [[ -z $perc || $perc == 0 ]]; then
					echo "NOT ALLOWED VALUE"
				else
					idErase=$(echo "$res" | grep $perc | awk '{print $1}' | head -n 1)
					echo "KILLING PROCESS: $idErase"
					kill $idErase
				fi
			;;
		esac
				
	
  	read -p "PRESS ENTER TO CONTINUE"
	break
	done

}

lookForP (){
  echo "WRITE THE PROCESS NAME"
  read name
  echo " ************** **************"
  res=$( ps -d | grep $name )
  if [[ -z $res  ]]; then
    echo "NO RESULTS"
  else
    echo $res
  fi
  read -p "PRESS ENTER TO CONTINUE"
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
  	  read -p "PRESS ENTER TO CONTINUE"
        ;;

      esac
      clear
    break
    done
done

##END OF THE CODE ##
