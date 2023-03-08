<?php
require 'ApiCore.php';
$core = new ApiCore();
$postData = file_get_contents('php://input');
$data = json_decode($postData, true);

$core->checkRefer();
$core->isBlocked();


if(isset($data['nick'],$data['login'],$data['vk_id'],$data['password'])) {

    if(iconv_strlen($data['nick']) < 3 or iconv_strlen($data['nick']) > 32) {
        $core->reportError($core::ERROR_UNALLOWED_LENGTH,'');
    }

    if(iconv_strlen($data['login']) < 4 or iconv_strlen($data['login']) > 32) {
        $core->reportError($core::ERROR_UNALLOWED_LENGTH,'');
    }

    if(iconv_strlen($data['vk_id']) < 16 or iconv_strlen($data['vk_id']) > 100) {
        $core->reportError($core::ERROR_UNALLOWED_LENGTH,'');
    }

    if(!preg_match('/^[A-Za-z0-9\._\$@=\(\)\[\]]{3,20}$/',$data['nick'])) {
        $core->reportError($core::ERROR_UNCORRECT_NICK,'');
    }

    if(preg_match('/^https?:\/\/?(www\.)?vk\.com\/([\w|\d]+?)\/?$/',$data['vk_id'],$foo)) {
        $userInfo = $vk->request("users.get", ["user_ids" => $foo[2]]);
        $data['vk_id'] = $userInfo[0]['id'];
        if(!$data['vk_id']) {
            $core->reportError($core::ERROR_UNCORRECT_VK,'');
        }
    } else {
        $core->reportError($core::ERROR_UNCORRECT_VK,'');
    }



    if(R::findone('accounts','login = ?',[$data['login']])) {
        $core->reportError($core::ERROR_LOGIN_EXIST,'');
    }

    if(R::findone('accounts','nick = ?',[$data['nick']])) {
        $core->reportError($core::ERROR_NICK_EXIST,'');
    }

    if(iconv_strlen($data['password']) < 4 or iconv_strlen($data['password']) > 32) {
        $core->reportError($core::ERROR_UNALLOWED_LENGTH,'');
    }
    
    if(R::findone('accounts','vk_id = ?',[$data['vk_id']])) {
        $core->reportError($core::ERROR_VK_EXIST,'');
    }

    $getVk = R::findone("vkcodes", 'vk_id = ?', [$data['vk_id']]);
    if($getVk) {
        $delete = R::load('vkcodes', $getVk->id);
        R::trash($delete);
    }

    $accept_code = mt_rand(100000,999999);
    $bufferCodes = R::dispense('vkcodes');
    $bufferCodes->login = $data['login'];
    $bufferCodes->vk_id = $data['vk_id'];
    $bufferCodes->nick = $data['nick'];
    $bufferCodes->password = md5($data['password'] . 'lol-cringe-salt');
    $bufferCodes->secret = $accept_code;
    $bufferCodes->time = time();
    R::store($bufferCodes);
    $errors = $vk->SendMessage($data['vk_id'],"Используйте следующий код для подтверждения вашего VK при регистрации на robo-tools.online. Если вы получили это сообщение случайно - проигнорируйте его.\n\nКод: $accept_code\n\nИнформация:\n— Логин: " . $data['login'] . "\n— Ник: " . $data['nick']);
    if($errors['error']['error_code'] == 901) {
        $core->reportError($core::ERROR_VK_ERROR_NO_CONTACT,'');
    }
    $core->reportError($core::NO_ERROR,"");
} else {
    $core->reportError($core::ERROR_NOT_ALL_PARAMS,'');
}