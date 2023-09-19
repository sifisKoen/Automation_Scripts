# Debian Cassandra installation script :bookmark_tabs:

This script makes it easier to install **Cassandra** on **Linux** machines, and it is designed primarily for **Debian-based** distributions. By setting up a particular repository, it also ensures the installation of **Java 8** and fixes a common problem. Please see this [Bug](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=989736) for further details. Finally, the script complete configuring Apache Cassandra.

### Features :open_file_folder:

- Automatic installation necessary dependencies.
- Add required repository for the older version of Java 8 and Apache Cassandra.
- Install Apache Cassandra (version 41x)
- Error handling: the script stops if any step fails. In this case we provide safer installation.

### How to run :gear:

1. Clone the repository
```bash
    git clone https://github.com/sifisKoen/Automation_Scripts.git
    cd Automation_Scripts/Cassandra installation script
```
2. Make the script executable
```bash
    chmod +x cassandra_setup.sh
```
3. Run the script
```bash
    ./cassandra_setup.sh
```

### Post Installation


After successful installation you can use:

- `nodetool status` to check the status of your Cassandra database.
- `cqlsh` to connect to your Cassandra database.

### Contributions :rocket:

Please feel free to contribute, open a new issue or add a new feature. You are more than welcome to contribute. Check the [issue page](https://github.com/sifisKoen/Automation_Stripts/issues) :smiley: 
