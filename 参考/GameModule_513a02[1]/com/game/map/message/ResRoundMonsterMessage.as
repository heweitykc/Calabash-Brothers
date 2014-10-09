package com.game.map.message
{
    import com.game.map.bean.*;
    import net.*;

    public class ResRoundMonsterMessage extends Message
    {
        private var _monster:CSMonsterInfo;

        public function ResRoundMonsterMessage()
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
            return 101102;
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
