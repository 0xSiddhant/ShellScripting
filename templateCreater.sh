#! /bin/bash

echo "Enter Project Name: "
read projectName

mkdir $projectName #root folder
cd $projectName
touch index.html
echo "HTML file created"

echo "Do you want MVVM or MVC"
read arch

if [arch == "MVVM"]
then
    mkdir model
    mkdir viewModel
    mkdir controller
else 
    mkdir model
    mkdir views
    mkdir controller
fi
echo "$arch directories Created"

mkdir static
cd static
mkdir css
cd css
touch main.css
cd ..
mkdir img
mkdir js
cd js
touch main.js
cd ..

echo "Static Files Generated"

echo "Template Created Successfully"