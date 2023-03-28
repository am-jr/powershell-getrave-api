function New-RaveUser {
    <#
        .SYNOPSIS
            This function creates a user on getrave.com
        .DESCRIPTION
           This function creates a user. Requires first name, last name, email, and valid api credentials.
        .EXAMPLE
            New-RaveUser -FirstName 'Test' -LastName 'User' -Email 'tuser@barstow.edu' -token $token

    #>
    [CmdletBinding()]
    param (
        [parameter(mandatory = $true)]
        [string]$FirstName,
        [parameter(mandatory = $true)]
        [string]$LastName,
        [parameter(mandatory = $true)]
        [string]$Email,
        [parameter(mandatory = $true)]
        $token,
        [string]$URI = 'https://www.getrave.com/remoteservices/rest'
    )

    $headers = @{
        'Content-Type'  = 'application/xml'
        'Authorization' = "Basic $token"
    }

    $body = "<?xml version=`"1.0`" encoding=`"UTF-8`"?>
                `n<raveUser>
                    `n <firstName>$FirstName</firstName>
                    `n <lastName>$LastName</lastName>
                    `n <email>$Email</email>
                `n</raveUser>"

    $restArgs = @{
        'URI'     = "$URI/user"
        'Headers' = $headers
        'Body'    = $body
        'Method'  = 'POST'
    }

    $results = Invoke-RestMethod @restArgs
    Return $results
}
