lava-tool auth-list
No tokens found

As admin create a new user e.g. lava/lava@e450-1-kvm-lava-1.res.training

Make sure this user is allowed to submit test jobs.

log in as lava user in the web interface and create a token

Token management page:

http://192.168.42.141/api/tokens/

lava-tool auth-add http://lava@e450-1-kvm-lava-1.res.training/RPC2/
Paste token for http://lava@e450-1-kvm-lava-1.res.training/RPC2/:
Token added successfully for user lava.

lava-tool auth-list
Endpoint URL: http://e450-1-kvm-lava-1.res.training/RPC2/
Tokens found for users: lava

lava@e450-1-kvm-lava-1:~$ lava-tool auth-add http://lava@e450-1-kvm-lava-1/RPC2/
Paste token for http://lava@e450-1-kvm-lava-1/RPC2/: 
Token added successfully for user lava.
lava@e450-1-kvm-lava-1:~$ lava-tool auth-list
Endpoint URL: http://e450-1-kvm-lava-1.res.training/RPC2/
Tokens found for users: lava
------------
Endpoint URL: http://e450-1-kvm-lava-1/RPC2/
Tokens found for users: lava
------------
lava@e450-1-kvm-lava-1:~$ 

------------

#lava-tool auth-config --default-user http://lava@e450-1-kvm-lava-1.res.training/RPC2/
#Auth configuration successfully updated on endpoint http://e450-1-kvm-lava-1.res.training/RPC2/.
#
#lava-tool auth-config --endpoint-shortcut staging http://lava@e450-1-kvm-lava-1.res.training/RPC2
#Auth configuration successfully updated on endpoint http://e450-1-kvm-lava-1.res.training/RPC2.

lava-tool auth-list
Endpoint URL: http://e450-1-kvm-lava-1.res.training/RPC2/
endpoint-shortcut: staging
default-user: lava
Tokens found for users: lava
------------

as root:

lava-server manage device-types list -a
lava-server manage device-types list
lava-server manage device-types add qemu
lava-server manage device-types list

lava-server manage workers list
# maybe already exists
lava-server manage workers add ${HOSTNAME}.res.training
lava-server manage workers list

lava-server manage devices list
lava-server manage devices add --device-type qemu qemu01 --worker ${HOSTNAME}.res.training
lava-server manage devices list

---- 

as root:

lava-server manage devices list
Available devices:
* qemu01 (qemu) Idle

cd /etc/lava-server/dispatcher-config/devices/
wget https://git.linaro.org/lava/lava-lab.git/plain/staging.validation.linaro.org/lava/pipeline/devices/staging-qemu01.jinja2
mv staging-qemu01.jinja2 qemu01.jinja2

----

http://192.168.42.141/scheduler/device/qemu01/devicedict

----

2) enable kvm

lava-server manage device-types list -a | grep kvm
lava-server manage device-types add kvm
lava-server manage device-types list

lava-server manage devices list
lava-server manage devices add --device-type kvm kvm01 --worker ${HOSTNAME}.res.training
lava-server manage devices list


