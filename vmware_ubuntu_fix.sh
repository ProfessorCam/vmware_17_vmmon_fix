#Advanced - This command generates a new private key (VMWARE17.priv) and a self-signed certificate (VMWARE17.der) using OpenSSL. The certificate is valid for 36500 days (about 100 years) and has a common name (CN) of “VMWARE”.
#Simpler -  This command creates a new private key and a certificate. These are like a special kind of password that will be used to “sign” the VMware modules. This tells your computer that these modules are safe to use.
openssl req -new -x509 -newkey rsa:2048 -keyout VMWARE17.priv -outform DER -out VMWARE17.der -nodes -days 36500 -subj "/CN=VMWARE/"

#Advanced - This command signs the vmmon kernel module using the private key and certificate generated in the previous step. The sign-file script is part of the Linux kernel source and uses the SHA-256 hash algorithm.
#Simpler - This command uses the key and certificate to sign the `vmmon` module. This is like putting a safety seal on the module.
sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./VMWARE17.priv ./VMWARE17.der $(modinfo -n vmmon)

#This command signs the vmnet kernel module, similar to the previous step. It does the same thing as the previous step, but for the `vmnet` module.
sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./VMWARE17.priv ./VMWARE17.der $(modinfo -n vmnet)

#Advanced - This command checks if the vmmon module has been successfully signed by looking for the “Module signature appended” string in the module information.
# Simpler - This command checks if the `vmmon` module has been successfully signed. It’s like checking if the safety seal is in place.
tail $(modinfo -n vmmon) | grep "Module signature appended"

#Advanced - This command imports the certificate into the system’s Machine Owner Key (MOK) database. This allows the system’s Secure Boot feature to recognize the signed modules as trusted.
#Simpler - This command adds the certificate to a list of trusted certificates on your computer. This is like telling your computer that modules signed with this certificate are safe to use.
sudo mokutil --import VMWARE17.der

#This is often used after updating the kernel on a Linux system running VMware Workstation. The command rebuilds and reinstalls all VMware kernel modules. It’s useful if VMware Workstation stops functioning after a kernel update.
sudo vmware-modconfig --console --install-all
