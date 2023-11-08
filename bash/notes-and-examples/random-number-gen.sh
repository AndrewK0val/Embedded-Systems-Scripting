#!/bin/bash

random_ex()
{
        local Y=4 X=1 MAX=13 NUM=5

        # 10 random numbers between 1 and 4
        for((i = 0; i < 10; i++))
        do
                echo -ne "$((RANDOM%Y+X))\t"
        done

        echo ""
        echo "10 Random Numbers between 0 and 12"
        for((i=0; i < 10; i++))
        do
                echo -ne "$((RANDOM%MAX))\t"
        done

        echo ""
        echo "10 Random number between $NUM and $((NUM+12))"
        for((i=0; i<10; i++))
        do
                CEILING=$NUM+12
                FLOOR=$NUM
                RANGE=$(($CEILING-$FLOOR+1))
                echo -ne "$((RANDOM%RANGE+FLOOR))\t"
        done
}

random_ex  # function call