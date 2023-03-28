function Edit-RaveUser {
    <#
        .SYNOPSIS
            This function updates a user on getrave.com
        .DESCRIPTION
           This function updates a user. Requires first name, last name, email, phone number and valid api credentials. Phone number must be digits only.
        .EXAMPLE
            Edit-RaveUser -FirstName 'Test' -LastName 'User' -Email 'tuser@barstow.edu' -token $token -phoneNumber 7602522411

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
        [int64]$phoneNumber,
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
                    `n <mobileNumber1>$phoneNumber</mobileNumber1>
                `n</raveUser>"

    $restArgs = @{
        'URI'     = "$URI/user"
        'Headers' = $headers
        'Body'    = $body
        'Method'  = 'PUT'
    }

    $results = Invoke-RestMethod @restArgs
    Return $results
}