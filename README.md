# AutoRedox
Scripts for a self-driving lab for corrosion measurements

## Setting up an Opentrons OT2

### Basic setup

1. Unbox, setup and calibrate the robot using their [snappy video guide](https://www.youtube.com/watch?v=nvjNHod-2hU&list=PLEAtiL9W2-TPpKBBsuIBOIeS0grzHj4jM).
    * Use USB connect. We have not tested WiFi connect.
    * We only have one P1000 single channel pipette, which should be installed at the right slot.
2. After doing this, you should be able to drag opentronsdemo.py into the GUI see the robot do a basic manuever.
   
### Giving up the GUI

If you want to work with python, OT2 gives you two options:
    * Jupyter Notebook (experimental feature): You MUST launch the jupyter notebook from the GUI. Go to Devices -> Your Robot -> Settings -> Advanced -> Launch Jupyter Notebook.
    * SSH into the robot, upload your .py file using ```scp```, and then run ```opentrons_execute yourfile.py```
