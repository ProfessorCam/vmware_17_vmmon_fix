#This command generates a new private key (VMWARE17.priv) and a self-signed certificate (VMWARE17.der) using OpenSSL. The certificate is valid for 36500 days (about 100 years) and has a common name (CN) of “VMWARE”.
openssl req -new -x509 -newkey rsa:2048 -keyout VMWARE17.priv -outform DER -out VMWARE17.der -nodes -days 36500 -subj "/CN=VMWARE/"

#This command signs the vmmon kernel module using the private key and certificate generated in the previous step. The sign-file script is part of the Linux kernel source and uses the SHA-256 hash algorithm.
sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./VMWARE17.priv ./VMWARE17.der $(modinfo -n vmmon)

#This command signs the vmnet kernel module, similar to the previous step.
sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./VMWARE17.priv ./VMWARE17.der $(modinfo -n vmnet)

#This command checks if the vmmon module has been successfully signed by looking for the “Module signature appended” string in the module information.
tail $(modinfo -n vmmon) | grep "Module signature appended"

#This command imports the certificate into the system’s Machine Owner Key (MOK) database. This allows the system’s Secure Boot feature to recognize the signed modules as trusted.
sudo mokutil --import VMWARE17.der
