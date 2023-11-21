
# Getting the Service CSV
$Services = Import-CSV -Path $PSScriptRoot\services.csv 


# Placeholder HashTable that will be used to tie services to servers
$ServicesPerServer = @{}


Write-Host $Services.Server "------------------------"
foreach ($Server in $Services.Server)
{

    # Checks if the server is already in the hashtable. This saves some time as
    # there are not redundant loops.
    if ($ServicesPerServer.ContainsKey($Server)){
         continue
    }


    # Holds a list of all services that are associated with a server.
    # Will be appended to the $ServicesPerServer as a value
    $ServiceList = @()
    
        # Iterating through all the Services from the CSV
        foreach($Service in $Services)
        {
            
            # If this iteration's Server column in the CSV is equal to the 
            # Server that we are iterating in the parent loop, append to the
            # $ServiceList array
            if ($Server -eq $Service.Server)
            {
                $ServiceList += $Service.Service
            }
        }

    # Append the completed list to the hashtable as a value to the server
    $ServicesPerServer[$Server] = $ServiceList
    
}

# Iterate through services attached to each server
foreach ($Server in $ServicesPerServer.GetEnumerator())
{
    
    
    if (test-connection $Server.Key -count 1)
    {
        #Placeholder Variable for Pretty Printing
        $ServiceStatus = @{}

        # Letting user know the server was succesfully pinged
        Write-Host $Server.Key " successfully pinged"


        # Iterating through the nested list value of $Server
        foreach($Service in $Server.Value)
        {

                # Setting variable for the Get-Service cmdlet and selecting only the name and status
                $SelectedService = Get-Service -ComputerName $Server.Key -Name $Service | Select Name, Status

                # Appending this to our $ServerStatus Placeholder for future Pretty Printing to the console
                $ServiceStatus[$SelectedService.Name] = $SelectedService.Status
        }


        # Enumerate and Pretty Print to the console
        $ServiceStatus.GetEnumerator().ForEach({"Service '$($_.Key)' is: $($_.Value)"})

        # Add new lines for pretty printing
        Write-Host "`n`n"

    }


    else
    {
        Write-Host "$($Server.Key) did not ping succesfully"
    }

}

