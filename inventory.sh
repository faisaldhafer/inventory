#!/bin/bash

items=(Orange Apple Banana Guava Mango Papaya Grapes)
stocks=(14 27 20 17 34 16 21)
prices=(5 7 4 6 8 10 6)



Econtinue () {
	echo
	read -p "Press Enter key to Continue.."
}

chioce1 () {
	echo
	echo "Name	Stock Quantity		Price"
	for i in ${!items[*]}
	do
		echo ${items[i]}"		"${stocks[i]}"		"${prices[i]}
	done
	Econtinue
}

chioce2 () {
	echo
	check=-1
	echo "Enter fruit name: "
	read fruit
	for i in ${!items[*]}
	do
		if [ ${fruit^^} = ${items[i]^^} ]
		then
			check=$i
		fi
	done
	if [ $check -eq -1 ]
	then
		echo "Error: No such fruit"
		Econtinue
	else
		echo "Name      Stock Quantity          Price"
		echo ${items[$check]}"                "${stocks[$check]}"           "${prices[$check]}
		Econtinue
	fi
}

chioce3_A () {
	echo
	echo "Available stock for "${items[$check]}" is "${stocks[$check]}
	echo "Enter new stock quantity:"
	read newStock
	if [ $newStock -lt 0 ]
	then
		echo "Error: Negative stock quantity:"
		Econtinue
	else
		stocks[$check]=$newStock
		echo
		echo "Stock Quantity update for this item done"
		Econtinue
	fi
}

chioce3_B () {
	echo
	echo "Current unit price for "${items[$check]}" is "${prices[$check]}
	echo "Enter new unit price:"
	read newPrice
	if [ $newPrice -le 0 ]
	then
		echo "Error: Negative unit price"
		Econtinue
	else
		prices[$check]=$newPrice
                echo
                echo "Unit price update for this item done"
		Econtinue
        fi
}

chioce3 () {
	echo
	check=-1
	echo "Enter fruit name: "
	read fruit
	for i in ${!items[*]}
	do
		if [ ${fruit^^} == ${items[i]^^} ]
		then
			check=$i
		fi
	done
	if [ $check -eq -1 ]
	then
		echo "Error: No such fruit"
		Econtinue
	else
		echo
		echo "1. Modify stock quantity"
		echo "2. Modify unit price"
		echo
		echo "please select your chioce:"
		read chioce
	fi
	case $chioce in
		1) chioce3_A ;;
		2) chioce3_B ;;
	esac
}

chioce4 () {
	echo
	check=-1
	echo "Enter fruit name:"
	read fruit
	for i in ${!items[*]}
	do
		if [ ${fruit^^} == ${items[i]^^} ]
		then
			check=$i
		fi
	done
	if [ $check -ge 0 ]
	then
		echo "Error: fruit already exist"
		Econtinue
	else
		echo "Enter stock quantity:"
		read newStock
		echo "Enter unit price:"
		read newPrice
		items=(${items[@]} $fruit)
	        stocks=(${stocks[@]} $newStock)
	        prices=(${prices[@]} $newPrice)
		echo "New item Added"
		Econtinue
	fi
}

chioce5 () {
	echo
	check=-1
	echo "Enter fruit name:"
	read fruit
	for i in ${!items[*]}
        do
                if [ ${fruit^^} == ${items[i]^^} ]
                then
                        check=$i
                fi
        done
	if [ $check -eq -1 ]
	then
		echo "Error: No such fruit"
		Econtinue
	else
		unset items[$check]
		unset stocks[$check]
		unset prices[$check]
		echo "Item deleted"
		Econtinue
	fi
}

chioce6 () {
	echo
	check=-1
	again='y'
	total=0
	until [ $again == 'n' ] || [ $again == 'N' ]
	do
		echo "Enter fruit name: "
		read fruit
		for i in ${!items[*]}
        	do
	       	        if [ ${fruit^^} == ${items[i]^^} ]
        	        then
        	                check=$i
        	        fi
        	done
		if [ $check -eq -1 ]
		then
			echo "Error: No such fruit"
			echo "Do you want buy another item (Y/N):"
			read again
			continue
		else
			echo "Enter number of items required:"
			read stock
			if [ $stock -gt ${stocks[$check]} ]
			then
				echo "Insufficient stock. Stock availble is "${stocks[$check]}
				echo "Do you want buy another item (Y/N):"
				read again
				continue
			else
				subtotal=$(( ${prices[$check]} * $stock ))
				echo "Fruit	Quantity	Unit Price(SAR)		Subtotal(SAR)"
				echo $fruit"	   "$stock"			"${prices[$check]}"		"$subtotal
				total=$(( $total + $subtotal ))
				stocks[$check]=$(( ${stocks[$check]} - $stock ))
				echo
				echo "Do you want buy another item (Y/N):"
                                read again
				continue
			fi
		fi
	done
	echo "Total:						"$total
	Econtinue
}

chioce=0
until [ $chioce = 7 ]
do
	echo
	echo "1. Display Stock Info for all Items"
	echo "2. Display Stock Info for Particular Item"
	echo "3. Update Stock Info for Particular Item"
	echo "4. Add new Item"
	echo "5. Delete Item"
	echo "6. Sell item to Costomer"
	echo "7. Exit"
	echo
	echo "Please select your chioce:"
	read chioce

	case $chioce in
		1) chioce1 ;;
		2) chioce2 ;;
		3) chioce3 ;;
		4) chioce4 ;;
		5) chioce5 ;;
		6) chioce6 ;;
	esac
done
