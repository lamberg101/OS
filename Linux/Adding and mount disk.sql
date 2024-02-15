--add new disk
fdisk -l
fdisk -a
fdisk /dev/sdb
parted -l
lsblk

--fromat
fdisk -uc /dev/sdb
then m --to list all the commands
then p --to check the partition 
then n --for new partition
then p --for primary
then press enter 2x to use the whole disk
then p --to check again
then w --to write or save

--then check using bellow
lsblk
fdisk
fdisk -l

--make filesystem (can use ext4) 
mkfs.ext4 /dev/sdb1 --the patition name not the disk

--create dir in / or any other directory
mkdir /bram

--mount the filesystem
mount /dev/sdb1 /bram/
lsblk

--to make it permanent
vi /etc/fstab 
/dev/sdb1 (disk name)   /bram/ (dir name)       ext4 (fs name)      defaults         1       2

--to check
umount /bram/
reboot
df -kh



