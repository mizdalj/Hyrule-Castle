#!/bin/bash
<<COMMENT
The character randomly earns between 15 and 50 experience points after each victory
The character gains a level each time it earns enough experience points. You decide of how much XP the character needs to level up
Each time the character levels up, it randomly gains statistics. You decide how much statistics it gains
COMMENT

experience=0
level=1
xpRequired=$((100*level))


getRandomXp(){
    
    randomXp=$[ RANDOM % 50 ]

    if [[ randomXp -lt 15 ]]; then
        randomXp=$((randomXp+15))
    fi

    experience=$((experience+randomXp))
    xpRequired=$((level*100))
    levelUp
}

levelUp(){

    if [[ $experience -gt $xpRequired ]]; then  
        level=$((level+1))
        experience=0
        setNewStats

    fi

}
 
setNewStats(){  #ici on modifie les stats si le level est passé
        randomStat=$[ RANDOM % 2 ]

        if [[ $randomStat -eq 0 ]]; then
            maxPlayerHp=$((maxPlayerHp+5))
            clear
            echo "====== You reached the next level ======"
            echo "Your max Health increased by 5"
            echo "Press any button to continue "
            read x

        elif [[ $randomStat -eq 1 ]]; then
            playerStr=$((playerStr+5))
            clear
            echo "====== You reached the next level ======"
            echo "Your max Strength increased by 5"
            echo "Press any button to continue "
            read x

        fi
}
