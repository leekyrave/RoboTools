<?php
require 'ApiCore.php';
header('Content-Type: application/json');
$postData = file_get_contents('php://input');
$data = json_decode($postData, true);
$core = new ApiCore();

$core->isBlocked();

$headers = array_change_key_case(getallheaders());
if(isset($data['serial'],$data['ip'], $data['port'], $data['question'], $data['answer'], $headers['authorization'])) {
    $findToken = R::findone('accounts','auth_token = ?', [$headers['authorization']]);

    if($findToken) {
        if($findToken->expires_time >= time()) {
            $report = R::findone('reports','question = ?',[$data['question']]);
            
            if(!$report)
            {
                $servers = array(
                    '185.169.134.3:7777' => 1,
                    '185.169.134.4:7777' => 2,
                    '185.169.134.43:7777' => 3,
                    '185.169.134.44:7777' => 4,
                    '185.169.134.45:7777' => 5,
                    '185.169.134.5:7777' => 6,
                    '185.169.134.59:7777' => 7,
                    '185.169.134.61:7777' => 8,
                    '185.169.134.107:7777' => 9,
                    '185.169.134.109:7777' => 10,
                    '185.169.134.166:7777' => 11,
                    '185.169.134.171:7777' => 12,
                    '185.169.134.172:7777' => 13,
                    '185.169.134.173:7777' => 14,
                    '185.169.134.174:7777' => 15,
                    '80.66.82.191:7777' => 16,
                    '80.66.82.190:7777' => 17,
                    '80.66.82.188:7777' => 18,
                    '80.66.82.168:7777' => 19,
                    '80.66.82.159:7777' => 20,
                    '80.66.82.200:7777' => 21,
                    '80.66.82.144:7777' => 22,
                    '80.66.82.162:5125' => 101,
                    '80.66.82.148:5125' => 102,
                    '80.66.82.136:5125' => 103,
                    '80.66.82.147:7777' => 201,
                ); 

                
                if(!isset($servers[$data['ip'] . ':' . $data['port']])) {
                    $core->reportError($core::ERROR_UNDEFINED_SERVER,'');    
                }

                $decoded_logs = json_decode($findToken->logs, JSON_UNESCAPED_SLASHES + JSON_UNESCAPED_UNICODE);
                array_push($decoded_logs,array('type' => 'saveReport', 'question' => $data['question'], 'answer' => $data['answer'], 'server' => $servers[$data['ip'] . ':' . $data['port']], 'time' => time()));
                $findToken->logs = json_encode($decoded_logs,JSON_UNESCAPED_UNICODE + JSON_UNESCAPED_SLASHES);
                R::store($findToken);
                $saveReport = R::dispense("reports");
                $saveReport->question = $data['question'];
                $saveReport->answer = $data['answer'];
                $saveReport->server = $servers[$data['ip'] . ':' . $data['port']];
                $saveReport->login = $findToken->login;
                $findToken->ip = $core->ipUser;
                $findToken->ua = $_SERVER['HTTP_USER_AGENT'];
                $saveReport->time = time();
                R::store($saveReport);

                $core->reportError($core::NO_ERROR,'');
            } else {
                $core->reportError($core::ERROR_REPORT_EXIST,'');
            }
        } else {
            $core->reportError($core::ERROR_TIME_TOKEN_EXPIRES,'');
        }
    } else {
        $core->reportError($core::ERROR_UNREGISTERED_TOKEN,'');
    }
} else {
    $core->reportError($core::ERROR_NOT_ALL_PARAMS,'');
}