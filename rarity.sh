getRarity()
{
    percent=$((1 + $RANDOM % 100));
    
    if [ $percent -eq 1 ]  
        then 
            rarityObtained=5;
    elif [ 5 -gt $percent ] 
        then 
            rarityObtained=4;
     elif [ 16 -gt $percent ] 
        then 
            rarityObtained=3;
     elif [ 31 -gt $percent ] 
        then 
            rarityObtained=2;
     else 
            rarityObtained=1;
     fi
}

getInFileRamdomValueByRarity()
{
    maxfind=0    
    getRarity
    #compte le nomber total de monstre avec la rareté obtenue dans getRarity et sauvegarde la valeur dans maxfind 
    while IFS="," read -r id name hp mp str int def res spd luck race class rarity
        do
            if [[ $id != "id" && $rarity -eq $rarityObtained ]];
                then
                # echo $name $rarity
                 maxfind=$(($maxfind +  1))
            fi 
    done < $1
   
    #ramdom de 1 a maxfind le monstre a selectionner dans un groupe de rareté
    #Si on a trouver 2 monstre de 5rarity  on va ramdom un nombre de 1 a 2 et selectionner un des deux.  
    indexEnemySelectedRamdom=$((1 + $RANDOM % $maxfind));
    index=1 

    while IFS="," read -r id name hp mp str int def res spd luck race class rarity
        do
            # parcoure les monstre en verifiant si l'index et égale a l'index ramdom et que la rarity et la meme que dans $rarityObtained, si oui alors on a trouver le monstre 
            if [[ $id != "id" && $rarity -eq $rarityObtained && $index -eq $indexEnemySelectedRamdom ]];
               then
                    export $2=$hp
                    export $3=$hp
                    export $4=$str
                    export $5=$name
                #  exporte est utiliser pour changer dynamiquement les valeur a changer 
                
                #  maxOponnentHp=$hp
                #  hpOponnent=$hp
                #  strOponnent=$str
                #  nameOponnent=$name
                 index=$(($index +  1))
                #  si on a pas trouver de rarité et l'index via -eq, on verifi si une rareté si oui on passe a l'index suivant c'est que l'index n'est pas sur cette rarity la.   
            elif [[ $id != "id" && $rarity -eq $rarityObtained ]];
                then
                 index=$(($index +  1))
            fi 
    done < $1
}
getRamdomEnemyByRarity () {
    # getInFileRamdomValueByRarity $1
    getInFileRamdomValueByRarity $1 maxOponnentHp hpOponnent strOponnent nameOponnent

}

getRamdomCharacterByRarity () {
    
    getInFileRamdomValueByRarity $1 hpLink maxLinkHp strLink playerName
}