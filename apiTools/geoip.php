<?php
require 'ApiCore.php';
header('Content-Type: application/json');

$core = new ApiCore();

$ipUser = $core->ipUser;
$core->isBlocked();

if(isset($_GET['reg']) && isset($_GET['last']))
{
    $requestAPI = getInfoFromHost($_GET['reg'], $_GET['last']);

    $array = array(
        'error' => 0,
        'reg' => array(
            'country' => $requestAPI[0]['country'],
            'city' => $requestAPI[0]['city'],
            'provider' => $requestAPI[0]['provider'],
        ),
        'last' => array(
            'country' => $requestAPI[1]['country'],
            'city' => $requestAPI[1]['city'],
            'provider' => $requestAPI[1]['provider']
        ),
        'distance' => distance($requestAPI[0]['lat'],$requestAPI[0]['lon'],$requestAPI[1]['lat'],$requestAPI[1]['lon'])
    );
    $json = json_encode($array, JSON_UNESCAPED_UNICODE);
    exit($json);
} else {
    $core::reportError($core::ERROR_NOT_ALL_PARAMS,'');
}


function distance($latitudeFrom, $longitudeFrom, $latitudeTo, $longitudeTo, $earthRadius = 6371)
  {
    // convert from degrees to radians
    $latFrom = deg2rad($latitudeFrom);
    $lonFrom = deg2rad($longitudeFrom);
    $latTo = deg2rad($latitudeTo);
    $lonTo = deg2rad($longitudeTo);
  
    $latDelta = $latTo - $latFrom;
    $lonDelta = $lonTo - $lonFrom;
  
    $angle = 2 * asin(sqrt(pow(sin($latDelta / 2), 2) + cos($latFrom) * cos($latTo) * pow(sin($lonDelta / 2), 2)));
    return round($angle * $earthRadius,1);
  }


function getInfoFromHost($first_ip, $second_ip) {
    $html = curl_get_contents("http://ip-api.com/batch", "http://ip-api.com/", 1, 1, 1, array(array("query" => $first_ip, "fields" => "status,message,country,city,lat,lon,org,as,query", "lang" => "ru"), array("query" => $second_ip, "fields" => "status,message,country,city,lat,lon,org,as,query", "lang" => "ru")))[0]['html'];
    $arrayIp = json_decode($html,JSON_UNESCAPED_UNICODE + JSON_UNESCAPED_SLASHES);
    if($arrayIp && $arrayIp[0]['status'] == 'success' && $arrayIp[1]['status'] == 'success') {
        return array(
            array(
            "country" => $arrayIp[0]['country'],
            "city" => $arrayIp[0]['city'],
            "lat" => $arrayIp[0]['lat'],
            "lon" => $arrayIp[0]['lon'],
            "provider" => $arrayIp[0]['as'],
            ),
            array(
                "country" => $arrayIp[1]['country'],
                "city" => $arrayIp[1]['city'],
                "lat" => $arrayIp[1]['lat'],
                "lon" => $arrayIp[1]['lon'],
                "provider" => $arrayIp[1]['as'],
            ),
        );
    } else {
        return array(
            array(
            "country" => "Неизвестно",
            "city" => "Неизвестно",
            "lat" => "Неизвестно",
            "lon" => "Неизвестно",
            "provider" => "Неизвестно",
            ),

            array(
                "country" => "Неизвестно",
                "city" => "Неизвестно",
                "lat" => "Неизвестно",
                "lon" => "Неизвестно",
                "provider" => "Неизвестно",
            ),
        );
    }
}

function curl_get_contents($page_url, $base_url, $pause_time, $retry, $type = 0, $post_array) {
    $error_page = array();
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36 OPR/38.0.2220.41");   
    curl_setopt($ch, CURLOPT_COOKIEJAR, str_replace("\\", "/", getcwd()).'/cookie.txt'); 
    curl_setopt($ch, CURLOPT_COOKIEFILE, str_replace("\\", "/", getcwd()).'/cookie.txt'); 
    
    if($type == '1') {
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($post_array));
    }
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1); 
    curl_setopt ($ch, CURLOPT_SSL_VERIFYPEER, 0); 
    curl_setopt ($ch, CURLOPT_SSL_VERIFYHOST, 0); 
    curl_setopt($ch, CURLOPT_URL, $page_url);
    curl_setopt($ch, CURLOPT_REFERER, $base_url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
    $response['html'] = curl_exec($ch);
    $info = curl_getinfo($ch);
    if($info['http_code'] != 200 && $info['http_code'] != 404) {
        $error_page[] = array(1, $page_url, $info['http_code']);
        if($retry) {
            sleep($pause_time);
            $response['html'] = curl_exec($ch);
            $info = curl_getinfo($ch);
            if($info['http_code'] != 200 && $info['http_code'] != 404)
                $error_page[] = array(2, $page_url, $info['http_code']);
        }
    }
    $response['code'] = $info['http_code'];
    $response['errors'] = $error_page;
    $redirectURL = curl_getinfo($ch, CURLINFO_EFFECTIVE_URL);
    curl_close($ch);
    return [$response,$redirectURL];
}