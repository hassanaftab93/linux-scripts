
# Linux - Scripts

<!-- --- DEPLOYMENT STATUS CODE ---

<-------------------------------------------------------------------------------------------------->
<!--
Deployment Status: [![Deploy to Heroku](https://github.com/hassanaftab93/REPO-NAME/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/hassanaftab93/REPO-NAME/actions/workflows/main.yml)

-->
<!-- --- FORMAT OF MARK DOWN WITH COLLAPSIBLE MENU ---
<details>
  <summary>
    <h2>
      
    </h2>
  </summary>

</details>
-->
<!---------------------------------------- SECTION DIVIDER ---------------------------------------->
<details>
  <summary>
    <h2>
      🛠 Kali Linux
    </h2>
  </summary>

  LINKS:

- Kali Linux Installation: https://www.geeksforgeeks.org/how-to-replace-ubuntu-with-kali-linux/
- Kali Linux Documentation: https://www.kali.org/docs/
- Kali Linux: https://www.kali.org/

</details>

<!---------------------------------------- SECTION DIVIDER ---------------------------------------->

<details>
  <summary>
    <h2>
      📑 Linux lid closing problem
    </h2>
  </summary>

  Step 1: Open the file logind.conf
    
  ```bash
      sudo gedit /etc/systemd/logind.conf
  ```

  Step 2: Change the following to these values
    
  ```bash
      HandleSuspendKey=lock
      HandleHibernateKey=lock
      HandleLidSwitch=lock
      HandleLidSwitchExternalPower=lock
  ```

  Step 3: Run this command
    
  ```bash
      sudo systemctl restart systemd-logind.service
  ```

</details>

<!---------------------------------------- SECTION DIVIDER ---------------------------------------->

<details>
  <summary>
    <h2>
      📑 Make these scripts executable
    </h2>
  </summary>

  Step 1: Give executable rights to all scripts
    
  ```bash
      cd /baseDirectory/of/Project
      cd ./scripts
      chmod +x ./**/*
  ```
</details>

<!---------------------------------------- SECTION DIVIDER ---------------------------------------->
<details>
  <summary>
    <h2>
      📑 Install Ansible
    </h2>
  </summary>

  Step 1: Run ansible.sh
    
  ```bash
      ./install/ansible.sh
  ```
</details>

<!---------------------------------------- SECTION DIVIDER ---------------------------------------->
<details>
  <summary>
    <h2>
      📑 Install Terraform
    </h2>
  </summary>

  Step 1: Run terraform.sh
    
  ```bash
      ./install/terraform.sh
  ```
</details>

<!---------------------------------------- SECTION DIVIDER ---------------------------------------->
<details>
  <summary>
    <h2>
      📑 Download Wallpaper Script
    </h2>
  </summary>

  Step 1: Make a directory 'Pictures/Wallpapers' in Home Directory (if it does not exist)
    
  ```bash
      cd ~
      sudo mkdir Pictures
      cd Pictures
      mkdir Wallpapers
      cd Wallpapers
  ```
  Step 2: Download the script using the command below or [Click Here](./scripts/download-wallpaper.sh)

  ```bash
    curl -o download-wallpaper.sh https://raw.githubusercontent.com/hassanaftab93/linux-scripts/main/scripts/utility/download-wallpaper.sh
  ```
  Step 3: Give execute permissions to the script
  
  ```bash
    chmod +x ./download-wallpapers.sh
  ```
  Step 4: Run the script and pass the URL to the image file/wallpaper you want to download
  
  ```bash
    ./download-wallpapers.sh https://url_to_image
  ```
</details>

<!---------------------------------------- SECTION DIVIDER ---------------------------------------->
<details>
  <summary>
    <h2>
      📚 Contributing
    </h2>
  </summary>

  Click here to learn more about: [Contributions](./docs/CONTRIBUTING.md)
</details>

<!---------------------------------------- SECTION DIVIDER ---------------------------------------->
<details>
  <summary>
    <h2>
      ✒️ Author
    </h2>
  </summary>

  <!--
  Add More Contributors/Authors here using the following line of code:
  - [@username](https://www.github.com/username)
  -->

  - [@hassanaftab93](https://www.github.com/hassanaftab93)

</details>

<!---------------------------------------- SECTION DIVIDER ---------------------------------------->
<details>
  <summary>
    <h2>
      🔗 Links
    </h2>
  </summary>

<!--

  Add your links here in the table below:
  Remove my Table and use your own links.

  |Type|Link|
  |:--:|:--:|
  |Portfolio| PORTFOLIO_LINK_HERE |
  |LinkedIn| LINKEDIN_LINK_HERE |

-->

  |Type|Link|
  |:--:|:--:|
  | Portfolio | [![portfolio](https://img.shields.io/badge/my_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://linktr.ee/hassanaftab) |
  | LinkedIn | [![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/hassanaftab93/) |
</details>

<!---------------------------------------- SECTION DIVIDER ---------------------------------------->

