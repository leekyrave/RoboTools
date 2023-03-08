<?php
require 'ApiCore.php';
$core = new ApiCore();
$postData = file_get_contents('php://input');
$data = json_decode($postData, true);


$core->isBlocked();

if(isset($data['login'],$data['password'], $data['serial'])) {
    $findLogin = R::findone('accounts', 'login = ?', [$data['login']]);
    if($findLogin) {
        if($findLogin->password == md5($data['password'] . 'lol-cringe-salt')) {
            if(($findLogin->last_ip == $core->ipUser && ($findLogin == 0 || $findLogin->last_serial == $data['serial'])) || !$findLogin->accept_security) {
                $time_cookie = time();
                $auth_token = sha1($findLogin->login) . '.' . sha1($findLogin->email) . '.' . sha1($findLogin->vk_id) . '.' . sha1($findLogin->password) . '.' . sha1('mini-secret-key' . $time_cookie);
                $findLogin->auth_token = $auth_token;
                $findLogin->expires_time = $time_cookie + 60*60*24*365;
                $findLogin->last_time = time();
                $decoded_login_logs = json_decode($findLogin->login_logs,JSON_UNESCAPED_SLASHES + JSON_UNESCAPED_UNICODE);
                array_push($decoded_login_logs,array('ip' => $core->ipUser, 'ua' => $_SERVER['HTTP_USER_AGENT'], 'time' => time()));
                $findLogin->login_logs = json_encode($decoded_login_logs, JSON_UNESCAPED_UNICODE + JSON_UNESCAPED_SLASHES);
                R::store($findLogin);
                $arrayResponse = array(
                    'error' => 0,
                    'token' => $auth_token,
                );
                exit(json_encode($arrayResponse,JSON_UNESCAPED_SLASHES + JSON_UNESCAPED_UNICODE));
            } else {
                
                $isRealMail = R::findone('emailcodes','email = ?',[$findLogin->email]);
                if($isRealMail) {
                    $delete = R::load('emailcodes', $isRealMail->id);
                    R::trash($delete);
                }
                
                $accept_code = mt_rand(100000,999999);
                $bufferCodes = R::dispense('emailcodes');
                $bufferCodes->login = $data['login'];
                $bufferCodes->email = $findLogin->email;
                $bufferCodes->secret = $accept_code;
                $bufferCodes->author_credentials = json_encode(array('login' => $data['login'], 'nick' => $findLogin->nick, 'vk_id' => $findLogin->vk_id, 'email' => $findLogin->email, 'serial' => $data['serial']),JSON_UNESCAPED_SLASHES + JSON_UNESCAPED_UNICODE);
                $bufferCodes->time = time();
                R::store($bufferCodes);
                mail($findLogin->email, 'Подтверждение почты', "Ваш IP сменился\nВаш код: " . $accept_code . "\nКод будет действовать в течении 4-ех минут.", array('MIME-Version' => '1.0','From' => 'webmaster@mint-plantation.ru','Cc' => 'webmaster@mint-plantation.ru','Bcc' => 'webmaster@mint-plantation.ru','X-Mailer' => 'PHP/' . phpversion()));
                $core->reportError($core::ERROR_SEND_EMAIL,'');
            }
        } else {
            $core->reportError($core::EROR_WRONG_PASSWORD,'');
        }
    } else {
        $core->reportError($core::ERROR_NO_LOGIN,'');
    }
} else {
    $core->reportError($core::ERROR_NOT_ALL_PARAMS,'');
}