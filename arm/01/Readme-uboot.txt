README for FriendlyARM Tiny4412

˵������u-bootԴ����������ԭ���ṩ����������֮���޸���ֲ����������Tiny4412������ƽ̨��
����Ƕ��ʽ������ѧϰ�о�֮�ã�����֮�۲��Դ��ṩ�κμ���֧�ֺ�ά����

-----------------------------------------------------
1. Build uboot

a) ��װ��toolchain (arm-linux-gcc-4.5.1-v6-vfp-20120301.tgz)�����ú�
   ��������PATH����֤��������ʹ�á�

b) ��ѹ uboot_tiny4412-20130729.tgz ��������Ӧ��Ŀ¼
   tar xzf uboot_tiny4412-20130729.tgz

c) ���� uboot ������
   cd uboot_tiny4412
   make tiny4412_config
   make

d) ���� ��������bl2 �Ĺ���
   make -C sd_fuse
   ����
   cd sd_fuse; make


-----------------------------------------------------
2. �������� Tiny4412 ��SD��

a) ��׼��һ��4G�����ϵ�SDHC��
   ע�⣺�ÿ����������ݽ��ᱻ�ƻ���������ȶ�SD���ϵ����ݽ��б��ݡ�

b) fusing SD card
   ����SD���ѱ�PC Linuxʶ��Ϊ/dev/sdb, ��root�û�������������ɣ�
   cd sd_fuse/tiny4412
   ./sd_fusing.sh /dev/sdb


-----------------------------------------------------
3. ʹ��SD������ Tiny4412 ����дAndroid

a) ���Ѿ������õ�SD���嵽 Tiny4412 ���ϣ�����S2�л���SDBOOT��ͬʱ����
   �����ߵ�PC�Ҽ����Ѿ�׼���á�

b) ������ӵ磬Ȼ���ڴ��ڿ���̨(��minicom)�������������uboot ������ģʽ

c) ��SD�����з���
   ��������uboot����ɶ�SD�����з�����
   fdisk -c 0 320 806 518
   ���·����󣬿����¸�ʽ��FAT����
   fatformat mmc 0:1

d) ����fastbootģʽ����дAndroid
   ʹ��USB������Tiny4412��MICRO_USB�ڵ�PC��Ȼ����������uboot����:
   fastboot

e) ��д Android ��SD��
   ������׼����Android image������: zImage, ramdisk-u.img, system.img
   ��PC�������������������д:
   fastboot flash kernel zImage              (��дkernel)
   
   fastboot -w                               (��ʽ��userdata��cache)
   
   fastboot flash ramdisk ramdisk-u.img      (��дramdisk)
   
   fastboot flash system system.img          (��дsystem)

f) Ҳ������PC��ͨ��fastboot��дuboot��SD��
   ���ֶ�����bl2.bin
   cd sd_fuse/tiny4412
   ../mkbl2 ../../u-boot.bin bl2.bin 14336

   Ȼ��������������:  
   fastboot flash fwbl1 E4412_N.bl1.bin
   
   fastboot flash bl2 bl2.bin
   
   fastboot flash bootloader ../../u-boot.bin

   fastboot flash tzsw E4412_tzsw.bin 


-----------------------------------------------------
4. ʹ��SD������ Android

a) �����ʹ��HD700������д��ɺ�ֱ������Tiny4412 �����Զ����� Android

b) �����ʹ��S70������Ҫ��uboot������kernel�����в���:
   setenv bootargs console=ttySAC0,115200n8 androidboot.console=ttySAC0 lcd=S70 ctp=3
   saveenv
   Ȼ������Tiny4412���ɡ�

