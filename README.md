# Cassandra & Hadoop Installation Scripts :bookmark_tabs:

In this repository you can find **posix compliant bash** scripts for automatically installation of **Cassandra** and **Hadoop**. I create this repository for my convenience so to install those tools with no effort. 

### Features :open_file_folder:

- **Automated Installation**: Automate the time-consuming procedures required for manual Cassandra and Hadoop installation with just one run of the script.
- **User Management**: The Hadoop script offers the choice of creating a new user specifically for Hadoop or using an already-existing account.
- **SSH Key Generator**: Hadoop setup includes the creation of SSH keys for smooth node connection.
- **Environment Configuration**: Ensures Hadoop operates without a hitch after installation by setting up crucial environment variables.
- **Error Handling**: When anything goes wrong, the Cassandra script has a built-in error handling system that allows it to gracefully depart and alert the user.

### How to run :gear:

1. Clone the repository
   ```bash
        git clone https://github.com/sifisKoen/Automation_Scripts.git
        cd Automation_Scripts/<the tool you want>/
   ```
2. Make the script executable
    ```bash
        chmod +x <tool name>.sh
    ```
3. Run the script
   ```bash
        ./<tool name>.sh
   ```

### Note ⚠️

- Before running these scripts, make sure you have sudo rights because they need superuser access for a number of activities.
- For distributions based on Debian, both scripts were created. Make sure it is compatible with your particular version..
- Make sure the Cassandra and Hadoop-required ports are open and free before executing the script.

### FAQ ❓

#### What operating system do these scripts support?
- The scripts are made for Linux distributions based on Debian.

#### Can I use the same computer to execute both scripts?
- You can, indeed. However, be sure that the system's RAM and CPU are enough to support running Cassandra and Hadoop concurrently.

### Contributions :rocket:

Please feel free to contribute, open a new issue or add a new feature. You are more than welcome to contribute. Check the [issue page](https://github.com/sifisKoen/Automation_Stripts/issues) :smiley: 


### License 📜

his project is licensed under the GNU GENERAL PUBLIC LICENSE - see the [LICENSE](./LICENSE) file for details.