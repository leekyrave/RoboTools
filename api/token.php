<?php
require 'ApiCore.php';
$core = new ApiCore();
$postData = file_get_contents('php://input');
$data = json_decode($postData, true);

$core->checkRefer();
$core->isBlocked();

if(isset($data['login'],$data['password'])) {
    $findLogin = R::findone('accounts', 'login = ?', [$data['login']]);
    if($findLogin) {
        if($findLogin->password == md5($data['password'] . 'lol-cringe-salt')) {
            if($findLogin->last_ip == $core->ipUser || !$findLogin->accept_security) {
                $time_cookie = time();
                $auth_token = sha1($findLogin->login) . '.' . sha1($findLogin->vk_id) . '.' . sha1($findLogin->password) . '.' . sha1('mini-secret-key' . $time_cookie);
                $findLogin->auth_token = $auth_token;
                $findLogin->expires_time = $time_cookie + 60*60*24*365;
                $findLogin->last_time = time();
                if($findLogin->login_logs != "null") {
                    $decoded_login_logs = json_decode($findLogin->login_logs,JSON_UNESCAPED_SLASHES + JSON_UNESCAPED_UNICODE);
                } else {
                    $decoded_login_logs = array();
                }
                
                array_push($decoded_login_logs,array('ip' => $core->ipUser, 'ua' => $_SERVER['HTTP_USER_AGENT'], 'time' => time()));
                $findLogin->login_logs = json_encode($decoded_login_logs, JSON_UNESCAPED_UNICODE + JSON_UNESCAPED_SLASHES);
                R::store($findLogin);
                setcookie('auth.token',$auth_token, $time_cookie + 60*60*24*365, "/", NULL);
                setcookie('auth.create-time',$time_cookie,$time_cookie + 60*60*24*365, "/", NULL);
                setcookie('auth.always-sign-in','1',$time_cookie + 60*60*24*365*365, "/", NULL);
                $core->reportError($core::NO_ERROR,'');
            } else {
                
                $isRealVK = R::findone('vkcodes','vk_id = ?',[$findLogin->vk_id]);
                if($isRealVK) {
                    $delete = R::load('vkcodes', $isRealVK->id);
                    R::trash($delete);
                }
                $accept_code = mt_rand(100000,999999);
                $bufferCodes = R::dispense('vkcodes');
                $bufferCodes->login = $findLogin->login;
                $bufferCodes->vk_id = $findLogin->vk_id;
                $bufferCodes->secret = $accept_code;
                $bufferCodes->time = time();
                R::store($bufferCodes);
                $vk->SendMessage($findLogin->vk_id,"Используйте следующий код для подтверждения входа в ваш профиль VK. Если вы получили это сообщение случайно - проигнорируйте его.\n\nКод: $accept_code\n\nИнформация:\n— Логин: " . $findLogin->login . "\n— Ник: " . $findLogin->nick);
                $core->reportError($core::ERROR_SEND_VK,'vk code');
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