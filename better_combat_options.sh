#!/bin/bash

protectMode(){

    protectionModeActive=1

}

escapeFight(){

    playerCoins=$((playerCoins-1))
    playerHp=$((playerHp-10))

    clear
    echo "========= You choose to quit the fight ========="
    echo "            You lost 1 coin and 10 Hp            "
    echo "================================================"
    echo
    echo "Press any button to continue"
    read var
    aliveOponnent=0
    escapedStatus=1
    currentStage=$((currentStage-1))
    playerCoins=$((playerCoins-1))

}