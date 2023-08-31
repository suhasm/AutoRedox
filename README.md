# AutoRedox
Scripts for a self-driving lab for corrosion measurements

## Setting up an Opentrons OT2

This is written from the perspective of a Windows 11 Pro machine (Lenovo P14s). Procedure is similar for mac and linux, except for [minor variation in SSH procedure.](https://support.opentrons.com/s/article/Setting-up-SSH-access-to-your-OT-2)

### Basic setup

1. Unbox, setup and calibrate the robot using their [snappy video guide](https://www.youtube.com/watch?v=nvjNHod-2hU&list=PLEAtiL9W2-TPpKBBsuIBOIeS0grzHj4jM).
    * USB is recommended. We haven't tested WiFi connect.
    * We only have one P1000 single channel pipette, which should be installed at the right slot.
2. After doing this, you should be able to drag opentronsdemo.py into the GUI see the robot do a basic manuever.
   
### Giving up the GUI

* If you want to work with python, OT2 gives you two options (AFAIK):
    * Jupyter Notebook: You MUST launch the jupyter notebook from the GUI. Go to Devices -> Your Robot -> Settings -> Advanced -> Launch Jupyter Notebook. This is still termed experimental.
    * SSH into the robot, upload your .py file using ```scp```, and then run ```opentrons_execute yourfile.py```. This is expected to work better for SDLs as it can be integrated into a script-based loop and will not error out because of communication issues.

### Running Recipes with SSH

#### One Time Setup of SSH Access

* Note down your robot's wired ip from the GUI: Devices -> Your Robot -> Settings -> Networking. It may be something like ```169.254.198.106```.
    * You may need to note this down again later while SSHing as robot IP address may change.
* Make sure OpenSSH is installed: Settings --> Apps --> Optional Features
* In PowerShell, run ```ssh-keygen -f ot2_ssh_key```. [Opentrons' advice](https://support.opentrons.com/s/article/Setting-up-SSH-access-to-your-OT-2)
    * The program will ask you to choose a passphrase. You will use this passphrase later when you connect to your OT-2 over SSH. You may leave it blank.
    * If you lose this passphrase, you won't be able to recover it, and you'll have to start this guide all over to connect to your OT-2.
    * Two files will have been created in your home directory: ot2_ssh_key, which will stay on your computer. ot2_ssh_key.pub, which will be copied onto your OT-2. Before continuing, make sure those files exist. Enter: ```cat ot2_ssh_key.pub```
* Upload the key to your robot using this command, after replacing ROBOT_IP with your robot's IP: ```@{key = Get-Content ot2_ssh_key.pub | Out-String} | ConvertTo-Json | Invoke-WebRequest -Method Post -ContentType 'application/json' -Uri ROBOT_IP:31950/server/ssh_keys```

  #### SSHing in, uploading recipes and running it.

  * SSH in using ```ssh -i ot2_ssh_key root@ROBOT_IP```. You should see the OT2 logo in as ASCII art, and a # prompt. [Opentrons' advice on SSHing in](https://support.opentrons.com/s/article/Connecting-to-your-OT-2-with-SSH)
  * If you type in ```whoami``` you should see the ouput ```root```. If you type in ```touch myfile.txt``` and then ``ls``, you should see that the file has been created.
  * Upload your recipe file (```opentronsdemo.py``` in our case) to the robot using ```scp``` in PowerShell: ``` scp -i ot2_ssh_key "C:\Users\jaehs\Documents\Code\Opentrons Jehad\opentronsdemo.py" root@ROBOT_IP:/data```. Don't forget to replace ROBOT_IP with the robot's IP.
      * Your key must be in the current directory. 
      *  The root in OT2 appears to be read-only; ```scp``` doesn't work. Copy to /data instead. [Opentrons' Instructions] (https://support.opentrons.com/s/article/Copying-files-to-and-from-your-OT-2-with-SCP)
   *  Navigate to data: ``` cd /data```. Make sure your file's there: ```ls```
   *  Run the recipe: ```opentrons_execute opentronsdemo.py```
   *  The robot should now pick up a 1000uL tip from slot 2 and drop it in the trash bin.
