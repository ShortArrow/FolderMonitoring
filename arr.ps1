# �z��
$arr = @()

# ���[�U�[��`�I�u�W�F�N�g��ǉ�
$p = @{index=-1; name=""; age=-1}
$arr += New-Object PSObject -Property $p
$arr += New-Object PSObject -Property $p
$arr += New-Object PSObject -Property $p

$arr[0].index = 0
$arr[0].name  = "����������"
$arr[0].age   = 30

$arr[1].index = 1
$arr[1].name  = "����������"
$arr[1].age   = 18

$arr[2].index = 2
$arr[2].name  = "����������"
$arr[2].age   = 99


# �������̕�����������
# �������Aindex �� inde �Ƃ��ɂȂ��Ă��Ă��G���[�ɂ͂Ȃ�Ȃ�
<#
$arr += New-Object PSObject -Property @{index=0; name="����������"; age=30}
$arr += New-Object PSObject -Property @{index=1; name="����������"; age=18}
$arr += New-Object PSObject -Property @{index=2; name="����������"; age=99}
#>

# �\��
$arr | ConvertTo-Json | Out-File .\log\arr.json -Encoding default