#!/bin/bash

difficultyMultiplier=1
finalStage=0

readStageNumbers(){
    clear
    echo "===== Choose the number of stages ====="
    echo "You can pick 10, 20, 50 or 100"
    read finalStage

    if [[ $finalStage -ne 10 && $finalStage -ne 20 &&  $finalStage -ne 50 && $finalStage -ne 100 ]]; then

        readStageNumbers

    fi

}

readDifficulty(){
    clear
    echo "To choose difficulty type '1 or Normal' '2 or Difficult' or '3 or Insane'"
    read difficulty

    if [[ $difficulty == "normal" || $difficulty -eq 1 ]]; then
        difficultyMultiplier=1
    elif [[ $difficulty == "difficult" || $difficulty -eq 2 ]]; then
        difficultyMultiplier=1 #ici le multiplicateur devrait être de 1.5 mais bug pendant le cast
    elif [[ $difficulty == "insane" || $difficulty -eq 3 ]]; then
        difficultyMultiplier=2
    else
        readDifficulty
    fi
}

basicGameCustomization(){

    clear
    echo "==============Castle of Hyrule=============="
    echo "  1.New Game     2.Quit"
    read input 

    if [[ $input -eq 1 ]]; then

        readDifficulty
        readStageNumbers

    elif [[ $input -eq 2 ]]; then

        stillAlive=0

    else 

        basicGameCustomization

    fi
}