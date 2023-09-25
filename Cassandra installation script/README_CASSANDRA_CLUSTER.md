
# Create a Cassandra cluster :desktop_computer:


This guid is only if you  want to set up your **Cassandra cluster** in Virtual machines.

> I suggest to use **Virtual Box**.

And we will suppose that you have created socket for your Vms to connect with each other.

### Add Static IP to your Vms 🌐

First of all we need add **static IPs** to our machines. 

It's very easy, first you need to be sure that your Vms users have sudo privileges.

> If they don't have follow this link. [Sudoers](https://www.tecmint.com/fix-user-is-not-in-the-sudoers-file-the-incident-will-be-reported-ubuntu/)

Then you need to check your network sockets so to go and add it the static IP. Using this command `ip a` you will be able to see all your sockets. In from this step you need to identify witch socket it's the socket where your VMs will communicate with each other. (Usually it's something like `enp0s3` or `enp0s8`)

Now we need to make some changes to our `network interfaces`. Using your favorite command line editor go to `/etc/network/interfaces` and using `sudo` privileges make some changes.

For example.
`sudo vim /etc/network/interfaces`

Now that you are in the `interfaces` file you need to add these lines. (Make sure you adjust the sockets with your correct sockets, and the make sure that you have the correct IP address and netmask).

```
auto enp0s3
iface enp0s3 inet static
address 192.168.57.101
netmask 255.255.255.0
```

Finally we need to restart the `network service` so to make our `interfaces` take place.

Execute this command:
`sudo service networking restart`

Now if you run again the `ip a` command you will be able to see your static IP in the specific socket.

---

## Configure Cassandra

Now that we have configure our static IPs in our Vms, we need to configure our **Cassandra instances** so to create our cluster. 

> Before we start our configuration I suggest to `stop` Cassandra service using this command `sudo service cassandra stop`.

### Cassandra YAML

Simple we need to configure the `cassandra.yaml` file, this file is the configuration file for the **Cassandra**. Usually this file is under `/etc/cassandra` directory (in this directory you will find more cassandra files).

So now we need to configure this file. We just need to open this file again with one command line editor, using **sudo** privilege.

`sudo vim /etc/cassandra/cassandra.yaml`

> It's a big file with a lot of lines don't worry we will configure some of them. 😃 If you want to read more about this file you can visit the [Cassandra Documentation](https://cassandra.apache.org/doc/latest/cassandra/configuration/cass_yaml_file.html). It is suggested to visit this page so you will be able to read and understand what you can do with this file but also with all other functionalities that Cassandra provides.

#### Caution 🚨 
This file is very sensitive you need to be sure what are you changing. 

Now that we opened the `cassandra.yaml` file we need to go to `seeds` field. 

### Seeds

> In vim you can search using `esc` and `/` and then the word you want to search.

There you will see something like:

```yaml
- class_name: org.apache.cassandra.locator.SimpleSeedProvider
        parameters:
          # seeds is actually a comma-delimited list of addresses.
          # Ex: "<ip1>,<ip2>,<ip3>"
          - seeds: "127.0.0.1:7000"
```
From here we need to change the `127.0.0.1:7000` adding our VMs **static IPs** from before. You need to have something like this: `- seeds: "192.168.57.101,192.168.57.102,192.168.57.103"`.

### Listen_address

Our next stop is the `listen_address` field where we need to add our VM's IP.
You need to have something like this: `listen_address: 192.168.57.101`.

## Final step

Now that we have finished our `Cassandra` configuration in our VMs we need to `restart` or `start` our Cassandra in our VM. 

If you **stopped** the Cassandra you need to run `sudo service cassandra restart`. If you didn't `stop` your Cassandra you will need to run `sudo service cassandra restart`.

Now you should be able to see your **cluster** with your VMs. You should be able to see something like this:
```
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address         Load        Tokens  Owns (effective)  Host ID                               Rack 
UN  192.168.57.102  263.66 KiB  16      69.4%             a269ffa3-cf95-472c-b310-d4c7c3f0bb31  rack1
UN  192.168.57.103  175.03 KiB  16      60.0%             86ab104a-adf4-40bf-a731-2d6bedd0bf99  rack1
UN  192.168.57.101  210.27 KiB  16      70.7%             ab29ecaf-8760-4857-b53b-6e3baa6deece  rack1
```

> UN means Up and Running.

## Troubleshooting

If you can not see a table like above you should probably have in issue with your configuration. To examine what is wrong with your cluster you can just go to `/var/log/cassandra/` and read the `system.log`. You can just run this command: `cat /var/log/cassandra/system.log`. Here you will be able to see what is happening with your cluster and your Cassandra instance.