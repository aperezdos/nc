## Variables for domain name and ip address uses in proxy configuration

$domain_name = {"return" => "domain.com"}
$ip_address_1 = {"return" => "http://x.x.x.x/"}
$ip_address_2 = {"return" => "http://x.x.x.x/"}
$resource_2 = {"return" => "resource2"}


## Install nginx

  class{"nginx":

}



## Create a proxy to redirect requests to https://domain.com to some IP and redirect requests to https://domain.com/resoure2 to some other IP.

nginx::resource::location{'/':
    ssl => 'true',
    proxy => $ip_address_1' ,
    server => $domain_name,

  }

nginx::resource::location{'/$resource_2':
    ssl => 'true',
    proxy => $ip_address_2' ,
    server => $domain_name,

  }


## Create a forward proxy to log http requests going from the internal network to the Internet

## Create a forward proxy http

nginx::resource::server { :
    listen_port => 80,
    resolver => '8.8.8.8',
    proxy => 'http://$http_host$uri$is_args$args',
}

## Log http requests
## modules/puppet-nginx-0.71/files/proxies_acl.conf has to be modified with the value of local network

file { '/etc/nginx/conf.d/proxies_acl.conf' :
   ensure => present,
   source => "puppet:///modules/puppet-nginx-0.71/files/proxies_acl.conf",
}
}


