find . -name '*.png' | while read name
do
	newName=$(echo $name | sed 's/\.png/H\.png/')
	mv $name $newName 
done
