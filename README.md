# robotframework_rpa_example

1. Install pip first
    
    sudo apt-get install python3-pip

2. Then install virtualenv using pip3
  
    sudo pip3 install virtualenv 

3. Now create a virtual environment
  
    virtualenv rpa

4. Activate virtual environment
  
    source rpa/bin/activate

5. Install library from requirements.txt
  
    pip install -r requirements.txt

6. Run Robot command
  
    robot --variable search_for:"mirrorless camera" rpa_example.robot
