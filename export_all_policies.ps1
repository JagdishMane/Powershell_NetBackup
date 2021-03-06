#----------------------------------------------
# Name:           get_all_policies
# Version:        1.0.0.0
# Start date:     04.04.2014
# Release date:   04.04.2014
# Description:    
#
# Author:         George Dicu
# Department:     Cloud 
#----------------------------------------------

cd\

$nbpath = "C:\Program Files\Veritas\NetBackup\bin\admincmd"

if (Test-Path $nbpath) {
    
    Write-Host "chose full-path where to save the csv file"
    $path = Read-Host
    
    cd $nbpath

    $Policies = @()
    $allpolicies = .\bppllist -L -allpolicies

    $pn = $allpolicies -match "Policy Name"
    $pt = $allpolicies -match "Policy Type"
    #$sm = $allpolicies -match "Snapshot Method"
    $active = $allpolicies -match "Active"
    #$cbmr = $allpolicies -match "Collect BMR Info"
    #$dcls = $allpolicies -match "Data Classification"
    #$vp = $allpolicies -match "Volume Pool:       "
    #$sg = $allpolicies -match "Server Group"
    #$useac = $allpolicies -match "Use Accelerator"
    #$include = $allpolicies -match "Include"
    #$residence = $allpolicies -match "Residence"

    $length = $pn.Length

    for ($i=0;$i -le $length-1;$i++) {

        $PropertyHash = @{}
        $PropertyHash +=  @{
            "PolicyName" = $pn[$i].split(" ")[-1]
            "PolicyType" = $pt[$i].split(" ")[-2]
            "Active" = $active[$i].split(" ")[-1]
        }
        $Policies += New-Object -TypeName PSObject -Property $PropertyHash
    }

    $Policies | Export-Csv -Path "$path" -NoTypeInformation

}
else {
    write-host "This script can only run on Netbackup Windows Servers"
}