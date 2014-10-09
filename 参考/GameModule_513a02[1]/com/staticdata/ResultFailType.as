package com.staticdata
{

    public class ResultFailType extends Object
    {
        public static const types:Object = {1:"技能冷却中", 2:"玩家已经死亡", 3:"定身或睡眠中", 4:"游泳中", 5:"技能没用找到 model", 6:"攻击者（玩家）技能不对", 7:"攻击者（玩家）非主动技能", 8:"是否人物技能", 9:"monster.isDie", 10:"script.check", 11:"目标检查 （单体目标且对象不为自己时） 请先选定一个释放目标", 12:"目标不符，无法释放", 13:"CHANGEMAP", 14:"mapno", 15:"本地图不能使用此技能", 16:"超出攻击距离", 17:"Mpno //消耗检查 //内力不足", 18:"公共冷却检查", 19:"跳跃状态不能攻击 JUMP", 20:"是否范围技能", 21:"是否范围技能无行走路径", 22:"攻击者（玩家）变身技能不对"};
        public static const cooldown:uint = 1;
        public static const isDie:uint = 2;
        public static const DINGSHENSHUIMIAN:uint = 3;
        public static const SWIM:uint = 4;
        public static const modelnull:uint = 5;
        public static const defaultstudyno:uint = 6;
        public static const triggertypeno:uint = 7;
        public static const skilluserno:uint = 8;
        public static const monsterisDie:uint = 9;
        public static const scriptcheckno:uint = 10;
        public static const shapetargetno:uint = 11;
        public static const targetno:uint = 12;
        public static const CHANGEMAP:uint = 13;
        public static const mapno:uint = 14;
        public static const mapskillno:uint = 15;
        public static const rangelimit:uint = 16;
        public static const Mpno:uint = 17;
        public static const SKILLPUBLICNO:uint = 18;
        public static const JUMPNO:uint = 19;
        public static const areashapesingle:uint = 20;
        public static const noroads:uint = 21;

        public function ResultFailType()
        {
            return;
        }// end function

        public static function getMsg(param1:uint) : String
        {
            return types[param1];
        }// end function

    }
}
