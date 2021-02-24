Using SSH to connect to your Jetstream instance
---

Watch 0:00 to 3:09. Then you can jump ahead to 9:20 if you don't want to sit and watch the instance deploy 
<center>
<video width=100% height="500" controls>
  <source src="pics/zoom_0.mp4" type="video/mp4">
</video>

### Before you launch an instance, go to PuTTygen

<img src="pics/puttygen.JPG" class="img-responsive" alt="">

## Select generate and move your mouse over the putty window to make it load faster
## Once the key is generated you should see it in the box (highlited in blue in the picture below)
## Highlight and copy the key

<img src="pics/key.JPG" class="img-responsive" alt="">

## Navigate to the Jetstream page, and log in

Navigate to https://use.jetstream-cloud.org/

<img src="pics/one.png" class="img-responsive" alt="">

### Login using your XSEDE credentials

<img src="pics/two.png" class="img-responsive" alt="">

### Type your stuff in, and select "SIGN IN"

<img src="pics/three.png" class="img-responsive" alt=""> 


### To go to settings, click on your user name.

<img src="pics/twelve.png" class="img-responsive" alt="">

## Click "Show More"

<img src="pics/thirteen.png" class="img-responsive" alt="">

## Click "plus sign", enter details
Name the key "jetkey", and paste in key using `command-v`. then click confirm.

<img src="pics/fourteen.png" class="img-responsive" alt="">


### If you sit at the same computer each time, or use your personal laptop, you *should* not need to make a new key again.


## Go back to PuTTygen:

Select "save private key"  
Select "yes" in the warning box
and save it to a place you will be able to find on your computer.

<img src="pics/save_key.JPG" class="img-responsive" alt="">

## Close PuTTYgen and open PuTTY
Highlight "Default Settings"

<img src="pics/putty1.JPG" class="img-responsive" alt="">

Select "+SSH" and then "Auth"

<img src="pics/putty2.JPG" class="img-responsive" alt="">

Click "Browse..." and add the key that you saved locally on your computer

<img src="pics/putty3.JPG" class="img-responsive" alt="">

Slelect "Sessions"

<img src="pics/putty4.JPG" class="img-responsive" alt="">

Make sure "Default Settings" is highlighted by clicking on it and then press save

<img src="pics/putty5.JPG" class="img-responsive" alt="">

Add your IP address as the host name and then click open

<img src="pics/putty6.JPG" class="img-responsive" alt="">

In your terminal that just opened type only your username and press enter!
Congrats you did it!! For all future instances you will only need your IP address 
