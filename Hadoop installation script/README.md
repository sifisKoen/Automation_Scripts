# Hadoop installation script


## Hadoop Installation Script :bookmark_tabs:

This script install Hadoop and setting up the Hadoop Environment for **Linux** system (In this case **Debian** base systems).
The script install **Java**, creates a new user for Hadoop, create a SSH key for the new use, downloads and extract Hadoop, and finally configure the environment for Hadoop.

### Features :open_file_folder:

- Java automated installation.
- Optional creation of a new user specifically for Hadoop.
- Creating a new SSH key for the Hadoop user.
- Automate download and extract Hadoop.
- Configure Hadoop environment variables.

### How to run :gear:

1. Clone the repository
   ```bash
        git clone https://github.com/sifisKoen/Automation_Stripts.git
        cd Automation_Scripts/Hadoop installation script
   ```
2. Make the script executable
    ```bash
        chmod +x hadoop_setup.sh
    ```
3. Run the script
   ```bash
        ./hadoop_setup.sh
   ```

### Note

- During the installation process you will get asked if you want to create a new user for the installation of Hadoop. It's not mandatory but it's recommended.
- If you want to create a new user you will be asked to create a new password for that user.
- In this scrip we download the Hadoop version `3.2.4`. If you need another version, you can just modify the script accordingly. You just need to change the `download_and_extract_hadoop` function.


### Contributions :rocket:

Please feel free to contribute, open a new issue or add a new feature. You are more than welcome to contribute. Check the [issue page](https://github.com/sifisKoen/Automation_Stripts/issues) :smiley: 

