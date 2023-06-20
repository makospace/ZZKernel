#pragma pack (1) // ��1�ֽڶ���

#include <iostream>
#include <fstream>
using namespace std;

typedef char db;
typedef short dw;
typedef int dd;

struct Header{
	dw jmpShort;//BS_jmpBOOT һ������תָ��
	db nop;
	db BS_OEMName[8];	// ������
	dw BPB_BytesPerSec; //ÿ�����ֽ�����Bytes/Sector��	0x200
	db BPB_SecPerClus;	//ÿ����������Sector/Cluster��	0x1
	dw BPB_ResvdSecCnt;	//Boot��¼ռ�ö�������	ox1
	db BPB_NumFATs;	//���ж���FAT��	0x2
	dw BPB_RootEntCnt;	//��Ŀ¼���ļ������	0xE0
	dw BPB_TotSec16;	//��������	0xB40[2*80*18]
	db BPB_Media;	//����������	0xF0
	dw BPB_FATSz16;	//ÿ��FAT����ռ������	0x9
	dw BPB_SecPerTrk;	//ÿ�ŵ���������Sector/track��	0x12
	dw BPB_NumHeads;	//��ͷ����������	0x2
	dd BPB_HiddSec;	//����������	0
	dd BPB_TotSec32;	//���BPB_TotSec16=0,�����������������	0
	db BS_DrvNum;	//INT 13H����������	0
	db BS_Reserved1;	//������δʹ��	0
	db BS_BootSig;	//��չ�������(29h)	0x29
	dd BS_VolID;	//�����к�	0
	db BS_VolLab[11];	//��� 'wkcn'
	db BS_FileSysType[8];	//�ļ�ϵͳ����	'FAT12'
	db other[448];	//�������뼰��������	�������루ʣ��ռ���0��䣩
	dw _55aa;	//��510�ֽ�Ϊ0x55����511�ֽ�Ϊ0xAA	0xAA55
};

int main(){
	ifstream fin("disk.img",ios::binary);
	Header header;
	fin.read((char*)&header, 512);
	cout << header.BPB_BytesPerSec << endl;
	return 0;
}