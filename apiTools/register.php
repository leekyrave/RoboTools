<?php

require 'ApiCore.php';
header('Content-Type: application/json');
$postData = file_get_contents('php://input');
$data = json_decode($postData, true);

$core = new ApiCore();

$ipUser = $core->ipUser;
$core->isBlocked();


$serverlist = array(
    '185.169.134.3:7777',
    '185.169.134.4:7777',
    '185.169.134.43:7777',
    '185.169.134.44:7777',
    '185.169.134.45:7777',
    '185.169.134.5:7777',
    '185.169.134.59:7777',
    '185.169.134.61:7777',
    '185.169.134.107:7777',
    '185.169.134.109:7777',
    '185.169.134.166:7777',
    '185.169.134.171:7777',
    '185.169.134.172:7777',
    '185.169.134.173:7777',
    '185.169.134.174:7777',
    '80.66.82.191:7777',
    '80.66.82.190:7777',
    '80.66.82.188:7777',
    '80.66.82.168:7777',
    '80.66.82.159:7777',
);



    $headers = getallheaders();
    if(isset($data['nick']) && isset($data['login']) && isset($data['pass']) && isset($data['ip']) && isset($data['port']) && $data['serial'] && isset($headers['Token']))
    {
        $breakpoint = false;
        $starttim = time();
        for ($i=-30; $i < 60; $i++) { 
            $starttime = $starttim + $i;
            $hash = md5($data['nick'] . $data['login'] . $data['pass'] . $data['ip'] . $data['port'] . $data['serial'] . $starttime);
            if($hash == $headers['Token'])
            {
                $breakpoint = true;
                $callback = md5(md5(md5($hash)));
                break;
            }
        }
        if($breakpoint)
        {
            $flipped = array_flip($serverlist);
            $ipport = $data['ip'] . ':' . $data['port'];
            if($flipped[$ipport] == null)
            {
                $array = array(
                    'error' => '10',
                    'description' => 'Undefined server',
                    'callback' => $callback
                );
                $json = json_encode($array, JSON_UNESCAPED_UNICODE);
                exit($json);
            }

            if(R::findone('tools','login = ?', [$data['login']]))
            {
                $array = array(
                    'error' => '3',
                    'description' => 'This login already exist.',
                    'callback' => $callback,
                );
                $json = json_encode($array, JSON_UNESCAPED_UNICODE);
                exit($json);
            } elseif(R::findone('tools','nick = ?',[$data['nick']]))
            {
                $attached = R::findone('tools','nick = ?',[$data['nick']]);
                $array = array(
                    'error' => '4',
                    'description' => 'This nickname is already attached to other account.',
                    'attachedlogin' => $attached->login,
                    'callback' => $callback
                );
                $json = json_encode($array, JSON_UNESCAPED_UNICODE);
                exit($json);
            } else {
                $u = R::dispense("tools");
                $u->login = $data['login'];
                $u->nick = $data['nick'];
                $u->password = $data['pass'];
                $u->vk_id = '';
                $u->RegIp = $ipUser;
                $u->LastIp = $ipUser;
                $u->RegSerial = $data['serial'];
                $u->LastSerial = $data['serial'];
                $u->RegDate = date("d.m.Y, H:i:s");
                $u->LastAuth = date("d.m.Y, H:i:s");
                $u->server = $flipped[$ipport] + 1;
                $u->block = false;
                $u->points = 0;
                $u->tprogramm = false;
                R::store($u);
                $array = array(
                    'error' => '0',
                    'description' => 'ok',
                    'callback' => $callback
                );
                $json = json_encode($array, JSON_UNESCAPED_UNICODE);
                exit($json);
            }
                        
        } else {
            $array = array(
                'error' => '5',
                'description' => 'Invalid hash',
              );
              $json = json_encode($array, JSON_UNESCAPED_UNICODE);
              exit($json);
        }
    } else {
        $b = R::dispense('banips');
        $b->ip = $ipUser;
        $b->time = date("d.m.Y, H:i:s");
        R::store($b);
        $array = array(
            'error' => '6',
            'description' => 'There are not any parameters. BANHAMMER!'
          );
          $json = json_encode($array, JSON_UNESCAPED_UNICODE);
          exit($json);
    }