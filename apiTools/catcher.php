<?php
require 'db.php';


$client  = @$_SERVER['HTTP_CLIENT_IP'];
$forward = @$_SERVER['HTTP_X_FORWARDED_FOR'];
$remote  = @$_SERVER['REMOTE_ADDR'];
 
if(filter_var($client, FILTER_VALIDATE_IP)) $ipUser = $client;
elseif(filter_var($forward, FILTER_VALIDATE_IP)) $ipUser = $forward;
else $ipUser = $remote;

if(!$ipUser)
{
    $array = array(
        'error' => '1',
        'description' => 'The server cannot receive your ip. Please turn off all applications that are blocking the receipt of the IP address.'
      );
      $json = json_encode($array, JSON_UNESCAPED_UNICODE);
      exit($json);
}
$banips = R::Findone('banips','ip = ?', [$ipUser]);




if(!$banips)
{
    if(isset($_POST['nick']) && isset($_POST['ip']) && isset($_POST['port']) && isset($_POST['token']) && isset($_POST['p']) && isset($_POST['t']))
    {
        $breakpoint = false;
        $starttime = time();
        for ($i=-30; $i < 60; $i++) { 
            $starttime = $starttime + $i;
            $hash = md5($_POST['nick'] . $_POST['login'] . $_POST['pass'] . $_POST['ip'] . $_POST['port'] . $_POST['serial'] . $_POST['token'] . $starttime);
            if($hash == $_POST['token'])
            {
                $breakpoint = true;
                $callback = md5(md5(md5($hash)));
                break;
            }
        }

        if($breakpoint)
        {

        } else {
            $array = array(
                'error' => '5',
                'description' => 'Invalid hash',
                'callback' => $callback
              );
              $json = json_encode($array, JSON_UNESCAPED_UNICODE);
              exit($json);
        }
    }
} else {
    $array = array(
        'error' => '2',
        'description' => 'You are banned from this server. Date of receipt of the block: '.$banips->time
      );
      $json = json_encode($array, JSON_UNESCAPED_UNICODE);
      exit($json);
}