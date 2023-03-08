<?php
require 'ApiCore.php';
$core = new ApiCore();
$postData = file_get_contents('php://input');
$data = json_decode($postData, true);


$core->isBlocked();

if(isset($data['login'],$data['secret'])) {
    $codeInfo = R::findone('emailcodes','login = ? AND secret = ?', [$data['login'],$data['secret']]);
    if($codeInfo) {
        if(time() - $codeInfo->time <= 240) {
            $credentials = json_decode($codeInfo['author_credentials'],true);
            $isRealVK = R::findone('vkcodes','vk_id = ?',[$credentials['vk_id']]);
            if($isRealVK) {
                $delete = R::load('vkcodes', $isRealVK->id);
                R::trash($delete);
            }
            $accept_code = mt_rand(100000,999999);
            $bufferCodes = R::dispense('vkcodes');
            $bufferCodes->login = $credentials['login'];
            $bufferCodes->vk_id = $credentials['vk_id'];
            $bufferCodes->secret = $accept_code;
            $bufferCodes->author_credentials = json_encode(array('login' => $credentials['login'], 'nick' => $credentials['nick'], 'email' => $credentials['email']),JSON_UNESCAPED_SLASHES + JSON_UNESCAPED_UNICODE);
            $bufferCodes->time = time();
            R::store($bufferCodes);
            $vk->SendMessage($credentials['vk_id'],"Используйте следующий код для подтверждения входа в ваш профиль. Если вы получили это сообщение случайно - проигнорируйте его.\n\nКод: $accept_code\n\nИнформация:\n— Почта: " . $credentials['email'] . "\n— Логин: " . $data['login'] . "\n— Ник: " . $credentials['nick'] . "\n— Серийный номер " . $credentials['serial']);
            $core->reportError($core::ERROR_SEND_VK,'vk code');
        } else {
            $getMail = R::findone('emailcodes','login = ?',[$data['login']]);
            if($getMail) {
                $delete = R::load('emailcodes', $getMail->id);
                R::trash($delete);
            }
            $core->reportError($core::ERROR_TIMEOUT_CODE,'time out');
        }
    } else {
        $core->reportError($core::ERROR_BAD_CODE,'Unregistered Code');
    }
} else {
    
}