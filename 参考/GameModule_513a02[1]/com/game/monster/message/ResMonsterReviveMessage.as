package com.game.monster.message
{
    import com.game.map.bean.*;
    import net.*;

    public class ResMonsterReviveMessage extends Message
    {
        private var _monster:CSMonsterInfo;

        public function ResMonsterReviveMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._monster);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._monster = readBean(CSMonsterInfo) as CSMonsterInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 114109;
        }// end function

        public function get monster() : CSMonsterInfo
        {
            return this._monster;
        }// end function

        public function set monster(param1:CSMonsterInfo) : void
        {
            this._monster = param1;
            return;
        }// end function

    }
}
