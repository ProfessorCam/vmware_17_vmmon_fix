# vmware_17_vmmon_fix
If you're running Ubuntu 22.04 with Secure Boot on and receive an error running VMware related to vmmon. Shea Bennett provided the code to repair this. In short, you need to:
  1. Create a digital “signature” for VMware.
  2. Mark VMware's vmmon and vmnet as safe.
  3. Verify that vmmon part has been successfully marked as safe.
  4. Tell your computer that anything signed with this signature is safe to use.

Fixing the vmmon issue with VMware 17.x.x on Ubuntu 22.04 . 
Code is thanks to Shea Bennett -> [YouTube Channel for Shea Bennett](https://www.youtube.com/watch?v=xOnrdMQd1vU)
