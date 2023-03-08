<?php
$array = array(
    'listLibs' => array(
        ['fa-solid-900.ttf','\\resource\\fonts\\fa-solid-900.ttf','https://api.mint-plantation.ru/data/fonts/fa-solid-900.ttf'],
        ['effil.lua','\\lib\\effil.lua','https://api.mint-plantation.ru/data/libs/effil.lua'],
        ['libeffil.dll','\\lib\\libeffil.dll','https://api.mint-plantation.ru/data/libs/libeffil.dll'],
        ['md5.lua','\\lib\\md5.lua','https://api.mint-plantation.ru/data/libs/md5.lua'],
        ['core.dll','\\lib\\md5\\core.dll','https://api.mint-plantation.ru/data/libs/md5/core.dll'],
        ['inicfg.lua','\\lib\\inicfg.lua','https://api.mint-plantation.ru/data/libs/inicfg.lua'],
        ['keys.lua','\\lib\\game\\keys.lua','https://api.mint-plantation.ru/data/libs/keys.lua'],
        ['encoding.lua','\\lib\\encoding.lua','https://api.mint-plantation.ru/data/libs/encoding.lua'],
        ['fAwesome5.lua','\\lib\\fAwesome5.lua','https://api.mint-plantation.ru/data/libs/fAwesome5.lua'],
        ['rkeys.lua','\\lib\\rkeys.lua','https://api.mint-plantation.ru/data/libs/rkeys.lua'],
        ['memory.lua','\\lib\\memory.lua','https://api.mint-plantation.ru/data/libs/memory.lua'],
        ['matrix3x3.lua','\\lib\\matrix3x3.lua','https://api.mint-plantation.ru/data/libs/matrix3x3.lua'],
        ['vector3d.lua','\\lib\\vector3d.lua','https://api.mint-plantation.ru/data/libs/vector3d.lua'],
        ['imgui_addons.lua','\\lib\\imgui_addons.lua','https://api.mint-plantation.ru/data/libs/imgui_addons.lua'],
    ),
    
    'listFiles' => 
);
echo json_encode($array);
?>