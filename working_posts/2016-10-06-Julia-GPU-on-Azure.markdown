---
layout: post
title:  "GPU computing in Julia using AWS"
date:   2016-10-06 
categories: jekyll update
---

## Introduction 
[https://aws.amazon.com/blogs/aws/new-p2-instance-type-for-amazon-ec2-up-to-16-gpus/ Amazon Web Services (AWS) finally has GPUs!]



## Outline 

# Setting up an AWS account

- Make an Amazon account if you don't already have one. 
- Sign up. $100 credit for students. 
- You can set up two factor authentication for added security. 
- You may also want to set up Identity and Access Management (IAM), especially if multiple users will have access to your account. 





# Spinning up a virtual machine 
- Go to console.aws.amazon.com and sign in. 
- Select a region to work in at the top right. I like to use Ireland (eu-west-1) since I find it often has cheaper spot prices than my closest regions (Northern California or Oregon), and latency is typically not a problem for the type of work I do. 
- From the console select "EC2" under the "Compute" heading. 
- Select "Instances" from the left menu then "Launch Instance."
- Now we will get an Amazon Machine Image (AMI) started. 

- 1. Choose AMI: 
-- From the menu on the left under "Quick Start" find "Ubuntu Server 14.04 LTS (HVM)" and hit "Select"

- 2. Choose Instance Type: 
-- To set up a machine image, we will select the cheapest option: GPU compute "p2.xlarge." We can choose a more powerful machine later. 
-- Hit Next: Configure Instance Details

- 3. Configure Instance: 
-- To save on costs, we'll use a spot instance. This type of instance can be cancelled if we are outbid by others wishing to use this type of machine, but is significantly cheaper than dedicated instances. Enter the maximum price you're willing to pay. The current spot prices are listed for comparison. Put in a price higher than all the current prices. You will only be charged the (changing) spot price. But if the spot price grows higher than your Maximum price, your instance will be cancelled. I'll use 0.25. 
-- If you're using Identity and Access Management for added security, select the appropriate IAM role (or leave as "None" if you don't know what I'm talking about). 

- 4. Add Storage: 
-- We'll up this to 60 GB. 

- 5. Tag Instance:
-- Can ignore. 

- 6. Configure Security Group: 
-- Under "Type" change to "All TCP." Under "Source" change to "My IP."
-- Hit "Review and Launch."

- 7. Review: 
-- Review your spot instance request. If everything looks alright, hit launch. 

- Now we will generate a key pair to allow you to connect to your instance securely. From the menu select "Create a new key pair." Then choose a key pair name. I will use "aws_gpu_tutorial". Now hit "Download Key Pair" to download the private key. Put the key you downloaded somewhere safe. 

 - Hit "Request Spot Instances!"





 # Connecting to your machine 

 - Click "View Spot Requests"
 - If all went well you should see an instance with status "fulfilled" and state "active (with a green dot)." It may take a couple of minutes to reach this state. 
 - Click on "Instanes" from the left menu. 
 - Select the instance you just created to see a description of the instance below.  
 - Copy the public DNS to the clipboard as we will need it to connect to the machine. 

 - Open a terminal window and navigate to the directory where you saved your private key. 
 - Change the permissions for your private key: chmod 400 aws_gpu_tutorial.pem 
 - Connect to the instance via SSH using the identity aws_gpu_tutorial.pem and user name ubuntu. For example: ssh -i aws_gpu_tutorial.pem ubuntu@ec2-54-171-128-22.eu-west-1.compute.amazonaws.com (but replace ec2-54-171-128-22.eu-west-1.compute.amazonaws.com with the public DNS you just copied.)
 - You will get a message that the authenticity of host can't be established. This is fine. Type "yes" to continue. 
 - Great! You're connected now. 







 # Install Tesla GPU drivers (not sure if this is necessary)

 - Add proprietary drivers PPA: sudo add-apt-repository ppa:graphics-drivers/ppa
 - Update the package manager: sudo apt update 
 - Install the driver : sudo apt install nvidia-352

 # Install Preliminaries  

 - sudo apt-get update
 - sudo apt-get install libfreeimage-dev libatlas3gf-base libfftw3-dev cmake
 - sudo apt-add-repository ppa:keithw/glfw3
 - sudo apt-get update
 - sudo apt-get install libglfw3-dev 

 # Install CUDA 
 - wget "http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/cuda-repo-ubuntu1404_7.5-18_amd64.deb"
 - sudo dpkg -i cuda-repo-ubuntu1404_7.5-18_amd64.deb
 - sudo apt-get update
 - sudo apt-get install cuda 

 # Install OpenCL (not necessary)
 - sudo apt-get install ocl-icd-libopencl1

 # Install ArrayFire 
 - wget "http://arrayfire.com/installer_archive/3.4.0/ArrayFire-v3.4.0_Linux_x86_64.sh"
 - chmod +x ArrayFire-v3.4.0_Linux_x86_64.sh
 - sudo ./ArrayFire-v3.4.0_Linux_x86_64.sh --exclude-subdir --prefix=/usr/local

 # Test ArrayFire install
 - sudo apt-get install build-essential cmake-curses-gui git
 - git clone https://github.com/arrayfire/arrayfire-project-templates.git
 - cd arrayfire-project-templates/CMake/build
 - cmake ..
 - make



## Thanks: 
- [http://arrayfire.org/docs/installing.htm#Ubuntu]
