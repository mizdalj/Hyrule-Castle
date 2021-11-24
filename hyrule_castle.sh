#!/bin/bash

source basic_game_customization.sh
source rarity.sh
source better_combat_options.sh
source level_and_experience.sh

basicGameCustomization
#Ici on a divers variables pour compter la progression et déclarer les couleurs
currentStage=1
stillAlive=1
playerCoins=12
protectionModeActive=0

noColor="\e[39m"
greenColor="\e[32m"
redColor="\e[91m"
goldColor="\e[93m"


#variables relatives au joueur
playerName="Link"
maxPlayerHp=60
playerHp=60
playerStr=15
colorPlayer=$greenColor
getRamdomCharacterByRarity players.csv

#variables relatives à l'adversaire
nameOponnent="Unknown"
maxOponnentHp=0
hpOponnent=0
strOponnent=0
aliveOponnent=0

printHealthBar() # Arguments hp maxHp nom couleur
{
    i=0
    echo -e "$4 $3 $noColor"
    while [[ $2 -gt $i ]];
    do
        if [[ $1 -gt $i ]];
        then
            echo -n "I"
        else
            echo -n "_"
        fi
        i=$((i+1))
    done
    echo " $1 / $2 "
}

output(){

    clear
    echo "======= FIGHT $currentStage ======="
    echo "You are fighting a $nameOponnent"
    printHealthBar $playerHp $maxPlayerHp $playerName $colorPlayer
    echo 
    printHealthBar $hpOponnent $maxOponnentHp $nameOponnent $colorOponnent
    echo
    echo "====Options========================"

    if [[ $1 -eq 0 ]];then

        echo 
        echo "1. Attack         2. Heal"
        echo "3. Protect        4. Escape"

    else
        if [[ $aliveOponnent -eq 0 && $escapedStatus -ne 1 ]]; then

            echo "You defeated $nameOponnent!"
            echo "You earned $playerCoins coins so far!"
            echo "Press any button to continue"
            read x
            getRandomXp
            
        fi

    fi

}

endGameOutput(){

    clear
    echo "=============================="
    echo "      The game has ended"
    echo "=============================="
    if [[ $stillAlive -eq 1 ]];then

        echo "You have won, congratulations!"
    
    else

        echo "You have lost, try again! "

    fi

}

init(){


    if [[ $1 == "randomMob" ]]; then

        getRamdomEnemyByRarity enemies.csv
        colorOponnent=$redColor
        aliveOponnent=1

    elif [[ $1 == "randomBoss" ]]; then

        getRamdomEnemyByRarity bosses.csv
        colorOponnent=$goldColor
        aliveOponnent=1

    fi

}

readInput(){

    read input # on check l'entrée, si 1 alors on attaque, si c'est 2 alors on heal

    if [[ $input -eq 1 || ${input,,} == "attack" ]]; then

        hpOponnent=$((hpOponnent-playerStr))

        if [[ $hpOponnent -le 0 ]]; then
            aliveOponnent=0
        fi

    elif [[ $input -eq 2 || ${input,,} == "heal"  ]]; then 

        playerHp=$(($playerHp+($maxPlayerHp/2)))

        if [[ $playerHp -gt $maxPlayerHp ]]; then #si le heal est soigne au dela des hp max on réduit à hp max
                playerHp=$maxPlayerHp
        fi

    elif [[ $input -eq 3 || ${input,,} == "protect" ]]; then 

        protectMode

    elif [[ $input -eq 4 || ${input,,} == "escape" ]]; then 
    
        escapeFight

    else

        echo "Please type 1, 2, 3 or 4 or type the action name"
        readInput

    fi
}

oponnentTurn(){

    if [[ $aliveOponnent -eq 1 ]]; then

        damage=$((strOponnent*difficultyMultiplier))

        if [[ $protectionModeActive -eq 1 ]]; then
            playerHp=$((playerHp-(damage/2))) #ici l'adversaire tape le personnage
            protectionModeActive=0
        else
            playerHp=$((playerHp-damage))
        fi

        if [[ $playerHp -lt 0 ]]; then #si on a plus de vie on meurt

            stillAlive=0

        fi
    fi

}

fight(){


    if [[ $currentStage == "10" || $currentStage -eq 20|| $currentStage -eq 30  || $currentStage -eq 40 || $currentStage -eq 50 || $currentStage -eq 60 || $currentStage -eq 70 || $currentStage -eq 80 || $currentStage -eq 90 || $currentStage -eq 100 ]]; then
        init "randomBoss"
    else
        init "randomMob"
    fi

    while [[ $aliveOponnent -eq 1 && $stillAlive -eq 1 ]]; do

        output 0 # output de début de tour
        readInput
        oponnentTurn
        output 1 #output de fin de tour

    done
    
    if [[ $aliveOponnent -eq 0 ]]; then
        
        currentStage=$((currentStage+1)) #si l'ennemi est vaincu on passe au niveau suivant   
        playerCoins=$((playerCoins+1)) #on attribue le coin
    fi

}

while [[ $currentStage -le $finalStage && $stillAlive -eq 1 ]]; do #si on est vivant et qu'on a pas fini l'etage final on continue la boucle
    
    fight
    
done

endGameOutput