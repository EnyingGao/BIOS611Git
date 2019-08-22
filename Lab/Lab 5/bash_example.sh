#Create a folder
mkdir foldername

#Download a file
curl url -o filename

#Dealing with compressed file
tar -xf filename
unzip filename

#Take a quick look at the file using head, tail
head -n 20 filename
tail -n 20 filename

#Text editor
vim filename

#moving mulitple files into a folder
mv folder/* targetfolder

#copying file
cp filename pathtotarget
scp username@url:path_to_file path_to_target

#Make file executable
chmod +x filename
