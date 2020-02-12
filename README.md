# Trello API Project
This project allows to test Trello application using Behave.

##Prerequisites
For the correct functioning of the work environment, the following programs need to be installed:
* Windows Environment: Server 2019 Standard.
* Google Chrome version 79.0.3945.130

##Installing
To start setting up the environment with BDD (Behavior Driven Development).
* Install [Python 3.8.1](https://www.python.org/downloads/)
* Install PyCharm 2019.3.2 (Professional Edition) 
* Install Git version 2.21.0.windows.1

## Configuration
This project was intended to work with python 3.8.1 A list of required libraries can be found on "requirements.txt" 
file.
* behave interpreter in PyCharm.
* requests
* jsonschema
* Pytest to write unit tests.

This means all required libraries can be installed from the project path using:
```bash 
pip install -r requirements.txt
```
To finish this configuration we need add Pytest in Python Integrated Tool follow the next steps:

Go File -> Settings -> Tools -> Python Integrated Tools and in Testing field in Default test runner select pytest option.  

## About the Project
On the 'core' folder we intend to put generic steps and functions that can be used on any API testing. 
We also included a generic API request class, this class can be inherited to customize request options.

To configure the project to run the features is necessary access to config.json file and add the respective credentials 
in this file in the following fields:
```
key:
token:
```
This fields is fill with the key and token provided in Trello API documentation.

## Execution
To execute this project we are focus on the features, to run any scenario we proceed to select the feature directory 
and select any feature, right click in the feature file and click in Run.

To run with command line write the following in command line:
```bash
behave trello/api/features/<Test_directory>/<file_feature>.feature
```